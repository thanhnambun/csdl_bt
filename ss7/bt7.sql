
CREATE DATABASE StudentTest;
USE StudentTest;

CREATE TABLE Student (
    RN INT PRIMARY KEY,
    Name VARCHAR(20),
    Age TINYINT
);

CREATE TABLE Test (
    TestID INT PRIMARY KEY,
    Name VARCHAR(20)
);

CREATE TABLE StudentTest (
    RN INT,
    TestID INT,
    Date DATETIME,
    Mark FLOAT,
    PRIMARY KEY (RN, TestID),
    FOREIGN KEY (RN) REFERENCES Student(RN),
    FOREIGN KEY (TestID) REFERENCES Test(TestID)
);

INSERT INTO Student (RN, Name, Age) VALUES
(1, 'Nguyen Hong Ha', 20),
(2, 'Truong Ngoc Anh', 30),
(3, 'Tuan Minh', 25),
(4, 'Dan Truong', 22);

INSERT INTO Test (TestID, Name) VALUES
(1, 'EPC'),
(2, 'DWMX'),
(3, 'SQL1'),
(4, 'SQL2');

INSERT INTO StudentTest (RN, TestID, Date, Mark) VALUES
(1, 1, '2006-07-17', 8),
(1, 2, '2006-07-18', 5),
(1, 3, '2006-07-19', 7),
(2, 1, '2006-07-17', 7),
(2, 2, '2006-07-18', 4),
(2, 3, '2006-07-19', 2),
(3, 1, '2006-07-17', 10),
(3, 3, '2006-07-18', 1);

ALTER TABLE Student ADD CONSTRAINT UniqueNames UNIQUE (Name);
ALTER TABLE Test ADD CONSTRAINT UniqueTestNames UNIQUE (Name);

ALTER TABLE StudentTest ADD CONSTRAINT RNTestIDUnique UNIQUE KEY (RN, TestID);

ALTER TABLE Student ADD COLUMN Status VARCHAR(10); 

ALTER TABLE StudentTest DROP FOREIGN KEY StudentTest_ibfk_1;
ALTER TABLE StudentTest ADD CONSTRAINT StudentTest_ibfk_1 FOREIGN KEY (RN) REFERENCES Student(RN) ON DELETE CASCADE;
ALTER TABLE StudentTest DROP FOREIGN KEY StudentTest_ibfk_2;
ALTER TABLE StudentTest ADD CONSTRAINT StudentTest_ibfk_2 FOREIGN KEY (TestID) REFERENCES Test(TestID) ON DELETE CASCADE;

SELECT s.Name, st.TestID AS MaThi, s.Age, st.Date, st.Mark 
FROM Student s 
JOIN StudentTest st ON s.RN = st.RN 
ORDER BY st.Mark DESC;

SELECT s.Name, s.RN, s.Age 
FROM Student s 
WHERE NOT EXISTS (
    SELECT 1 FROM StudentTest st WHERE st.RN = s.RN
);

SELECT s.Name, s.RN, s.Age, st.TestID AS MaThi, st.Mark 
FROM Student s 
JOIN StudentTest st ON s.RN = st.RN 
WHERE st.Mark < 5;

SELECT s.Name, AVG(st.Mark) AS AverageMark
FROM Student s 
JOIN StudentTest st ON s.RN = st.RN 
GROUP BY s.Name
ORDER BY AverageMark DESC;

SELECT s.Name, AVG(st.Mark) AS AverageMark
FROM Student s 
JOIN StudentTest st ON s.RN = st.RN 
GROUP BY s.Name 
ORDER BY AverageMark DESC 
LIMIT 1;

SELECT st.TestID, MAX(st.Mark) AS MaxMark
FROM StudentTest st 
GROUP BY st.TestID 
ORDER BY MaxMark DESC;

UPDATE Student 
SET Age = Age + 1;

UPDATE Student 
SET Status = CASE 
    WHEN Age < 30 THEN 'Young' 
    ELSE 'Old' 
END;

SELECT * FROM StudentTest ORDER BY Date ASC;

SELECT s.Name, s.RN, s.Age, st.Mark 
FROM Student s 
JOIN StudentTest st ON s.RN = st.RN 
WHERE s.Name LIKE 'T%' AND st.Mark > 4.5;

SELECT s.Name, s.Age, st.Mark 
FROM Student s 
JOIN StudentTest st ON s.RN = st.RN 
ORDER BY s.Name, s.Age, st.Mark ASC;

DELETE FROM Test 
WHERE TestID NOT IN (SELECT DISTINCT TestID FROM StudentTest);

DELETE FROM StudentTest WHERE Mark < 5;