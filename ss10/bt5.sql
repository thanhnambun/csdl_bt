delimiter // 
	create procedure GetLargeCitiesByCountry (in country_code char(3))
    begin
		select ID,Name,Population
        from city
        where country_code = CountryCode and Population > 1000000;
    end;
// delimiter ;

call GetLargeCitiesByCountry('usa');

DROP PROCEDURE IF EXISTS GetLargeCitiesByCountry;