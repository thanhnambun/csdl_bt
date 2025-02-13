use world;

delimiter //
	create PROCEDURE out_data( in country_code char(3))
    BEGIN
	SELECT ID,Name,Population 
    FROM city
    where CountryCode = country_code;
	END;
// delimiter ;

call out_data('AFG');

DROP PROCEDURE IF EXISTS out_data;
