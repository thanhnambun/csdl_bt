delimiter // 
	create procedure UpdateCityPopulation (inout city_id int ,
											in new_population int)
	begin
		UPDATE city 
		SET Population = new_population 
		WHERE ID = city_id;
        
		SELECT ID AS CityID, Name, Population 
		FROM city 
		WHERE ID = city_id;
    end;
// delimiter ;

call UpdateCityPopulation(1 ,100000) ; 

DROP PROCEDURE IF EXISTS CalculatePopulation;
