-- casos para el inner join osea los campos que se repiten entre las 2 tablas --

-- hacemos una busqueda con 2 tablas diferentes para sacar elnombre de las sucursales, el nombre y apellidos de los directores
-- donde los nombres de los directores y los id de los directores sean los mismos en las 2 tablas --


use banco;
select sucursales.nombre, directores.nombre, directores.apellidos
from sucursales
join directores
on sucursales.director=directores.id;

-- lo mismo que arriba pero escluyendo todos los directores que se llaman anotnio -- 

use banco;
select sucursales.nombre, directores.nombre as directores, directores.apellidos
from sucursales, directores
where sucursales.director=directores.id and directores.nombre!='Antonio';

-- casos para usar el left outer join y el rigth outer join --
-- este es para sacar las sucursales que no se comparten osea sacar todas las sucursales que no tienen directores -- 
-- sobretodo hay que usar el "distinct" cuando se utiliza tanto el "left join" como el "rigth join" --

use banco;
select distinct sucursales.nombre, directores.nombre, directores.apellidos
from sucursales
left join directores on sucursales.director=directores.id
where directores.id is null;

-- y este es con el "rigth" aqui sacariamos los directores que no tienen sucursales -- 

use banco;
select distinct sucursales.nombre, directores.nombre, directores.apellidos
from sucursales
right join directores on sucursales.director=directores.id
where sucursales.id is null;

-- casos para utilizar el full outer join --
-- dependiendo de la version hay 2 maneras de hacerlo esta seria la manera mas correcta y facil de hacer pero no siempre lo acepta segun la version--

use banco;
select sucursales.nombre, directores.nombre, directores.apellidos
from sucusales
full  join directores on sucursales.director=directores.id;

-- esta seria la otra manera de hacerlo y que nunca nos va a dar problemas --

use banco;
select*
from sucursales
left join directores on sucursales.director=directores.id
union
select*
from directores
right join sucursales on sucursales.director=directores.id;

-- fusionar todos los campos con "union" --
-- si usamos "union all" no elimina duplicados y en cambio solo "union" si que filtra y gasta mas recursos --
-- el union es incomplatible con el order by --

use banco;
select nombre, apellidos from directores
union
select nombre, apellidos from clientes;


-- el campo "intersect" no funciona en mysql y para hacerlo tenemos que hacer un "inner join"---
use banco;
select clientes.nombre, clientes.apellidos, clientes.credito
from clientes, sucursales, directores
where (clientes.nsucursal=sucursales.nsucursal)and(sucursales.director=directores.id)
order by 1;

-- las funciones de agregacion, quantificacion se usan los mismos valores de siempre "sum=sumar",
-- "avg= average promedio", "min=el valor minimo", "max=el valor maximo", "count=cuenta la cantidad que hay" -- 

use banco;
select sum(sueldo) as costes
from directores;
-- no es lo mismo el "count(*)" que el count(dni), el "count con *" cuenta nulos y el otro no cuenta nulos --

-- una subconsulta forma parte deuna condicion debusqueda en la clausula where o having, las subconsultas tambien se llaman test, y consumen menos recursos, hay 3 tipos:
-- comparación simple (Relacionales, any, all, <,>, =)
-- pertenencia (in)
-- exsistencia(Exist)
-- las subconsultas se le llaman Test --

-- diferentes subconsultas:

-- sub consulta de comparacion --
-- Este se utiliza para buscar valores o numeros --

use banco;
Select nombre, apellidos
From clientes		-- Lo que esta aqui entre parentesis es la subconsulta --
Where nsucursal <> (Select max(nsucursal)
					From clientes);
                    
-- Test de pertenencia a conjunto --
-- Este se utiliza para comparar una fila--
-- Se busca el nombre que coincida entre clientes y directores, y te saca el nombre del cliente que sea el mismo que el del director --
-- en vez de usar el "in" tambien se puede usar el "not in" --
use banco;
Select nombre, apellidos
From clientes						
Where nombre in (Select nombre
				From directores);


-- de existencia --
-- estos son mas rapidos que los del test de comparacion --

Select nombre
From sucursales
Where exists (Select*
			From directores, sucursales
            Where directores.id=sucursales.director
            and sueldo>1400);
            
            -- Aqui pido que me saque el nombre de las sucursales si existen directores con sucursales que tengan sueldos superior a 1400 -- 
            
-- Test cuantificados  (Any "alguno", All "todos")--

Select nombre
From clientes
Where credito < Any (Select credito
					From clientes
                    Where nsucursal='1001');
                    
-- subconsultas con having
 -- seleccionas sucursal y sacas la media de las sucursales de clientesSelect nsucursal, avg(credit)
 -- y la media de cada sucursal tiene que ser mayor que la media de los clientes, porque al usar el grup by lo que haces es separar la media de cada sucursal que haya --
 -- Este se utiliza cuando hay condiciones que te obligan a utilizar el grup by con having --
 
 Select nsucursal, avg(credito)
From clientes
group by nsucursal
having avg(credito) >(select avg(credito)   
						From clientes);
						-- sacas la media del credito de clientes --
                        
-- subconsultas con insert --
-- estos se pueden hacer siempre que los campos sean compatibles --
-- insertamos todos los clientes que tengan un credito superior a 1200 a la tabla clientes_credito --

Insert Into clientes_credito(dni, nombre, apellidos, direccion)
Select dni, nombre, apellidos, direccion
From clientes
Where credito > 1200;

-- subconsultas con update --
-- Actualizamos el 10% del credito de los clientes donde el numero de la sucursal sea el mismo que el del sucursal centro y lo podemos hacer 
-- con el where o con el set --

update clientes
set credito=credito*1.10
where nsucursal = (Select nsucursal
					From sucursales
                    where nombre = 'Sucursal Centro');
                    -- selecciona el numero de sucursal donde el nombre sea sucursal centro --
                    
   -- actualizamos los clientes de la sucursal 1002, con el credito maximo  que haya de los clientes de la sucursal 1001 --                 
update clientes
set credito =(Select max(credito)
			From clientes
            Where nsucursal = '1007')
	where nsucursal = '1002';
    
    
    -- con delete --
    
    Delete 
    from clientes
    where nsucursal in (Select nsucursal
						From sucursales
                        Where nombre = 'sucursal centro');
	rollback;
    
    
    -- subconsultas con create --
    -- crea una nueva tabla con dni, nombre, apellidos cogiendo los valores de clientes donde el credito es superior a 500 --
    
    CREATE TABLE clientes_credito as
    (Select dni, nombre, apellidos 
    From clientes
    WHERE credito>500);
    
    -- subconsultas como una expresion --
    -- queremos saber los nombres de los clientes y la diferencia de su credito respecto al maximo de todos los creditos concedidos --
    
    Select nombre, apellidos, credito - (Select max(credito) from clientes) as diferencia
    From clientes;
    
    
    
    -- como interpretar una query osea saber el orden por el cual el ordenador las trabaja o las lee --
    -- en esta query al no haber subconsultas de datos y no estar anidadas consume mucha memoria--
    
    Select Procedencia as Pais, Count(articulo) as numarticulos
    from articulo
    where categoria in('pescado/marisco', 'condimentos', 'bebidas', 'lacteos')
    group by procedencia
    having count(Articulo)>1
    order by count(Articulo);
    
    -- como lee las querys
    -- Primero a los Select internos osea dentro de los parentesisi si hubieran
    -- Luego el From comprobar las tablas implicadas
    -- Where realiza los filtros necesarios soblre las filas implicadas haciendo una tabla virtual
    -- Select realiza la proyeccion de las columnas en otra tabla virtual
    -- Group by agrupa los resultados por el select y se genera otra tabla virtual
    -- Having realiza un filtro sobre la ultima tabla virtual
    -- order by ordena el resultado
                        
    -- como hacer una transaccion
    
    use hr;
    set autocommit = 0;
    select @@autocommit;
    start transaction;
    insert into departments(department_id, department_name, manager_id, location_id) values
    (280, 'Quality', 145, 1700);
    Select* from departments;
    rollback;
    select*from departments;
    set autocommit = 1;
    select @@autocommit;
    