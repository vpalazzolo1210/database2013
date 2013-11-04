--Tori Palazzolo 
--SQL Code 
--Data Normilzation 2 


DROP TABLE IF EXISTS MActors;
DROP TABLE IF EXISTS MDirectors;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS People;

--CREATE statements to instantiate tables
CREATE TABLE People(
        pid        char(4) not null,
        name        varchar(30),
        address        varchar(150),
        primary key (pid)
);


INSERT INTO People(pid, name, address) VALUES
        ('p01', 'Sean Connery', '123 Abbey Road UK'),                 
        ('p02', 'Michael Bay', '45 Madison Ave NY'),                
        ('p03', 'Shia Labouf', '56 Rodeo Drive LA California'),                
        ('p04', 'Harrison Ford', '14 Finikay Lane New York'),               
        ('p05', 'Steven Spielberg', '13 E.T Lane California');                
        
CREATE TABLE Directors(
        pid                                 char(4) not null references People(pid),
        film_school                        char(50),
        dag_anniversary                    varchar(50),
        primary key(pid)
);
INSERT INTO Directors(pid, film_school, dag_anniversary) VALUES
        ('p01', 'None', 'None'),
        ('p02', 'Wesleyn', '12/05/2007'),
        ('p03', 'USC', '01/09/1973');

CREATE TABLE Actors(
        pid                                        char(4) not null references People(pid),
        birthday                                        varchar(15),
        hair_color                                varchar(15),
        eye_color                                varchar(6),
        height_inches                                integer,
        weight                                        integer,
        sag_anniversary_date                          date,
        primary key(pid)
);

INSERT INTO Actors(pid, birthday, hair_color, eye_color, height_inches, weight, sag_anniversary_date) VALUES
        ('p01', '08/25/1930', 'Brown', 'Brown', 74, 200, '12/10/1997'),
        ('p03', '06/11/1986', 'Brown', 'Brown', 69, 160, '08/08/2007'),
        ('p04', '07/13/1942', 'Light Brown', 'Blue', 73, 175, '02/23/1968');
        

CREATE TABLE Movies(
        mid                        char(4) not null,
        title                        varchar(50),
        year                          integer,
        domestic_sales                numeric(12,2),
        foreign_sales                numeric(12,2),
        dvd_bluray_sales        numeric(12,2),
        primary key(mid)
);

INSERT INTO Movies(mid, title, year, domestic_sales, foreign_sales, dvd_bluray_sales) VALUES
        ('m01', 'The Bowler and the Bun', 1967, 200000.00, 400000.00, 150000.00),
        ('m02', 'Transformers', 2007, 80000000.00, 76000000.00, 12000000.00),
        ('m03', 'Indiana Jones and the Lost Crusades', 1989, 1000000.00, 2000000.00, 900000.00);
        
CREATE TABLE MDirectors(
        mid        char(4)        not null references Movies(mid),
        pid        char(4) not null references Directors(pid),
        primary key (mid, pid)
);
INSERT INTO MDirectors(mid, pid) VALUES
        ('m01', 'p01'),
        ('m02', 'p02'),
        ('m03', 'p05');
        
CREATE TABLE MActors(
        mid        char(4) not null references Movies(mid),
        pid        char(4) not null references Actors(pid),
        primary key (mid, pid)
);

INSERT INTO MActors(mid, pid) VALUES
        ('m01', 'p01'),
        ('m03', 'p01'),
        ('m02', 'p03'),
        ('m03', 'p04');



SELECT people.name 
FROM People
WHERE pid IN (
        SELECT pid FROM MDirectors
        WHERE mid IN (
                SELECT mid FROM MActors
                WHERE pid IN (
                        SELECT pid FROM People
                        WHERE name = 'Sean Connery'
                        )
                )
        );
--In this query you get the output of Sean Connery because he directed and starred as himself in the Movie The Bowler and the Bun thereore his pid
--of p01 showed up in both the mactors table and the mdirectors table. Therefore you get the output of Sean connery and Steven Spielberg 
--who worked with sean Connery in the Indianna Jones films.  Therefore you get the output of sean connery because he worked with himself. 