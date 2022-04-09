program Eje5prac1; 
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
    writeln('5.Si desea cerrar el programa')
end; 

procedure imprimirCelular (var cel:celular); 
begin 
    writeln ('Nombre: ',cel.nombre);
    writeln ('Marca: ',cel.marca);
    writeln ('Precio: ',cel.precio:3:3);
    writeln ('Descripcion: ',cel.descripcion);
    writeln ('Stock disponible: ',cel.stock);
    writeln ('Stock minimo: ',cel.stockMin); 
end; 

procedure importarCelulares(var arch:typeCel); 
var
    cel:celular; 
    fTxt: textfile;
    name:string; 
begin 
    write('Ingrese un nombre para su archivo: '); 
    readln(name);
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
            5: exit()
            else
                writeln ('Opcion invalida'); 
        end; 
    end; 
end. 













