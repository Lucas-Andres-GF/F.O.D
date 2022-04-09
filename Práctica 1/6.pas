program Eje6prac1; 
type 
    celular=record
        cod:integer; 
        precio:real;
        marca:string;    
        stock:integer; 
        stockMin:integer;
        descripcion:string; 
        nombre:string;
    end; 

    typeCel= file of celular; 

procedure mensajes ();
begin 
    writeln('1.Crear un archivo e importar el contenido de un archivo .txt'); 
    writeln('2.Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
    writeln('3.Listar en pantalla los celulares del archivo cuya descripcion contenga una cadena de caracteres proporcionada por el usuario');
    writeln('4.Exportar a un .txt');
    writeln('5.Agregar celular'); 
    writeln('6.Modificar stock de algun equipo'); 
    writeln('7.Obtener los celulares con 0 stock'); 
    writeln('8.Cerrar el programa'); 
end; 

procedure imprimirCelular (var cel:celular); 
begin 
    writeln ('Nombre: ',cel.nombre);
    writeln ('Marca: ',cel.marca);
    writeln ('Precio: ',cel.precio:3:3);
    writeln ('Descripcion: ',cel.descripcion);
    writeln ('Stock disponible: ',cel.stock);
    writeln ('Stock minimo: ',cel.stockMin); 
    writeln('--------------------------------'); 
end; 

procedure importarCelulares(var arch:typeCel); 
var
    cel:celular; 
    fTxt: textfile;
    name:string; 
begin 
    write('Ingrese un nombre para su archivo: ');readln(name);
    assign(arch,name);
    assign(fTxt, 'celulares.txt'); 
    reset(fTxt); 
    rewrite(arch); 
    while (not eof(fTxt)) do begin
        readln(fTxt,cel.cod,cel.precio,cel.marca); 
        readln(fTxt,cel.stock,cel.stockMin,cel.descripcion); 
        readln(fTxt,cel.nombre); 
        write(arch,cel); 
    end; 
    close(fTxt); 
    close(arch); 
    writeln('-El archivo fue importado con exito-'); 
end; 

procedure mostrarSinStockAdecuado(var arch:typeCel); 
var
    cel:celular; 
begin
    reset(arch); 
    writeln('-Celulares que poseen un stock menor al adecuado-'); 
    while (not eof(arch)) do begin 
        read (arch,cel); 
        if (cel.stock < cel.stockMin) then begin 
           imprimirCelular(cel)
        end; 
    end; 
    close(arch); 
end; 

procedure mostarSegunDescripcion(var arch:typeCel); 
var 
   cel:celular; 
   descripcion:string; 
begin
    write('-Introduzca una descripcion para encontrar su celular perfecto: ');
    readln(descripcion); 
    reset(arch); 
    while (not eof(arch)) do begin 
        read (arch,cel); 
        if (pos(descripcion,cel.descripcion) > 0 ) then begin 
            imprimirCelular(cel)
        end;
    end;    
    close(arch); 
end; 

procedure exportarCelulares(var arch:typeCel);
var 
    fTxt:textfile; 
    cel:celular; 
begin 
    reset(arch);
    assign(fTxt, 'fileCelulares.txt'); 
    rewrite(fTxt); 
    while (not eof(arch)) do begin
        read(arch,cel); 
        writeln(fTxt,cel.cod);
        writeln(fTxt,cel.nombre);
        writeln(fTxt,cel.marca);
        writeln(fTxt,cel.precio:3:3);
        writeln(fTxt,cel.descripcion);
        writeln(fTxt,cel.stock);
        writeln(fTxt,cel.stockMin); 
    end; 
    close(arch); 
    close(fTxt);
    writeln('-El archivo fue exportardo con exito-'); 
end; 

procedure leerCelular (var cel:celular); 
begin 
    write('Marca: '); readln(cel.marca); 
    write('Nombre: '); readln(cel.nombre);
    write('Precio: '); readln(cel.precio);
    write('Codigo: '); readln(cel.cod);
    write('Descripcion: '); readln(cel.descripcion);
    write('Stock disponible: '); readln(cel.stock);
    write('Stock minimo: '); readln(cel.stockMin); 
end; 

procedure agregarCelular(var arch:typeCel);
var 
    cel:celular; 
    ok:integer; 
begin 
    reset(arch);  
    ok:= 1; 
    while (ok=1) do begin 
        leerCelular(cel);
        seek(arch,fileSize(arch)); 
        write(arch,cel); 
        writeln('---------'); 
        writeln('Si desea agregar otro celular Introduzca 1 sino 0'); 
        readln(ok); 
    end; 
    writeln('El/los celulares han sido agregado con exito...'); 
    close(arch); 
end; 

procedure buscarCelular (var arch:typeCel; nombre:string; var pos: integer); 
var 
    cel:celular; 
begin  
    pos:=-1; 
    while (pos = -1) and (not eof(arch)) do begin 
        read (arch,cel); 
        if (cel.nombre = nombre) then 
            pos:= (filePos(arch)-1); 
    end; 
    if (pos = -1) then 
        writeln('-El celular ingreso no coincide con ningungo en nustra base de datos-'); 
end; 

procedure modificarStock (var arch:typeCel); 
var 
    cel:celular; 
    nombre:string;
    stockN,pos:integer; 
begin 
    reset (arch); 
    write('Introduzca el nombre del celular a modificar: '); readln(nombre); 
    buscarCelular(arch,nombre,pos);  
    if (pos <> -1) then begin 
        write('Introduzca el nuevo stock: '); readln (stockN); 
        seek (arch,pos); 
        read (arch,cel); 
        cel.stock:=stockN; 
        seek(arch,filePos(arch)-1); 
        write (arch,cel); 
    end; 
    close(arch);
end; 

procedure exportarSinStock (var arch:typeCel); 
var 
    SinStock:textfile; 
    cel:celular; 
begin
    reset(arch); 
    assign (SinStock,'SinStock.txt'); 
    rewrite(SinStock); 
    while (not eof(arch))do begin
        read(arch,cel); 
        if (cel.stock = 0) then begin
            writeln(SinStock,cel.marca); 
            writeln(SinStock,cel.nombre); 
            writeln(SinStock,cel.precio:3:3); 
            writeln(SinStock,cel.cod); 
            writeln(SinStock,cel.descripcion);  
        end; 
    end; 
    close(SinStock)
end; 

var 
    fCelus: typeCel; 
    n:integer;  
begin  
    while (true) do begin 
        mensajes(); 
        readln(n); 
        case n of     
            1: importarCelulares (fCelus); 
            2: mostrarSinStockAdecuado(fCelus); 
            3: mostarSegunDescripcion(fCelus); 
            4: exportarCelulares (fCelus); 
            5: agregarCelular (fCelus);  
            6: modificarStock (fCelus); 
            7: exportarSinStock(fCelus); 
            8: exit()
            else
                writeln ('Opcion invalida'); 
        end; 
    end; 
end. 