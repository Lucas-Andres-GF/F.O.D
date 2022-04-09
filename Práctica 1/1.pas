program Eje1Prac1; 
type 
    numero = file of integer; 
var 
    file_num : numero; 
    name : string; 
    num:integer; 
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
end. 
