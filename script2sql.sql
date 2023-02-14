create DATABASE IF NOT EXISTS tienda;
use tienda;

-- desactivamos las llaves para poder introducir los datos a la base de datos --
set FOREIGN_KEY_CHECKS=0;

CREATE TABLE `centros` (
	`numce` int(4) not null,
    `nomce` varchar(25),
    `dirce` varchar(25)
    );
    
CREATE TABLE `departamentos` (
	`numde` int(3) not null,
    `numce` int(4),
    `direc` int(3),
    `tidir` char(1),
    `presu` double(3,1),
    `depde` int(3),
    `nomde` varchar(20)
    );
    
CREATE TABLE `empleados` (
	`numem` int(3) not null,
    `extel` int(3),
    `fecna` date,
    `fecin` date,
    `salar` int(5),
    `comis` int(3),
    `numhi` int(1),
    `nomem` varchar(10),
    `numde` int(3)
    );
    
-- una vez creadas las tablas insertamos los indices ---

-- tabla centros--

ALTER TABLE `centros`
	add primary key (`numce`);

-- tabla depàrtamentos--

ALTER TABLE `departamentos`
	add primary key (`numde`),
    add key `numde` (`numde`),
    add key `numce` (`numce`),
    add key `depde` (`depde`);
    
-- tabla empleados--

ALTER TABLE `empleados`
	add primary key (`numem`),
    add key `numem` (`numem`),
    add key `numde` (`numde`);
    
-- ahora creamos los filtros para las diferentes tablas --

ALTER TABLE `departamentos`
	add constraint `departamentos_ibfk1` foreign key (`numce`) references `centros` (`numce`) on delete no action on update no action,
    add constraint `departamentos_ibfk2` foreign key (`depde`) references `departamentos` (`numde`) on delete no action on update no action;
    
ALTER TABLE `empleados`
	add constraint `empleados_ibfk1` foreign key (`numde`) references `departamentos` (`numde`) on delete no action on update no action;


-- ahora ya empezariamos a cargar los datos --

-- insertamos los campos de departamentos --

insert into departamentos (numde,numce,direc,tidir,presu,depde,nomde)
values (100, 10, 260, 'P', 72, NULL, 'DIRECCIÓN_GENERAL');

insert into departamentos (numde,numce,direc,tidir,presu,depde,nomde)
values (110, 20, 180, 'P', 90, 100, 'DIRECC_COMERCIAL');

insert into departamentos (numde,numce,direc,tidir,presu,depde,nomde)
values (111, 20, 180, 'F', 66, 110, 'SECTOR_INDUSTRIAL');

insert into departamentos (numde,numce,direc,tidir,presu,depde,nomde)
values (112, 20, 270, 'P', 54, 110, 'SECTOR_SERVICIOS');

insert into departamentos (numde,numce,direc,tidir,presu,depde,nomde)
values (120, 10, 150, 'F', 18, 100, 'ORGANIZACIÓN');

insert into departamentos (numde,numce,direc,tidir,presu,depde,nomde)
values (121, 10, 150, 'P', 12, 120, 'PERSONAL');

insert into departamentos (numde,numce,direc,tidir,presu,depde,nomde)
values (122, 10, 350, 'P', 36, 120, 'PROCESO_DE_DATOS');

insert into departamentos (numde,numce,direc,tidir,presu,depde,nomde)
values (130, 10, 310, 'P', 12, 100, 'FINANZAS');

-- insertamos los campos de centros --

insert into centros (numce,nomce,dirce)
values (10, 'cede central', 'C/ Atocha, 820, MADRID');

insert into centros (numce,nomce,dirce)
values (20, 'relación con clientes', ' C/ Atocha, 405, MADRID');

-- insertamos los campos de empleados utilizando el bulk insert --

insert into empleados (numem, extel, fecna, fecin, salar, comis, numhi, nomem, numde)
values  (110, 350, '1970-11-10', '1985-02-15', 1800, NULL, 3, 'CESAR', 121),
		(120, 840, '1968-06-09', '1988-10-01', 1900, 110, 1, 'MARIO', 112),
        (130, 810, '1695-09-09', '1981-02-01', 1500, 110, 2, 'LUCIANO', 112),
        (150, 340, '1975-08-10', '1997-05-15', 2600, NULL, 0, 'JULIO', 121),
        (160, 740, '1980-07-09', '2005-11-11', 1800, 110, 2, 'AUREO', 111),
        (180, 508, '1974-10-18', '1996-03-18', 2800, 50, 2, 'MARCOS', 120),
        (190, 350, '1972-05-12', '1992-02-11', 1750, NULL, 4, 'JULIANA', 121),
        (210, 200, '1970-09-28', '1999-01-22', 1910, NULL, 2, 'PILAR', 100),
        (240, 760, '1967-02-26', '1989-02-24', 1700, 100, 3, 'LAVINIA', 111),
        (250, 250, '1976-10-27', '1997-03-01', 2700, NULL, 0, 'ADRIANA', 100),
        (260, 220, '1973-12-03', '2001-07-12', 720, NULL, 6, 'ANTONIO', 100),
        (270, 800, '1975-05-21', '2003-09-10', 1910, 80, 3, 'OCTAVIO', 112),
        (280, 410, '1978-01-10', '2010-10-08', 1500, NULL, 5, 'DOROTEA', 130),
        (285, 620, '1979-10-25', '2011-02-15', 1910, NULL, 0, 'OTILIA', 122),
        (290, 910, '1967-11-30', '1988-02-14', 1790, NULL, 3, 'GLORIA', 120),
        (310, 480, '1976-11-21', '2011-01-15', 1950, NULL, 0, 'AUGUSTO', 130),
        (320, 620, '1977-12-25', '2003-02-05', 2400, NULL, 2, 'CORNELIO', 122),
        (330, 850, '1958-08-19', '1980-03-01', 1700, 90, 0, 'AMELIA', 112),
        (350, 610, '1979-04-13', '1999-09-10', 2700, NULL, 1, 'AURELIO', 122),
        (360, 750, '1978-10-29', '1998-10-10', 1800, 100, 2, 'DORINDA', 111),
        (370, 360, '1977-06-22', '2000-01-20', 1860, NULL, 1, 'FABIOLA', 121),
        (380, 880, '1978-03-30', '1999-01-01', 110, NULL, 0, 'MICAELA', 112),
        (390, 500, '1976-02-19', '2010-10-08', 1290, NULL, 1, 'CARMEN', 110),
        (400, 780, '1979-08-18', '2011-11-01', 1150, NULL, 0, 'LUCRECIA', 111),
        (410, 660, '1968-07-14', '1989-10-13', 1010, NULL, 0, 'AZUCENA', 122),
        (420, 450, '1966-10-22', '1988-11-19', 2400, NULL, 0, 'CLAUDIA', 130),
        (430, 650, '1967-10-26', '1988-11-19', 1260, NULL, 1, 'VALERIANA', 122),
        (440, 760, '1966-09-26', '1986-02-28', 1260, 100, 0, 'LIVIA', 111),
        (450, 800, '1966-10-21', '1986-02-28', 1260, 100, 0, 'SABINA', 112),
        (480, 760, '1965-04-04', '1986-02-28', 1260, 100, 1, 'DIANA', 111),
        (490, 880, '1964-06-06', '1988-01-01', 1090, 100, 0, 'HORACIO', 112),
        (500, 750, '1965-10-08', '1987-01-01', 1200, 100, 0, 'HONORIA', 111),
        (510, 550, '1966-05-04', '1986-11-01', 1200, NULL, 1, 'ROMULO', 110),
        (550, 780, '1970-01-10', '1998-01-21', 600, 120, 0, 'SANCHO', 111);
        
        
  -- Al finalizar la carga de todos los datos volvemos activar las llaves --     
 set FOREIGN_KEY_CHECKS=1;
 commit;

-- 1. Para cada departamento con presupuesto inferior a 35.000 €, hallar le nombre del Centro donde está ubicado y el máximo salario de sus empleados (si dicho máximo excede de 1.500 €). Clasificar alfabéticamente por nombre de departamento.
SELECT departamentos.nomde, departamentos.presu, centros.nomce, empleados.salar
FROM departamentos, centros, empleados
WHERE (departamentos.numce = centros.numce) AND (departamentos.numde = empleados.numde) AND (departamentos.presu < 35.0)
HAVING empleados.salar >= 1500
ORDER BY departamentos.nomde;

-- 2. Hallar por orden alfabético los nombres de los departamentos que dependen de los que tienen un presupuesto inferior a 30.000 €. También queremos conocer el nombre del departamento del que dependen y su presupuesto.
SELECT nomde AS nombre_departamento, presu AS preuspuesto
FROM departamentos
WHERE presu < 30.0
ORDER BY nombre_departamento;

-- 3. Obtener los nombres y los salarios medios de los departamentos cuyo salario medio supera al salario medio de la empresa.
SELECT departamentos.nomde, AVG(empleados.salar)
FROM empleados
LEFT JOIN departamentos ON empleados.numde = departamentos.numde 
GROUP By departamentos.nomde
HAVING AVG(empleados.salar) > (SELECT AVG(empleados.salar)
				      FROM empleados);
   
-- 4. Para los departamentos cuyo director lo sea en funciones, hallar el número de empleados y la suma de sus salarios, comisiones y número de hijos.
use tienda;                                          
SELECT DISTINCT count(empleados.numem)AS cantidad_empleados, 
count(empleados.numhi) AS Cantidad_hijos, SUM(empleados.salar)AS suma_salarios, SUM(empleados.comis)AS suma_comisiones, departamentos.nomde AS Nombre_departamento
	FROM empleados
            left join departamentos on departamentos.numde = empleados.numde
	WHERE departamentos.tidir = 'F'
            GROUP BY departamentos.nomde;

-- 5. Para los departamentos cuyo presupuesto anual supera los 35.000 €, hallar cuantos empleados hay por cada extensión telefónica.
use tienda;                                          
SELECT DISTINCT departamentos.nomde AS Nombre_departamento,     departamentos.presu AS Presupuesto_departamento,
count(empleados.numem) AS Numero_de_empleados, 
empleados.extel AS Extencion_telefonica
FROM empleados
left join departamentos on departamentos.numde = empleados.numde
WHERE departamentos.presu <= 35.0
GROUP BY departamentos.nomde;

-- 6. Hallar por orden alfabético los nombres de los empleados y su número de hijos para aquellos que son directores en funciones.
use tienda;                                          
SELECT DISTINCT empleados.nomem AS Nombre_empleado,       empleados.numhi AS Cantidad_hijos, departamentos.direc AS id_director, departamentos.tidir AS Director_Funciones
FROM empleados
left join departamentos on departamentos.numde = empleados.numde
WHERE departamentos.tidir = 'F'
GROUP BY empleados.nomem;

-- 7. Hallar si hay algún departamento (suponemos que sería de reciente creación) que aún no tenga empleados asignados ni director en propiedad.
SELECT departamentos.nomde AS NOMBRE_DEPARTAMENTO, empleados.nomem AS NOMBRE_EMPL, departamentos.tidir AS TIPO_DIRECTOR
FROM departamentos
LEFT JOIN empleados ON departamentos.numde = empleados.numde
WHERE empleados.numde IS NULL AND departamentos.tidir <> 'F';

-- 8. Añadir un nuevo departamento de nombre NUEVO y con director en funciones.
USE tienda;
SELECT *
FROM departamentos; 

INSERT INTO departamentos (numde, numce, direc, tidir, presu, depde, nomde)
VALUES (140, 10, 160, 'F', 72, 100, 'NUEVO');

SELECT *
FROM departamentos;

-- 9. Añadir un nuevo empleado de nombre NORBERTO y sin departamento asignado. Inventar el resto de datos.
INSERT INTO empleados (numem, extel, fecna, fecin, salar, comis, numhi, nomem, numde)
VALUES (570, 926, '1998-02-15', '2019-02-15', 1900, NULL, 4, 'NORBERTO', NULL); 

SELECT *
FROM empleados; 

-- 10. Muestra los departamentos que no tienen empleados.
USE tienda; 
SELECT departamentos.numde AS DEPARTAMENTO, empleados.numde AS EMPLEADOS
FROM departamentos
LEFT JOIN empleados ON departamentos.numde = empleados.numde
WHERE empleados.numde IS NULL; 

-- 11. Muestra los nombres de departamentos que no tienen empleados haciendo uso la combinación externa LEFT JOIN. Muestra una segunda columna con los nombres de empleados para asegurarnos que realmente está a NULL.
SELECT departamentos.numde AS DEPARTAMENTO, departamentos.nomde AS NOMBRE_DEPARTAMENTO, empleados.numde AS ID_EMPLEADO, empleados.nomem AS NOMBRE_EMPLEADO
FROM departamentos 
LEFT JOIN empleados ON departamentos.numde = empleados.numde 
WHERE empleados.numde IS NULL; 

-- 12. Muestra los nombres de departamentos que no tienen empleados haciendo uso la combinación externa RIGH JOIN. Muestra una segunda columna con los nombres de empleados para asegurarnos que realmente está a NULL.
SELECT departamentos.numde AS NUM_DEPARTAMENTO, departamentos.nomde AS NOMBRE_DEPARTAMENTO, empleados.numde AS NUM_EMPLEADO, empleados.nomem AS NOMBRE_EMPLEADO
FROM empleados 
RIGHT JOIN departamentos ON departamentos.numde = empleados.numde 
WHERE empleados.numde IS NULL; 

-- 13. Muestra los nombres de empleados que no tienen departamento haciendo uso la combinación externa LEFT JOIN. Muestra una segunda columna con los nombres de departamentos para asegurarnos que realmente esta a NULL.
SELECT departamentos.numde AS NUM_DEPARTAMENTO, departamentos.nomde AS NOMBRE_DEPARTAMENTO, empleados.nomem AS NOMBRE_EMPLEADO
FROM empleados 
LEFT JOIN departamentos ON empleados.numde = departamentos.numde 
WHERE departamentos.numde IS NULL;

-- 14. Muestra los nombres de empleados que no tienen departamento haciendo uso la combinación externa RIGHT JOIN. Muestra una segunda columna con los nombres de empleados para asegurarnos que realmente esta a NULL.
SELECT empleados.nomem AS NOMBRE_EMPLEADOS, departamentos.numde AS NUM_DEPARTAMENTO, departamentos.nomde AS NOMBRE_DEPARTAMENTO
FROM departamentos
RIGHT JOIN empleados ON departamentos.numde = empleados.numde
WHERE empleados.numde IS NULL; 

-- 15. Muestra los departamentos que no tienen empleados y los empleados que no tiene departamento haciendo uso la combinación externa FULL JOIN.
/*
Por problemas de compatibilidad, en muchos casos MySQL no acepta el full join, cuyo esquema es el siguiente:
SELECT columns
FROM table1
FULL [OUTER] JOIN table2
ON table1.column = table2.column;
Para solucionarlo, interesa aplicar la union de un left join con un right join, como se va a desarrollar a continuacion:
*/

SELECT * 
FROM departamentos LEFT JOIN empleados 
ON departamentos.numde = empleados.numde
UNION
SELECT * 
FROM departamentos  RIGHT JOIN empleados
ON departamentos.numde = empleados.numde;

-- 16. Muestra los empleados y sus respectivos departamentos haciendo uso de la combinación interna INNER JOIN. ¿Aparecen el departamento NUEVO y el empleado NORBERTO?¿Por qué?
select departamentos.nomde as nombre_departamento, empleados.nomem as nombre_empleado
from empleados
inner join departamentos
on departamentos.numde = empleados.numde;
/*
No aparecen ni el departamento NUEVO ni NORBERTO ya que INNER JOIN a la hora de mostrar por pantalla el resultado de la ejecucion suele excluir filas en las que hay datos nulos en alguna columna correspondiente. 
Los valores nulos no contarían con el mismo tratamiento de igualdad que el resto de datos.
*/

-- 17. Realiza la misma consulta anterior donde se cumpla la condición que NUMDE está a NULL. ¿Aparece algún resultado?¿Por qué?
select departamentos.nomde as nombre_departamento, empleados.nomem as nombre_empleado
from empleados
inner join departamentos
on departamentos.numde = empleados.numde
where departamentos.numde is null;
/*
No aparece ningun resultado ya que cuando se utiliza un inner join con la clausula 'where' y la condicion 'is null' solo muestra aquellas filas cuyo valor sea null. Para este caso, no encuentra ningun valor que mostrar por pantalla.
*/

-- 18. Muestra los empleados y sus respectivos departamentos haciendo uso de la combinación interna NATURAL JOIN.
select *
from empleados
natural join departamentos;

-- 19. Muestra la combinación de las 3 tablas CENTROS, DEPARTAMENTOS y EMPLEADOS haciendo uso de NATURAL JOIN.
select *
from empleados
natural join departamentos
natural join centros;

-- 20. Borra los registros dados de alta para el departamento NUEVO y el empleado introducido en el apartado anterior.
delete from departamentos, empleados
where departamentos.nomde = 'NUEVO'
and empleados.nomem = 'norberto';

DELETE clientes WHERE nsucursal IN
(SELECT nsucursal FROM sucursales WHERE nombre='Sucursal Centro');

USE BANCO;
DELETE
from clientes
where nsucursal IN
(SELECT nsucursal
FROM sucursales
WHERE nombre='Sucursal Centro');









    
    
    