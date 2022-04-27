program ejercicio3; 
const 
    valor_alto = 9999; 
    cantDetalles = 30; 
type 

    producto = record
        cod : integer; 
        nombre : string; 
        desc : string; 
        stockDis : integer; 
        stockMin : integer; 
        precio : real; 
    end; 

    regDetalle = record; 
        cod : integer; 
        cantVendida : integer; 
    end; 

    maestro = file of producto; 
    detalle = file of regDetalle; 

    arrayDetalles = array [1..30] of detalle; 

procedure leer (var det:detalle; regD: regDetalle); 
begin 


end; 

procedure actualizarMaestro (var mae: maestro; arratDets:arrayDetalles); 
var
    regM: producto; 
    det: detalle;  
    regD: regDetalle; 
    codAct: integer; 
    i : integer; 
begin 
    reset (mae); 
    read (mae,regM); 
    i:=0;  
    while (i < cantDetalles) do begin 
        leer(arratDets[i],regD); 
        while (regD.cod <> valor_alto) do begin
            codAct := regD.cod; 
            cantVendida := 0; 
            while (regD.cod = codAct) do begin 
                cantVendida := cantVendida + regD.cantVendida; 
                leer (arratDets[i],regD); 
            end;  
            while (regM.cod <> codAct) do begin 
                read (mae,regM); 
            regM.stockDis := regM.stockDis - cantVendida;  
            seek (mae,filepos(mae)-1); 
            write(mae,regM); 
            if (not eof(mae))then
                read(mae,regM); 
            end; 
        end; 
        i := i + 1;
    end; 
    close(mae); 
end; 

var
    mae : maestro; 
    archDeTexto : filetext; 
    arrayDetalles : arrayDetalles;
begin
    assign (mae,'maestroProductos');   
    actualizarMaestro  (mae,arrayDetalles); 

end. 