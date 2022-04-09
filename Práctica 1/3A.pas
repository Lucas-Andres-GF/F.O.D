program Eje3aPrac1; 
type
    empleado=record
        nroEmp: integer; 
        apellido:string; 
        nombre:string; 
        edad:integer; 
        dni:integer; 
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

var 
    file_emp:type_empleado; 
    name : string; 
begin 
    write('Ingrese un nombre para su archivo: '); 
    readln(name); 
    assign(file_emp , name); 
    rewrite(file_emp); 
    cargarEmpleados (file_emp); 
end. 






