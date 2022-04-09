program Eje7prac1; 
type
    novela = record
        cod:integer; 
        nombre:string; 
        genero:string; 
        precio:real; 
    end; 

    typeNovela = file of novela; 

procedure mensajes (); 
begin 
    writeln ('1. Importar archivo .txt'); 
    writeln ('2. Agregar una novela'); 
    writeln ('3. Editar novela'); 
    writeln ('4. Ver novelas disponibles'); 
    writeln ('5. Cerrar el programa'); 
end;

procedure importarArchivo(var arch:typeNovela);
var
    name:string; 
    novelas:textfile; 
    nove:novela; 
begin 
    write('Ingrese el nombre del archivo: '); readln(name); 
    assign(novelas,'novelas.txt'); 
    assign(arch,name); 
    reset(novelas); 
    rewrite(arch); 
    while (not eof(novelas)) do begin 
        readln (novelas,nove.cod,nove.precio,nove.nombre); 
        readln (novelas,nove.nombre);
        write  (arch,nove); 
    end; 
    writeln('-El archivo se inporto correctamente-'); 
    close(novelas);
    close(arch);
end; 

procedure leerNovela (var nove:novela);
begin 
    write('Cod: ');readln (nove.cod); 
    write('Nombre: ');readln (nove.nombre);
    write('Precio: ');readln (nove.precio);
    write('Genero: ');readln (nove.genero);
end; 

procedure agregarUnaNovela (var arch:typeNovela);
var
    nove:novela; 
begin
    leerNovela (nove); 
    reset(arch); 
    seek (arch,fileSize(arch)); 
    write (arch,nove);
    writeln('La novela se cargo con exito'); 
    close(arch); 
end; 

procedure buscarNovela (var arch:typeNovela; var pos:integer; codigo:integer); 
var 
    nove:novela; 
begin
    pos:= -1;  
    while ((pos = -1) and (not eof(arch))) do begin
        read (arch,nove); 
        if (nove.cod = codigo) then 
            pos:= (filePos(arch)-1); 
    end; 
    if (pos=-1) then 
        writeln('El codigo ingresado no coincide con ninguna novela')
end; 

procedure cambiarNombre (var nove:novela); 
var 
    nombre:string; 
begin 
    write ('Nuevo nombre: '); readln (nombre); 
    nove.nombre := nombre;
end; 

procedure cambiarPrecio (var nove:novela); 
var 
    precio:real; 
begin 
    write ('Nuevo precio: '); readln (precio); 
    nove.precio:=precio;
end; 

procedure cambiarGenero (var nove:novela); 
var 
    genero:string; 
begin 
    write ('Nuevo genero: '); readln (genero); 
    nove.genero:= genero
end; 

procedure modificar (var nove:novela); 
var
    n,ok:integer; 
begin
    ok:=1; 
    while ( ok=1) do begin 
        writeln('Seleccione el campo que desea editar ');  
        writeln ('1.Nombre: ');
        writeln ('2.Precio: ');
        writeln ('3.Genero: ');
        writeln ('4.cerrar');     
        write(':'); readln (n); 
        case n of 
            1:  cambiarNombre (nove);
            2:  cambiarPrecio (nove); 
            3:  cambiarGenero (nove); 
            4: ok:=0; 
        end; 
    end; 
end; 

procedure editarDatosDeNovela (var arch:typeNovela); 
var
    pos:integer; 
    nove:novela; 
    codigo:integer; 
begin
    reset (arch); 
    write ('Ingrese el codigo de la pelicula que deseea: '); readln (codigo);
    buscarNovela (arch,pos,codigo); 
    if (pos <> -1 ) then begin
        seek(arch,pos); 
        read(arch,nove); 
        modificar(nove);
        seek (arch,filePos(arch)-1); 
        write (arch,nove);  
    end; 
    close(arch); 
end; 

procedure imprimirNovelas (var arch: typeNovela); 
var 
    nove:novela; 
begin 
    reset (arch); 
    writeln ('-Novelas disponibles-'); 
    while (not eof (arch)) do begin 
        read (arch,nove); 
        writeln (nove.nombre);
        writeln (nove.precio:3:3);
        writeln (nove.genero);
        writeln (nove.cod); 
        writeln('----------------------'); 
    end; 
    close(arch); 
end; 
var
    fNovelas: typeNovela; 
    n:integer; 
begin
    while (true) do begin 
        mensajes(); 
        readln(n); 
        case n of 
            1:  importarArchivo (fNovelas);
            2:  agregarUnaNovela (fNovelas);
            3:  editarDatosDeNovela (fNovelas); 
            4:  imprimirNovelas (fnovelas); 
            5:  exit()
            else
                writeln ('Opcion invalida'); 
        end; 
    end; 
end. 

