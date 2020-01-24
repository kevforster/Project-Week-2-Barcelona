SELECT * FROM project_transport.density;

##number of cars by district in 2017 in bcn
SELECT density.Nom_Barri, density.Superfície, density.Població, density.Densitat, density.Densitatneta
from project_transport.density
group by Nom_Barri;

##number of cars by ha in each distric in 2015 in bcn
SELECT density.Nom_Barri, density.Superfície, sum(Nombre_turismes) as quantity_turismes, 
age_vehicules.Antiguitat, density.Població, density.Densitat, density.Densitatneta,
(sum(Nombre_turismes)/density.Superfície) as number_vehicles_by_ha
from project_transport.density
join project_transport.age_vehicules on (density.Codi_Barri=age_vehicules.Codi_Barri) 
where density.any= 2015 and age_vehicules.Any = 2015
group by density.Nom_Barri, density.Any
;

##number of cars by ha  in each district in 2016 in bcn
SELECT density.Nom_Barri, density.Superfície, sum(Nombre_turismes) as quantity_turismes, 
age_vehicules.Antiguitat, density.Població, density.Densitat, density.Densitatneta,
((sum(Nombre_turismes)/density.Superfície)*100) as number_vehicles_by_ha
from project_transport.density
join project_transport.age_vehicules on (density.Codi_Barri=age_vehicules.Codi_Barri) 
where density.any= 2016 and age_vehicules.Any = 2016
group by density.Nom_Barri, density.Any
;

##number of cars by ha  in each district in 2017 in bcn
SELECT age_vehicules.Codi_Districte, density.Nom_Districte, density.Superfície, sum(Nombre_turismes) as quantity_turismes, 
age_vehicules.Antiguitat, density.Població, density.Densitat, density.Densitatneta,
(sum(Nombre_turismes)/density.Superfície) as number_vehicles_by_ha
from project_transport.density
join project_transport.age_vehicules on (density.Codi_Barri=age_vehicules.Codi_Barri) 
where density.any= 2017 and age_vehicules.Any = 2017
group by density.Nom_Districte, density.Any
;

##number of cars by ha in each BARRI in 2015 in bcn
SELECT density.Nom_Districte, density.Nom_BARRI, density.Superfície, sum(Nombre_turismes) as quantity_turismes, 
age_vehicules.Antiguitat, density.Població, density.Densitat, density.Densitatneta,
(sum(Nombre_turismes)/density.Superfície) as number_vehicles_by_ha,
(count(bus_stations.EQUIPAMENT)/density.Superfície) as public_transport_accesibility
from project_transport.density
join project_transport.age_vehicules on (density.Codi_Barri=age_vehicules.Codi_Barri) 
join project_transport.bus_stations on (density.Codi_Barri=bus_stations.BARRI)
where density.any= 2015 and age_vehicules.Any = 2015
group by density.Nom_BARRI, density.Any
;



#number of cars per head
SELECT TEST.District, TEST.Year, Vehicles, Population, (Vehicles / Population) AS Vehicle_Per_Head
FROM 	(SELECT age_vehicules.Nom_Districte AS District, age_vehicules.Any AS Year, 
		SUM(age_vehicules.Nombre_turismes) AS Vehicles
		FROM project_transport.age_vehicules
		GROUP BY District, Year
		ORDER BY District) AS TEST
JOIN (SELECT density.Nom_Districte AS District, density.Any AS Year, SUM(density.Població) as Population
FROM density
GROUP BY District, Year
ORDER BY density.Nom_Districte) AS TEST1
ON TEST.District = TEST1.District AND TEST.Year = TEST1.Year;

#number of bus per km2
SELECT bus_stations.NOM_DISTRICTE, count(EQUIPAMENT) AS BUS_stops, 
sum(density.Superfície) AS surface_km2, density.Població as population, 
round((count(EQUIPAMENT)/density.Població),2) as bus_stops_per_head, 
round((count(EQUIPAMENT)/(Superfície*100)),2) as bus_stops_per_km2
FROM bus_stations
JOIN project_transport.density ON (density.Codi_Districte=bus_stations.DISTRICTE)
where density.any=2017
GROUP BY NOM_DISTRICTE;


#mother board
SELECT TEST.District, TEST.Year, Vehicles, Population, (Vehicles / Population) AS Vehicle_Per_Head
FROM 	(SELECT age_vehicules.Nom_Districte AS District, age_vehicules.Any AS Year, 
		SUM(age_vehicules.Nombre_turismes) AS Vehicles
		FROM project_transport.age_vehicules
        where age_vehicules.Any = 2017
		GROUP BY District, Year
		ORDER BY District ) AS TEST
JOIN (SELECT density.Nom_Districte AS District, density.Any AS Year, SUM(density.Població) as Population
FROM density
GROUP BY District, Year
ORDER BY density.Nom_Districte) AS TEST1
ON TEST.District = TEST1.District AND TEST.Year = TEST1.Year;



