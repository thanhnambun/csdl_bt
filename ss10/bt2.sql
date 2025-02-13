delimiter //
	create procedure CalculatePopulation (in p_countryCode char(3),
										out total_population int)
    begin 
		select sum(Population) into total_population
        from city
        where CountryCode = p_countryCode;
    end;

// delimiter ;

SET @t_population = 0;

CALL CalculatePopulation('AFG', @t_population); 

SELECT @t_population AS Total_Population; 

DROP PROCEDURE IF EXISTS CalculatePopulation;