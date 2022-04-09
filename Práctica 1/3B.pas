program Eje3bPrac1; 
type
    empleado=record
        nroEmp: integer; 
        apellido:string; 
        nombre:string; 
        edad:integer; 
        dni:string; 
    end; 

    type_empleado = file of empleado; 

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

procedure cargarEmpleados (var arch: type_empleado ); 
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
procedure impEmpleados (var arch: type_empleado); 
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

procedure imprimirTodos(var arch: type_empleado); 
var 
    emp:empleado; 
begin 
    reset(arch); 
    while (not eof(arch) ) do begin 
        read(arch,emp); 
        writeln('----------'); 
        writeln('Nombre y Apellido: ',emp.nombre,'',emp.apellido);
        writeln('----------'); 
    end; 
    close(arch); 
end; 

procedure imprimirMayores(var arch: type_empleado); 
var 
    emp:empleado; 
begin 
    reset(arch); 
    writeln('Empleados a punto de jubilarse'); 
    while (not eof(arch) ) do begin 
        read(arch,emp); 
        if (emp.edad >= 70) then begin 
            writeln('----------'); 
            writeln('Nombre y Apellido: ',emp.nombre,'',emp.apellido);
            writeln('----------'); 
        end; 
    end; 
    close(arch); 
end; 

var 
    file_emp:type_empleado; 
    name : string; 
    nombre:string; 
    apellido:string; 
    n:integer; 
begin 
    write('Ingrese un nombre para su archivo: '); 
    readln(name); 
    assign(file_emp , name); 
    rewrite(file_emp); 
    cargarEmpleados (file_emp); 
    writeln('Ingrese que quieres hacer'); 
    writeln('1.Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado'); 
    writeln('2.Listar en pantalla los empleados de a uno por linea'); 
    writeln('3.Listar en pantalla empleados mayores de 70 años, proximos a jubilarse'); 
    readln(n); 
    case n of     
        1: impEmpleados(file_emp); 
        2: imprimirTodos(file_emp); 
        3: imprimirMayores(file_emp) 
        else
            writeln ('Opcion invalida'); 
    end; 
end. 