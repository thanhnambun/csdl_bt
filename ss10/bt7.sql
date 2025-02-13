delimiter // 
	create procedure GetEnglishSpeakingCountriesWithCities (in language varchar(25))
    begin 
		select c.name ,c.population
        from country c
        join countrylanguage cl on c.Code = cl.CountryCode 
        where language = Continent and cl.IsOfficial ='t' and population >5000000
        order by population desc ;
    end;
// delimiter ;

call GetEnglishSpeakingCountriesWithCities('English');

DROP PROCEDURE IF EXISTS GetEnglishSpeakingCountriesWithCities;