-- Kreiranje baze podataka:

CREATE DATABASE Skolska_biblioteka;
USE Skolska_biblioteka;

-- Kreiranje tabela:

-- Tabela ,,Uloga''

CREATE TABLE Uloga(
  id INT PRIMARY KEY,
  naziv VARCHAR(50) NOT NULL
);

INSERT INTO Uloga (id, naziv) VALUES (1, 'Clan'),
(2, 'Zaposleni'),
(3, 'Administrator');

SELECT *
FROM Uloga;

-- Tabela ,,Izdavac''

CREATE TABLE Izdavac(
  id INT PRIMARY KEY IDENTITY (1, 1),
  ime VARCHAR(50) NOT NULL,
  sediste VARCHAR(50) NOT NULL
);

INSERT INTO Izdavac (ime, sediste) VALUES ('Dereta', 'Knez Mihajlova 46, Beograd'),
('Vulkan', 'Gospodara Vucica 245, Beograd'),
('Laguna', 'Resavska 33, Beograd'),
('Kreativni centar', 'Gradistanska 8, Beograd'),
('Pcelica', 'Kolubarska 4, Cacak');

SELECT *
FROM Izdavac;

-- Tabela ,,Knjizevni_rod''

CREATE TABLE Knjizevni_rod(
  id INT PRIMARY KEY,
  naziv VARCHAR(50) NOT NULL,
  opis VARCHAR(500)
);

INSERT INTO Knjizevni_rod (id, naziv) VALUES (1, 'Lirika'),
(2, 'Epika'),
(3, 'Drama');

SELECT *
FROM Knjizevni_rod;

-- Tabela ,,Knjizevna_vrsta''

CREATE TABLE Knjizevna_vrsta(
  id INT PRIMARY KEY IDENTITY (1, 1),
  naziv VARCHAR(50) NOT NULL,
  opis VARCHAR(500),
  knjizevni_rod_id INT FOREIGN KEY REFERENCES Knjizevni_rod(id)
);

INSERT INTO Knjizevna_vrsta (naziv, knjizevni_rod_id) VALUES ('Roman', 2),
('Komedija', 3),
('Tragedija', 3),
('Ljubavna pesma', 1),
('Zbirka pripovedaka', 2),
('Knjiga za decu', 1);

SELECT *
FROM Knjizevna_vrsta;

-- Funkcija ,,datumRodjenja''

CREATE FUNCTION datumRodjenja(@jmbg CHAR(13))
RETURNS DATE
AS
	BEGIN
		DECLARE @datum_rodjenja DATE;
		IF SUBSTRING(@jmbg, 5, 1) = '0' SET @datum_rodjenja = '2' + SUBSTRING(@jmbg, 5, 3) + '-' + SUBSTRING(@jmbg, 3, 2) + '-' + SUBSTRING(@jmbg, 1, 2)
		ELSE SET @datum_rodjenja = '1' + SUBSTRING(@jmbg, 5, 3) + '-' + SUBSTRING(@jmbg, 3, 2) + '-' + SUBSTRING(@jmbg, 1, 2);
		
		RETURN @datum_rodjenja;
	END;

-- Funkcija ,,brojGodina''

CREATE FUNCTION brojGodina(@jmbg CHAR(13))
RETURNS INT
AS
	BEGIN
		DECLARE @datum_rodjenja DATE;
		IF SUBSTRING(@jmbg, 5, 1) = '0' SET @datum_rodjenja = '2' + SUBSTRING(@jmbg, 5, 3) + '-' + SUBSTRING(@jmbg, 3, 2) + '-' + SUBSTRING(@jmbg, 1, 2)
		ELSE SET @datum_rodjenja = '1' + SUBSTRING(@jmbg, 5, 3) + '-' + SUBSTRING(@jmbg, 3, 2) + '-' + SUBSTRING(@jmbg, 1, 2);
	
		DECLARE @broj INT = DATEDIFF(YEAR, @datum_rodjenja, GETDATE());
		IF RIGHT(CONVERT(VARCHAR, @datum_rodjenja, 112), 4) > RIGHT(CONVERT(VARCHAR, GETDATE(), 112), 4) RETURN @broj - 1;
		RETURN @broj;
	END;
	
-- Tabela ,,Korisnik''

CREATE TABLE Korisnik(
  email VARCHAR(50) PRIMARY KEY,
  lozinka VARCHAR(30) NOT NULL,
  jmbg CHAR(13) NOT NULL,
  ime VARCHAR(20) NOT NULL,
  prezime VARCHAR(50) NOT NULL,  
  uloga_id INT FOREIGN KEY REFERENCES Uloga(id)
);

INSERT INTO Korisnik (email, lozinka, jmbg, ime, prezime, uloga_id) VALUES (N'stefanovicsalex@SKBibioteka_C.rs', 'coamafija1312', '2210003710256', 'Aleksandar', 'Stefanovic', 1),
('stefanovicsalex@SKBibioteka_Z.rs', 'coamafija1312', '2210003710256', 'Aleksandar', 'Stefanovic', 2),
('stefanovicsalex@SKBibioteka_A.rs', 'coamafija1312', '2210003710256', 'Aleksandar', 'Stefanovic', 3),
('aleksandargerasimovic@SKBibioteka_A.rs', 'alekgera551', '1502970710742', 'Aleksandar', 'Gerasimovic', 3),
('milosurosevic@SKBibioteka_C.rs', 'losmi321', '2106003710932', 'Milos', 'Urosevic', 1),
('jelenanikolic@SKBibioteka_Z.rs', 'jecapereca95', '1707995700111', 'Jelena', 'Nikolic', 2),
('nikolavucic@SKBibioteka_Z.rs', 'dzonidep83', '1704983710932', 'Nikola', 'Vucic', 2),
('marijapasic@SKBibioteka_C.rs', 'marija121', '3004004700932', 'Marija', 'Pasic', 1);

SELECT *
FROM Korisnik;

-- Funkcija ,,brojGodinaAutor''

CREATE FUNCTION brojGodinaAutor(@datum_rodjenja DATE, @datum_smrti DATE)
RETURNS INT
AS
BEGIN
	DECLARE @broj INT = DATEDIFF(YEAR, @datum_rodjenja, @datum_smrti);
	IF RIGHT(CONVERT(VARCHAR, @datum_rodjenja, 112), 4) > RIGHT(CONVERT(VARCHAR, @datum_smrti, 112), 4) RETURN @broj - 1;
	RETURN @broj;
END;

-- Tabela ,,Autor_dodatniPodaci''

CREATE TABLE Autor_dodatniPodaci(
  id INT PRIMARY KEY IDENTITY (1, 1),
  datum_rodjenja DATE,
  datum_smrti DATE,
  broj_godina AS dbo.brojGodinaAutor(datum_rodjenja, datum_smrti),
  mesto_rodjenja VARCHAR(40),
  mesto_smrti VARCHAR(40),
  biografija VARCHAR(2000),
  ocena INT -- od 1 do 10
);

INSERT INTO Autor_dodatniPodaci (datum_rodjenja, datum_smrti, mesto_rodjenja, mesto_smrti, ocena) VALUES ('1892-10-09', '1975-03-13', 'Dolac, Austrougarska', 'Beograd, SFR Jugoslavija', 10), -- Ivo Andric
('1821-11-11', '1881-02-09', 'Moskva, Ruska Imperija', N'Sankt Peterburg, Ruska Imperija', 9), -- Dostojevski
('1828-09-09', '1910-11-20', N'Jasna Poljana, Ruska Imperija', N'Astapovo, Ruska Imperija', 8); -- Tolstoj

SELECT *
FROM Autor_dodatniPodaci;

-- Tabela ,,Autor''

CREATE TABLE Autor(
  id INT PRIMARY KEY IDENTITY (1, 1),
  ime VARCHAR(20) NOT NULL,
  prezime VARCHAR(50) NOT NULL,
  dodatniPodaci_id INT FOREIGN KEY REFERENCES Autor_dodatniPodaci(id)
);

INSERT INTO Autor (ime, prezime, dodatniPodaci_id) VALUES ('Ivo', 'Andric', 1),
('Dobrica', 'Eric', NULL),
('Fjodor', 'Mihajlovic Dostojevski', 2),
('Dobrica', 'Cosic', NULL),
('Milos', 'Crnjanski', NULL),
('Lav', 'Nikolajevic Tolstoj', 3),
('Mark', 'Tven', NULL),
('Dzordz', 'Orvel', NULL),
('Zil', 'Vern', NULL),
('Mesa', 'Selimovic', NULL);

SELECT *
FROM Autor
JOIN Autor_dodatniPodaci ON Autor.dodatniPodaci_id = Autor_dodatniPodaci.id;

-- Funkcija ,,starostKnjige''

CREATE FUNCTION starostKnjige(@godina INT)
RETURNS INT
AS
BEGIN
	DECLARE @starost INT = CAST(LEFT(CONVERT(VARCHAR, GETDATE(), 112), 4) AS INT) - @godina;
	RETURN @starost;
END;

-- Tabela ,,Knjiga_dodatniPodaci''

CREATE TABLE Knjiga_dodatniPodaci(
  id INT PRIMARY KEY IDENTITY (1, 1),
  godina_objavljivanja INT,
  starost_knjige AS dbo.starostKnjige(godina_objavljivanja)
);

INSERT INTO Knjiga_dodatniPodaci (godina_objavljivanja) VALUES (1945), -- Na Drini cuprija
(1966), -- Vasar u Topoli
(1866); -- 

SELECT *
FROM Knjiga_dodatniPodaci;

-- Tabela ,,Knjiga''

CREATE TABLE Knjiga(
  ISBN CHAR(17) PRIMARY KEY,
  naziv VARCHAR(70) NOT NULL,
  knjizevni_rod_id INT FOREIGN KEY REFERENCES Knjizevni_rod(id),
  knjizevna_vrsta_id INT FOREIGN KEY REFERENCES Knjizevna_vrsta(id),
  dodatniPodaci_id INT FOREIGN KEY REFERENCES Knjiga_dodatniPodaci(id),
  izdavac_id INT FOREIGN KEY REFERENCES Izdavac(id),
  kolicina INT NOT NULL
);

INSERT INTO Knjiga (ISBN, naziv, knjizevni_rod_id, knjizevna_vrsta_id, dodatniPodaci_id, izdavac_id, kolicina) VALUES ('978-86-1729-12-17', 'Na Drini cuprija', 2, 1, 1, 2, 5),
('978-86-7401-132-1', 'Ana Karenjina', 2, 1, NULL, 1, 3),
('978-86-4130-1-131', 'Rat i mir', 2, 1, NULL, 3, 0),
('978-86-7410-431-1', '20000 milja pod morem', 2, 1, NULL, 5, 5),
('978-86-4710-709-2', 'Vasar u Topoli', 1, 6, 2, 4, 0),
('978-86-4109-812-5', 'Koreni', 2, 1, NULL, 2, 5),
('978-86-0971-8-838', 'Deobe', 2, 1, NULL, 1, 10),
('978-86-0183-99-22', 'Vreme vlasti', 2, 1, NULL, 4, 7),
('978-86-0193-092-1', 'Dervis i smrt', 2, 1, 2, 3, 4),
('978-86-8536-928-6', 'Zivotinjska farma', 2, 1, 1, 1, 4);

SELECT *
FROM Knjiga;

-- Tabela ,,Autor_Knjiga''

CREATE TABLE Autor_Knjiga(
  id INT PRIMARY KEY IDENTITY (1, 1),
  autor_id INT FOREIGN KEY REFERENCES Autor(id),
  knjiga_ISBN CHAR(17) FOREIGN KEY REFERENCES Knjiga(ISBN)
);

-- Tabela ,,Pozajmica''

CREATE TABLE Pozajmica(
  id INT PRIMARY KEY IDENTITY (1, 1),
  datum_uzimanja DATE NOT NULL,
  rok INT NOT NULL,
  datum_vracanja DATE NOT NULL, -- uraditi funkciju!
  vraceno CHAR(2) NOT NULL,
  clan_email VARCHAR(50) FOREIGN KEY REFERENCES Korisnik(email),
  zaposleni_email VARCHAR(50) FOREIGN KEY REFERENCES Korisnik(email),
  knjiga_ISBN CHAR(17) FOREIGN KEY REFERENCES Knjiga(ISBN)
);

-- Stor procedure:

go
CREATE PROCEDURE Uloguj_se
@email VARCHAR(50),
@lozinka VARCHAR(30)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS(SELECT TOP 1 email FROM Korisnik
  WHERE email = @email AND lozinka = @lozinka)
  BEGIN
    RETURN 0;
  END;
  RETURN 1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Korisnik_Insert
@email VARCHAR(50),
@lozinka VARCHAR(30)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 email FROM Korisnik
  WHERE email = @email)
  RETURN 1
  ELSE
    INSERT INTO Korisnik (email, lozinka) VALUES (@email, @lozinka)
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Korisnik_Update
@email NVARCHAR(50),
@lozinka NVARCHAR(100)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 email FROM Korisnik
  WHERE email = @email)
  BEGIN
    UPDATE Korisnik SET lozinka = @lozinka WHERE email = @email
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Izdavac_Insert
@ime VARCHAR(50),
@sediste VARCHAR(50)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 ime FROM Izdavac
  WHERE ime = @ime)
  RETURN 1;
  ELSE
    INSERT INTO Izdavac (ime, sediste) VALUES (@ime, @sediste)
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Izdavac_Update
@id INT,
@ime VARCHAR(50),
@sediste VARCHAR(50)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 ime FROM Izdavac
  WHERE ime = @ime)
  BEGIN
    UPDATE Izdavac SET ime = @ime, sediste = @sediste WHERE id = @id;
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Knjizevna_vrsta_Insert
@naziv VARCHAR(50),
@opis VARCHAR(500),
@knjizevni_rod_id INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 naziv FROM Knjizevna_vrsta
  WHERE naziv = @naziv)
  RETURN 1;
  ELSE
    INSERT INTO Knjizevna_vrsta (naziv, opis, knjizevni_rod_id) VALUES (@naziv, @opis, @knjizevni_rod_id);
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Knjizevna_vrsta_Update
@id INT,
@naziv VARCHAR(50),
@opis VARCHAR(500),
@knjizevni_rod_id INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 naziv FROM Knjizevna_vrsta
  WHERE id = @id)
  BEGIN
    UPDATE Knjizevna_vrsta SET naziv = @naziv, opis = @opis, knjizevni_rod_id = @knjizevni_rod_id WHERE id = @id;
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Autor_Insert
@id INT,
@ime VARCHAR(20),
@prezime VARCHAR(50),
@dodatniPodaci_id INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Autor
  WHERE id = @id)
  RETURN 1;
  ELSE
    INSERT INTO Autor (ime, prezime, dodatniPodaci_id) VALUES (@ime, @prezime, @dodatniPodaci_id);
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Autor_Update
@id INT,
@ime VARCHAR(20),
@prezime VARCHAR(50),
@dodatniPodaci_id INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Autor
  WHERE id = @id)
  BEGIN
    UPDATE Autor SET ime = @ime, prezime = @prezime, dodatniPodaci_id = @dodatniPodaci_id WHERE id = @id;
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Knjiga_Insert
@naziv VARCHAR(70),
@knjizevni_rod_id INT,
@knjizevna_vrsta_id INT,
@dodatniPodaci_id INT,
@izdavac_id INT,
@kolicina INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 naziv FROM Knjiga
  WHERE naziv = @naziv)
  RETURN 1;
  ELSE
    INSERT INTO Knjiga (naziv, knjizevni_rod_id, knjizevna_vrsta_id, dodatniPodaci_id, izdavac_id, kolicina) VALUES (@naziv, @knjizevni_rod_id, @knjizevna_vrsta_id, @dodatniPodaci_id, @izdavac_id, @kolicina);
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Knjiga_Update
@ISBN CHAR(17),
@naziv VARCHAR(70),
@knjizevni_rod_id INT,
@knjizevna_vrsta_id INT,
@dodatniPodaci_id INT,
@izdavac_id INT,
@kolicina INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 ISBN FROM Knjiga
  WHERE ISBN = @ISBN)
  BEGIN
    UPDATE Knjiga SET naziv = @naziv, knjizevni_rod_id = @knjizevni_rod_id, knjizevna_vrsta_id = @knjizevna_vrsta_id, dodatniPodaci_id = @dodatniPodaci_id, izdavac_id = @izdavac_id, kolicina = @kolicina WHERE ISBN = @ISBN;
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Autor_dodatniPodaci_Insert
@id INT,
@datum_rodjenja DATE,
@datum_smrti DATE,
@mesto_rodjenja VARCHAR(40),
@mesto_smrti VARCHAR(40),
@biografija VARCHAR(2000),
@ocena INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Autor_dodatniPodaci
  WHERE id = @id)
  RETURN 1;
  ELSE
    INSERT INTO Autor_dodatniPodaci (datum_rodjenja, datum_smrti, mesto_rodjenja, mesto_smrti, biografija, ocena) VALUES (@datum_rodjenja, @datum_smrti, @mesto_rodjenja, @mesto_smrti, @biografija, @ocena);
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Autor_dodatniPodaci_Update
@id INT,
@datum_rodjenja DATE,
@datum_smrti DATE,
@mesto_rodjenja VARCHAR(40),
@mesto_smrti VARCHAR(40),
@biografija VARCHAR(2000),
@ocena INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Autor_dodatniPodaci
  WHERE id = @id)
  BEGIN
    UPDATE Autor_dodatniPodaci SET datum_rodjenja = @datum_rodjenja, datum_smrti = @datum_smrti, mesto_rodjenja = @mesto_rodjenja, mesto_smrti = @mesto_smrti, biografija = @biografija, ocena = @ocena WHERE id = @id;
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Pozajmica_Insert
@id INT,
@datum_uzimanja DATE,
@rok INT,
@vraceno CHAR(2),
@clan_email VARCHAR(50),
@zaposleni_email VARCHAR(50),
@knjiga_ISBN CHAR(17)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Pozajmica
  WHERE id = @id)
  RETURN 1;
  ELSE
    INSERT INTO Pozajmica (id, datum_uzimanja, rok, vraceno, clan_email, zaposleni_email, knjiga_ISBN) VALUES (@id, @datum_uzimanja, @rok, @vraceno, @clan_email, @zaposleni_email, @knjiga_ISBN);
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Pozajmica_Update
@id INT,
@datum_uzimanja DATE,
@rok INT,
@vraceno CHAR(2),
@clan_email VARCHAR(50),
@zaposleni_email VARCHAR(50),
@knjiga_ISBN CHAR(17)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Pozajmica
  WHERE id = @id)
  BEGIN
    UPDATE Pozajmica SET datum_uzimanja = @datum_uzimanja, rok = @rok, vraceno = @vraceno, clan_email = @clan_email, zaposleni_email = @zaposleni_email, knjiga_ISBN = @knjiga_ISBN WHERE id = @id;
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Knjiga_dodatniPodaci_Insert
@id INT,
@godina_objavljivanja INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Knjiga_dodatniPodaci
  WHERE id = @id)
  RETURN 1;
  ELSE
    INSERT INTO Knjiga_dodatniPodaci (godina_objavljivanja) VALUES (@godina_objavljivanja);
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Knjiga_dodatniPodaci_Update
@id INT,
@godina_objavljivanja INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Knjiga_dodatniPodaci
  WHERE id = @id)
  BEGIN
    UPDATE Knjiga_dodatniPodaci SET godina_objavljivanja = @godina_objavljivanja WHERE id = @id;
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Autor_Knjiga_Insert
@id INT,
@autor_id INT,
@knjiga_ISBN CHAR(17)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Autor_Knjiga
  WHERE id = @id)
  RETURN 1;
  ELSE
    INSERT INTO Autor_Knjiga (autor_id, knjiga_ISBN) VALUES (@autor_id, @knjiga_ISBN);
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Autor_Knjiga_Update
@id INT,
@autor_id INT,
@knjiga_ISBN CHAR(17)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 id FROM Autor_Knjiga
  WHERE id = @id)
  BEGIN
    UPDATE Autor_Knjiga SET autor_id = @autor_id, knjiga_ISBN = @knjiga_ISBN WHERE id = @id;
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

USE Skolska_biblioteka;