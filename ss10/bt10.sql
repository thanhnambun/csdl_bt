create view OfficialLanguageView  
as select c.code, c.name ,cl.Language
        from country c
        join countrylanguage cl on c.Code = cl.CountryCode 
        where cl.IsOfficial ='t' ;
        
select * from OfficialLanguageView;

create index spead_name on city(name);

delimiter // 
	create procedure GetSpecialCountriesAndCities  ( in language_name varchar(25))
    begin
		select c.name as CountryName  , ct.name as CityName , ct.population as CityPopulation  ,c.popuolation as TotalPopulation  
        from country c 
        join city ct on ct.countrycode = c.code
        where language_name = ct.language and c.popuolation > 5000000 and ct.name like 'new%'
        order by c.popuolation desc 
        limit 10;
        
    end;
// delimiter ;

call GetSpecialCountriesAndCities('english');

