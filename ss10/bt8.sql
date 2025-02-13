DELIMITER //

CREATE PROCEDURE GetCountriesByCityNames()
BEGIN
    SELECT 
        c.Name AS CountryName, 
        cl.Language AS OfficialLanguage, 
        SUM(ct.Population) AS TotalPopulation
    FROM city ct
    JOIN country c ON c.Code = ct.CountryCode
    JOIN countrylanguage cl ON cl.CountryCode = c.Code
    WHERE ct.Name LIKE 'A%'   
        AND cl.IsOfficial = 'T'  
    GROUP BY c.Name, cl.Language
    HAVING TotalPopulation > 2000000  
    ORDER BY CountryName ASC;  
END;

//

DELIMITER ;

 call GetCountriesByCityNames();
 
 DROP PROCEDURE IF EXISTS GetCountriesByCityNames