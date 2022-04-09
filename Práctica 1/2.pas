program Eje2Prac1; 
type 
    numero = file of integer; 

procedure contenido(var archivo :numero; var suma:integer); 
var 
    num:integer; 
begin 
    reset(archivo); 
    while (not eof(archivo))do begin 
        read(archivo,num); 
        writeln(num); 
        suma := suma + num; 
    end; 
    close(archivo); 
end;

procedure menores(var archivo: numero); 
var 
    cant,num:integer; 
begin 
    cant:= 0; 
    reset(archivo); 
    while (not eof(archivo))do begin 
        read(archivo,num); 
        if (num < 1500) then 
            cant:= cant + 1; 
    end; 
    close(archivo); 
    writeln ('La cantidad de numeros menores a 1500 son: ', cant); 
end; 

var 
    file_num : numero; 
    name : string; 
    num:integer; 
    suma:integer;  
begin 
    writeln('Ingrese un nombre para su archivo'); 
    read(name); 
    assign(file_num,name); 
    rewrite(file_num); 
    write('Ingrese un numero: '); 
    read(num); 
    while (num <> 3000) do begin 
        write(file_num,num); 
        write('Ingrese un numero: '); 
        read(num); 
    end; 
    close(file_num); 
    suma:=0; 
    contenido (file_num,suma); 
    menores(file_num);  
    reset(file_num); 
    writeln('El promedio segun los numero ingresados es ', suma / FileSize(file_num):2:2); 
    close(file_num)
end.  