program ejercicio1; 
type 
    empleado = record
        cod : integer; 
        monto : real; 
        nombre: string; 
    end; 
    
    typeEmpleado = file of empleado; 

procedure leer (var arch: textfile ; var e: empleado); 
begin
    if (not eof (arch)) then 
        read(arch,e.cod,e.monto,e.nombre); 
end; 

procedure compactarArchivo (var arch:textfile ; var fEmpleados:typeEmpleado); 
var 
    e,eAnt:empleado; 
    codAct: integer; 
    mTotal: real; 
    nombre: string; 
begin 
    leer(arch,e); 
    while (not eof(arch)) do begin 
        codAct := e.cod;
        mTotal := 0;  
        nombre := e.nombre; 
        while (codAct = e.cod) do begin  
            mTotal := mTotal + e.monto;
            leer(arch,e); 
        end;     
        eAnt.monto := mTotal; 
        eAnt.nombre := nombre;
        eAnt.cod := codAct; 
        write(fEmpleados,eAnt); 
    end; 
    write (fEmpleados,e); 
    close (arch); 
    close (fEmpleados);
end; 

var 
    fileEmp : textfile; 
    fEmpleados : typeEmpleado; 
    e:empleado; 
begin
    assign (fileEmp,'empleados.txt'); 
    reset(fileEmp); 
    assign (fEmpleados,'nuevoEmpleados.txt'); 
    rewrite (fEmpleados); 
    compactarArchivo (fileEmp,fEmpleados); 
    reset(fEmpleados); 
    while (not eof(fEmpleados)) do begin
        read (fEmpleados,e); 
        writeln('Nombre: ',e.nombre); 
        writeln('Codigo de empleado: ',e.cod); 
        writeln('Monto Total de comisiones: ',e.monto :2:2);
        writeln('....................................'); 
    end;  
    close(fEmpleados); 
end. 
