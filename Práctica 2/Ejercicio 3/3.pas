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

    FileMaestro = file of producto; 
    FileDetalle = file of regDetalle; 

    arrayDetalles = array [1..cantDetalles] of FileDetalle; 

procedure leer (var det:FileDetalle; regD: regDetalle); 
begin   
    if (not eof(det)) then 
        read(det,regD); 
    else
        dato.cod := valor_alto; 
end; 

procedure actualizarMaestro (var mae: FileMaestro; arrayDets:arrayDetalles); 
var
    regM: producto; 
    det: FileDetalle;  
    regD: regDetalle; 
    codAct: integer; 
    i : integer; 
begin 
    reset (mae); 
    read (mae,regM); 
    i:=0;  
    while (i < cantDetalles) do begin 
        reset(arrayDetalles[i])
        leer(arrayDets[i],regD); 
        while (regD.cod <> valor_alto) do begin
            codAct := regD.cod; 
            cantVendida := 0; 
            while (regD.cod = codAct) do begin 
                cantVendida := cantVendida + regD.cantVendida; 
                leer (arrayDets[i],regD); 
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
    mae : FileMaestro; 
    archDeTexto : filetext; 
    arrayDetalles : arrayDetalles;
    i : integer; 
    istr : string;
begin
    assign (mae,'maestroProductos.data');   
    for i := 1 to cantDetalles do begin
        str(i,istr); 
        assign(arrayDetalles[i],'detalle' + istr + '.data'); 
        rewrite(arrayDetalles[i]); 
        
    end; 
    actualizarMaestro  (mae,arrayDetalles); 
end. 

