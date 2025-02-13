create view CountryLanguageView 
as select c.Code,c.name,cl.language, cl.IsOfficial
from country c
join countrylanguage cl on c.code = countrycode
where cl.IsOfficial = 't' ;

select * from CountryLanguageView;

delimiter //
	create procedure GetLargeCitiesWithEnglish ()
    begin
		select ct.name as cityName, c.name as countryName, c.population
        from city ct
        join countrylanguage cl on ct.CountryCode = cl.country
        join country c on c. code = ct.CountryCode
        where c.population >1000000 and cl.Language = (select Language from countrylanguage where Language='english' and isofficial = 't')
        order by population desc ;
    end;

// delimiter ;

drop procedure GetLargeCitiesWithEnglish();