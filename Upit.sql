-- Kreiranje baze podataka:

CREATE DATABASE Skolska_biblioteka2;
USE Skolska_biblioteka2;

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
  naziv VARCHAR(50) NOT NULL
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
	
-- Tabela ,,Korisnik''

CREATE TABLE Korisnik(
  email VARCHAR(50) PRIMARY KEY,
  lozinka VARCHAR(30) NOT NULL,
  jmbg CHAR(13) NOT NULL,
  ime VARCHAR(20) NOT NULL,
  prezime VARCHAR(50) NOT NULL,  
  uloga_id INT FOREIGN KEY REFERENCES Uloga(id)
);

INSERT INTO Korisnik (email, lozinka, jmbg, ime, prezime, uloga_id) VALUES (N'stefanovicsalex@SKBibioteka_C.rs', 'aca123', '2210003710256', 'Aleksandar', 'Stefanovic', 1),
('stefanovicsalex@SKBibioteka_Z.rs', 'aca123', '2210003710256', 'Aleksandar', 'Stefanovic', 2),
('stefanovicsalex@SKBibioteka_A.rs', 'aca123', '2210003710256', 'Aleksandar', 'Stefanovic', 3),
('aleksandargerasimovic@SKBibioteka_A.rs', 'alekgera551', '1502970710742', 'Aleksandar', 'Gerasimovic', 3),
('milosurosevic@SKBibioteka_C.rs', 'losmi321', '2106003710932', 'Milos', 'Urosevic', 1),
('jelenanikolic@SKBibioteka_Z.rs', 'jecapereca95', '1707995700111', 'Jelena', 'Nikolic', 2),
('nikolavucic@SKBibioteka_Z.rs', 'dzonidep83', '1704983710932', 'Nikola', 'Vucic', 2),
('marijapasic@SKBibioteka_C.rs', 'marija121', '3004004700932', 'Marija', 'Pasic', 1);

SELECT *
FROM Korisnik;

-- Tabela ,,Autor''

CREATE TABLE Autor(
  id INT PRIMARY KEY IDENTITY (1, 1),
  ime VARCHAR(20) NOT NULL,
  prezime VARCHAR(50) NOT NULL
);

INSERT INTO Autor (ime, prezime) VALUES ('Ivo', 'Andric'),
('Dobrica', 'Eric'),
('Fjodor', 'Mihajlovic Dostojevski'),
('Dobrica', 'Cosic'),
('Milos', 'Crnjanski'),
('Lav', 'Nikolajevic Tolstoj'),
('Mark', 'Tven'),
('Dzordz', 'Orvel'),
('Zil', 'Vern'),
('Mesa', 'Selimovic');

SELECT *
FROM Autor;

-- Tabela ,,Knjiga''

CREATE TABLE Knjiga(
  ISBN CHAR(17) PRIMARY KEY,
  naziv VARCHAR(70) NOT NULL,
  knjizevni_rod_id INT FOREIGN KEY REFERENCES Knjizevni_rod(id),
  knjizevna_vrsta_id INT FOREIGN KEY REFERENCES Knjizevna_vrsta(id),
  izdavac_id INT FOREIGN KEY REFERENCES Izdavac(id),
  kolicina INT NOT NULL
);

INSERT INTO Knjiga (ISBN, naziv, knjizevni_rod_id, knjizevna_vrsta_id, izdavac_id, kolicina) VALUES ('978-86-1729-12-17', 'Na Drini cuprija', 2, 1, 2, 5),
('978-86-7401-132-1', 'Ana Karenjina', 2, 1, 1, 3),
('978-86-4130-1-131', 'Rat i mir', 2, 1, 3, 0),
('978-86-7410-431-1', '20000 milja pod morem', 2, 1, 5, 5),
('978-86-4710-709-2', 'Vasar u Topoli', 1, 6, 4, 0),
('978-86-4109-812-5', 'Koreni', 2, 1, 2, 5),
('978-86-0971-8-838', 'Deobe', 2, 1, 1, 10),
('978-86-0183-99-22', 'Vreme vlasti', 2, 1, 4, 7),
('978-86-0193-092-1', 'Dervis i smrt', 2, 1, 3, 4),
('978-86-8536-928-6', 'Zivotinjska farma', 2, 1, 1, 4);

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
  datum_vracanja DATE NOT NULL,
  vraceno CHAR(2) NOT NULL,
  clan_email VARCHAR(50) FOREIGN KEY REFERENCES Korisnik(email),
  zaposleni_email VARCHAR(50) FOREIGN KEY REFERENCES Korisnik(email),
  knjiga_ISBN CHAR(17) FOREIGN KEY REFERENCES Knjiga(ISBN)
);

select *
from Pozajmica;

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
    DECLARE @uloga INT;
    SET @uloga = (SELECT TOP 1 uloga_id FROM Korisnik
    WHERE email = @email AND lozinka = @lozinka);
  
    IF (@uloga = 1)
    BEGIN
      RETURN 1;
    END
    IF (@uloga = 2)
    BEGIN
      RETURN 2;
    END
    IF (@uloga = 3)
    BEGIN
      RETURN 3;
    END
  END;
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

go
CREATE PROCEDURE Korisnik_Insert
@email VARCHAR(50),
@lozinka VARCHAR(30),
@jmbg CHAR(17),
@ime VARCHAR(20),
@prezime VARCHAR(50),
@uloga_id INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 email FROM Korisnik
  WHERE email = @email)
  RETURN 1
  ELSE
    INSERT INTO Korisnik (email, lozinka, jmbg, ime, prezime, uloga_id) VALUES (@email, @lozinka, @jmbg, @ime, @prezime, @uloga_id)
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

SELECT *
FROM Korisnik;

go
CREATE PROCEDURE Korisnik_Update
@email VARCHAR(50),
@lozinka VARCHAR(100),
@ime VARCHAR(20),
@prezime VARCHAR(50),
@jmbg CHAR(13),
@uloga_id INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  IF EXISTS (SELECT TOP 1 email FROM Korisnik
  WHERE email = @email)
  BEGIN
    UPDATE Korisnik SET lozinka = @lozinka, ime = @ime, prezime = @prezime, jmbg = @jmbg, uloga_id = @uloga_id WHERE email = @email
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
alter PROCEDURE Pozajmica_Insert
@datum_uzimanja DATE,
@datum_vracanja DATE,
@clan_email VARCHAR(50),
@zaposleni_email VARCHAR(50),
@knjiga_ISBN CHAR(17)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF (SELECT kolicina FROM Knjiga WHERE ISBN = @knjiga_ISBN) = 0 RETURN -1;
	IF EXISTS(SELECT TOP 1 id FROM Pozajmica WHERE clan_email = @clan_email AND vraceno = 'ne') RETURN -2;
    INSERT INTO Pozajmica (datum_uzimanja, datum_vracanja, vraceno, clan_email, zaposleni_email, knjiga_ISBN) VALUES (@datum_uzimanja, @datum_vracanja, 'ne', @clan_email, @zaposleni_email, @knjiga_ISBN);
    UPDATE Knjiga
    SET kolicina = kolicina - 1
    WHERE ISBN = @knjiga_ISBN;
    RETURN 0;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

SELECT *
FROM Knjiga;

select * from Pozajmica;
SELECT TOP 1 id FROM Pozajmica
  WHERE id = 0

go
alter PROCEDURE Pozajmica_Update
@id INT,
@datum_uzimanja DATE,
@datum_vracanja DATE,
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
    UPDATE Pozajmica SET datum_uzimanja = @datum_uzimanja, datum_vracanja = @datum_vracanja, vraceno = @vraceno, clan_email = @clan_email, zaposleni_email = @zaposleni_email, knjiga_ISBN = @knjiga_ISBN WHERE id = @id;
    RETURN 0;
  END
  RETURN -1;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;
go

CREATE PROCEDURE Pozajmica_Delete
@id INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
  DECLARE @knjiga_ISBN CHAR(17);
  SELECT @knjiga_ISBN = knjiga_ISBN FROM Pozajmica WHERE id = @id;
  DELETE FROM Pozajmica WHERE id = @id;  
  
  UPDATE Knjiga
  SET kolicina = kolicina + 1
  WHERE ISBN = @knjiga_ISBN;
END TRY
BEGIN CATCH
  RETURN @@ERROR;
END CATCH;

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