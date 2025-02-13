DELIMITER //

CREATE PROCEDURE GetCountriesWithLargeCities()
BEGIN
    SELECT c.Name AS CountryName, SUM(ct.Population) AS TotalPopulation
    FROM city ct
    JOIN country c ON c.Code = ct.CountryCode
    WHERE c.Continent = 'Asia'
    GROUP BY c.Name
    HAVING TotalPopulation > 10000000;  
END;

//

DELIMITER ;


call GetCountriesWithLargeCities ();

DROP PROCEDURE IF EXISTS GetCountriesWithLargeCities;