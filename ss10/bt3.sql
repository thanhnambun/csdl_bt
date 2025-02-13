
delimiter //
	create procedure data_per(in language_in char(30))
    begin
		select CountryCode,Language  ,Percentage 
        from countrylanguage
        where Language = language_in and Percentage > 50;;
    end;
// delimiter ; 

call data_per('dutch');

DROP PROCEDURE IF EXISTS CalculatePopulation;