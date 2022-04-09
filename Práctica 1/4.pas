program Eje4Prac1; 
type
    empleado=record
        nroEmp: integer; 
        apellido:string; 
        nombre:string; 
        edad:integer; 
        dni:string; 
    end; 

    TypeEmp = file of empleado; 

procedure mensajes(); 
begin 
    writeln(''); 
    writeln('Ingrese que quieres hacer'); 
    writeln('1.Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado'); 
    writeln('2.Listar en pantalla los empleados de a uno por linea'); 
    writeln('3.Listar en pantalla empleados mayores de 70, proximos a jubilarse'); 
    writeln('4.Añadir una o mas empleados al final del archivo con sus datos ingresados por teclado'); 
    writeln('5.Modificar edad a una o mas empleados');
    writeln('6.Exportar el contenido del archivo a un archivo de texto llamado (todos_empleados.txt)');
    writeln('7.Exportar a un archivo de texto llamado: (faltaDNIEmpleado.txt), los empleados que no tengan cargado el DNI (DNI en 00)');
end; 

procedure leerEmpleado (var emp:empleado); 
begin 
    writeln ('-----------------------------------'); 
    write('Ingrese el apellido del empleado: '); 
    readln(emp.apellido); 
    if (emp.apellido <> 'Fin') and (emp.apellido <> 'fin') then begin 
        write('Ingrese el nombre del empleado: '); 
        readln(emp.nombre); 
        write('Ingrese el numero de empleado: '); 
        readln(emp.nroEmp);
        write('Ingrese su edad: '); 
        readln(emp.edad);
        write('Ingrese el DNI: '); 
        readln(emp.dni);
    end; 
end; 

procedure cargarEmpleados (var arch: TypeEmp ); 
var 
    emp:empleado; 
begin
    leerEmpleado(emp); 
    while(emp.apellido <> 'Fin') and (emp.apellido <> 'fin') do begin
        write(arch,emp); 
        leerEmpleado(emp); 
    end; 
    close(arch); 
end; 
//-----------------------Insiso B----------------------------//
procedure impEmpleados (var arch: TypeEmp); 
var 
    emp:empleado; 
    nombre:string; 
    apellido:string; 
begin 
    write('Ingre un nombre: '); 
    readln(nombre); 
    write('Ingrese un apellido: '); 
    readln(apellido); 
    reset(arch); 
    while (not eof (arch)) do begin 
        read(arch,emp);
        if ( emp.nombre = nombre ) or ( emp.apellido = apellido) then begin 
            writeln('----------'); 
            writeln('Nombre: ',emp.nombre);
            writeln('Apellido:',emp.apellido);
            writeln('Num de Emp.: ',emp.nroEmp);
            writeln('Edad: ',emp.edad);
            writeln('Dni: ',emp.dni); 
            writeln('----------'); 
        end; 
    end;
    close(arch); 
end; 

procedure imprimirTodos(var arch: TypeEmp); 
var 
    emp:empleado; 
begin 
    reset(arch); 
    while (not eof(arch) ) do begin 
        read(arch,emp); 
        writeln('----------'); 
        writeln('Nombre y Apellido: ',emp.nombre,' ',emp.apellido);
        writeln('----------'); 
    end; 
    close(arch); 
end; 

procedure imprimirMayores(var arch: TypeEmp); 
var 
    emp:empleado; 
begin 
    reset(arch); 
    writeln('Empleados a punto de jubilarse'); 
    while (not eof(arch) ) do begin 
        read(arch,emp); 
        if (emp.edad >= 70) then begin 
            writeln('----------'); 
            writeln('Nombre y Apellido: ',emp.nombre,' ',emp.apellido);
            writeln('----------'); 
        end; 
    end; 
    close(arch); 
end; 

procedure agregarEmpleados(var arch:TypeEmp); 
var 
    emp:empleado;
    ok:integer;  
begin
    reset(arch); 
    ok:= 1; 
    while (ok=1) do begin 
        leerEmpleado(emp);
        seek(arch,fileSize(arch)); 
        write(arch,emp); 
        writeln('---------'); 
        writeln('Si desea agregar otro empleado Introduzca 1 sino 0'); 
        readln(ok); 
    end; 
    writeln('-Voz de gallega- Los empleados han sido agregado exitosamente...'); 
    close(arch); 
end; 

procedure buscarEmpleado (var arch:TypeEmp; var posSig:integer; nEmp:integer); 
var
    emp:empleado; 
begin 
    reset(arch); 
    while (posSig = -1) and (not eof(arch))do begin 
        read(arch,emp); 
        if (emp.nroEmp = nEmp) then 
            posSig:= (filePos(arch)); 
    end; 
end; 

procedure modificarEdad(var arch: TypeEmp); 
var 
    edad:integer; 
    nEmp:integer; 
    emp:empleado; 
    ok:integer; 
    posSig:integer; 
begin
    ok:= 1; 
    while (ok=1) do begin
        write('Ingrese el numero de empleado: '); 
        read(nEmp); 
        write('Ingrese una edad: ');
        read(edad);    
        posSig:=-1; 
        buscarEmpleado(arch,posSig,nEmp); 
        if (posSig <> -1) then begin 
            reset(arch);  
            seek(arch,posSig -1);
            read(arch,emp); 
            seek(arch,filePos(arch)-1); 
            emp.edad:= edad;
            write(arch,emp); 
            writeln('La edad del empleado fue cambiada con exito'); 
            writeln('---------'); 
            close(arch);
        end
        else begin 
            writeln('Nose se encontro ninun empleado con ese numero'); 
            writeln('---------'); 
        end; 
        writeln('Si desea agregar otro empleado Introduzca 1 sino 0'); 
        readln(ok); 
    end; 
end; 

procedure exportarArchivo (var arch:TypeEmp); 
var
    todos_empleados:textfile;  
    emp:empleado; 
begin 
    reset(arch); 
    assign(todos_empleados,'todos_empleados.txt'); 
    rewrite(todos_empleados); 
    while (not eof(arch)) do begin 
        read(arch,emp);  
        writeln(todos_empleados,emp.nombre); 
        writeln(todos_empleados,emp.apellido); 
        writeln(todos_empleados,emp.nroEmp); 
        writeln(todos_empleados,emp.edad); 
        writeln(todos_empleados,emp.dni);   
    end; 
    writeln('El archivo fue exportado con exito...'); 
    close(arch); 
    close(todos_empleados); 
end; 

procedure exportarDni00 (var arch:TypeEmp); 
var 
    empleadosDni00:textfile;  
    emp:empleado; 
begin 
    reset(arch); 
    assign(empleadosDni00,'empleadosDni00.txt'); 
    rewrite(empleadosDni00); 
    while (not eof(arch)) do begin 
        read(arch,emp);
        if (emp.dni = '00') then begin 
            writeln(empleadosDni00,emp.nombre); 
            writeln(empleadosDni00,emp.apellido); 
            writeln(empleadosDni00,emp.nroEmp); 
            writeln(empleadosDni00,emp.edad); 
            writeln(empleadosDni00,emp.dni);   
        end; 
    end; 
    writeln('El archivo fue exportado con exito...'); 
    close(arch); 
    close(empleadosDni00); 
end; 

var 
    fEmp:TypeEmp; 
    name : string; 
    n:integer; 
begin 
    write('Ingrese un nombre para su archivo: '); 
    readln(name); 
    assign(fEmp , name); 
    rewrite(fEmp); 
    cargarEmpleados (fEmp); 
    while (true) do begin 
        mensajes(); 
        readln(n); 
        case n of     
            1: impEmpleados(fEmp); 
            2: imprimirTodos(fEmp); 
            3: imprimirMayores(fEmp);  
            4: agregarEmpleados(fEmp); 
            5: modificarEdad(fEmp); 
            6: exportarArchivo(fEmp);  //todos_empleados:textfile; 
            7: exportarDni00 (fEmp)//altaDNIEmpleado:textfile;
            else
                writeln ('Opcion invalida'); 
        end; 
    end; 
end.  


