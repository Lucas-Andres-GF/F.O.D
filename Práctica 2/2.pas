program ejercicio2; 
const 
    valor_alto = 9999; 
type 
    alumno = record
        cod: integer; 
        cantFinal : integer; 
        cantCursada: integer; 
        nombre : string; 
    end;     

    materias = record
        cod : integer; 
        aprobo: char; 
    end; 

    maestro = file of alumno;
    detalle = file of materias; 

procedure leerAlumno (var reg:alumno); 
begin
    write('Cod: '); readln(reg.cod); 
    if (reg.cod <> -1)then begin
        write('nombre: '); readln(reg.nombre); 
        write('Cant. de Finales: '); readln(reg.cantFinal); 
        write('Cant. de Cursadas: '); readln(reg.cantCursada); 
    end;
end;

procedure crearMaestro (var mae: maestro); 
var 
    reg : alumno; 
begin 
    writeln('---------------Maestro---------------------'); 
    rewrite(mae); 
    leerAlumno (reg); 
    while (reg.cod <> -1) do begin 
        write (mae,reg);
        leerAlumno(reg); 
    end; 
    close(mae); 
end;

procedure leerDetalle (var regD: materias); 
begin 
    write('Cod: '); readln(regD.cod); 
    if (regD.cod <> -1)then 
        write('Aprobo: '); readln(regD.aprobo); 
end; 

procedure crearDetalle (var det:detalle); 
var 
    regD: materias; 
begin 
    writeln('---------------Detalle---------------------'); 
    rewrite(det); 
    leerDetalle (regD);    
    while (regD.cod <> -1) do begin 
        write (det,regD);
        leerDetalle(regD); 
    end; 
    close(det); 
end; 

procedure leer (var arch: detalle; var dato: materias); 
begin
    if (not eof(arch)) then 
        read(arch,dato)
    else
        dato.cod := valor_alto; 
end; 

procedure actualizarMaestro (var mae: maestro ; var det: detalle); 
var 
    regM: alumno; 
    regD: materias;  
    codAct: integer; 
    matFinal, matCursada:integer; 
begin 
    reset (mae); 
    reset (det); 
    read(mae,regM); 
    leer(det,regD);  
    while (regD.cod <> valor_alto) do begin 
        codAct := regD.cod; 
        matFinal:= 0; 
        matCursada:= 0; 
        while (codAct = regD.cod) do begin 
            if (regD.aprobo = 'F')or(regD.aprobo = 'f') then
                matFinal := matFinal  + 1
            else
                if (regD.aprobo = 'C')or(regD.aprobo = 'c')then
                matCursada :=  matCursada + 1; 
            leer (det,regD); 
        end; 
        while (regM.cod <> codAct) and (not eof(mae))do
            read(mae,regM);     
        regM.cantFinal := regM.cantFinal + matFinal; 
        regM.cantCursada := regM.cantCursada + matCursada; 
        seek(mae,filepos(mae)-1); 
        write(mae,regM); 
        if (not eof(mae))then
            read(mae,regM);     
    end;  
    close(mae); 
    close(det); 
end; 

procedure verMaestro (var mae:maestro); 
var 
    regM: alumno;
begin 
    writeln('---------------Maestro---------------------');
    reset(mae); 
    while (not eof(mae))do begin
        read(mae,regM); 
        write(regM.cod,' '); 
        write(regM.cantFinal,' ');
        write(regM.cantCursada,' ');
        write(regM.nombre,' '); 
        writeln(''); 
    end; 
    close(mae);
end; 
var 
    mae : maestro; 
    det : detalle; 
    alumnos : textfile; 
begin 
    assign (mae,'maestro'); 
    assign (det,'detalle'); 
    crearMaestro (mae); 
    crearDetalle (det); 
    actualizarMaestro (mae,det); 
    verMaestro (mae); 
end. 