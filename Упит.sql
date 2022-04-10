CREATE DATABASE [Skolska biblioteka];
USE [Skolska biblioteka];

-- Табела ,,Uloga''

CREATE TABLE Uloga(
  id INT PRIMARY KEY,
  naziv NVARCHAR(50) NOT NULL
);

INSERT INTO Uloga (id, naziv) VALUES (1, N'Члан'),
(2, N'Запослени'),
(3, N'Администратор');

SELECT *
FROM Uloga;

-- Табела ,,Izdavac''

CREATE TABLE Izdavac(
  id INT PRIMARY KEY,
  ime NVARCHAR(50) NOT NULL,
  sediste NVARCHAR(50) NOT NULL
);

INSERT INTO Izdavac (id, ime, sediste) VALUES (1, N'Дерета', N'Кнез Михаилова 46, Београд'),
(2, N'Вулкан', N'Господара Вучића 245, Београд'),
(3, N'Лагуна', N'Ресавска 33, Београд'),
(4, N'Креативни центар', N'Градиштанска 8, Београд'),
(5, N'Пчелица', N'Колубарска 4, Чачак');

SELECT *
FROM Izdavac;

-- Табела ,,Knjizevni_rod''

CREATE TABLE Knjizevni_rod(
  id INT PRIMARY KEY,
  naziv NVARCHAR(50) NOT NULL,
  opis NVARCHAR(500)
);

INSERT INTO Knjizevni_rod (id, naziv, opis) VALUES (1, N'Лирика', N'Најчешће кроз стихове, лирика испуњава осећањима среће и љубави, наводи читаоца на размишљање а понекад садржи и религиозне елементе. Најчешће нема радњу, већ је само приказана једна целина.'),
(2, N'Епика', N'Епика нам преноси детаље неког догађаја, радњу, ватрене борбе и двобоје са бројним преокретима. Епска дела се најчешће завршавају са веома важном моралном поруком.'),
(3, N'Драма', N'У драму се углавном убрајају дела намењена за извођење у позоришту. Драмска дела су веома разноврсна: са или без радње, са срећним или трагичним крајем, али оно што их разликује од лирике и епике јесте сликовит приказ читавог дела, чиме оно постаје ближе и разумљивије гледаоцу.');

SELECT *
FROM Knjizevni_rod;

-- Табела ,,Knjizevna_vrsta''

CREATE TABLE Knjizevna_vrsta(
  id INT PRIMARY KEY,
  naziv NVARCHAR(50) NOT NULL,
  opis NVARCHAR(500),
  knjizevni_rod_id INT FOREIGN KEY REFERENCES Knjizevni_rod(id)
);

INSERT INTO Knjizevna_vrsta (id, naziv, knjizevni_rod_id) VALUES (1, N'роман', 2),
(2, N'комедија', 3),
(3, N'трагедија', 3),
(4, N'љубавна песма', 1),
(5, N'збирка приповедака', 2);

SELECT *
FROM Knjizevna_vrsta;

-- Функција ,,datumRodjenja''

CREATE FUNCTION datumRodjenja(@jmbg CHAR(13))
RETURNS DATE
AS
	BEGIN
		DECLARE @datum_rodjenja DATE;
		IF SUBSTRING(@jmbg, 5, 1) = '0' SET @datum_rodjenja = '2' + SUBSTRING(@jmbg, 5, 3) + '-' + SUBSTRING(@jmbg, 3, 2) + '-' + SUBSTRING(@jmbg, 1, 2)
		ELSE SET @datum_rodjenja = '1' + SUBSTRING(@jmbg, 5, 3) + '-' + SUBSTRING(@jmbg, 3, 2) + '-' + SUBSTRING(@jmbg, 1, 2);
		
		RETURN @datum_rodjenja;
	END;
	
DROP FUNCTION datumRodjenja;

-- Функција ,,brojGodina''

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
	
DROP FUNCTION brojGodina;

-- Табела ,,Korisnik''

CREATE TABLE Korisnik(
  email NVARCHAR(50) PRIMARY KEY,
  lozinka NVARCHAR(30) NOT NULL,
  jmbg CHAR(13) NOT NULL,
  ime NVARCHAR(20) NOT NULL,
  prezime NVARCHAR(50) NOT NULL,
  datum_rodjenja AS dbo.datumRodjenja(jmbg),
  broj_godina AS dbo.brojGodina(jmbg),
  uloga_id INT FOREIGN KEY REFERENCES Uloga(id)
);

DROP TABLE Korisnik;

INSERT INTO Korisnik (email, lozinka, jmbg, ime, prezime, uloga_id) VALUES (N'stefanovicsalex@SKBibioteka_C.rs', N'coamafija1312', '2210003710256', N'Александар', N'Стефановић', 1),
(N'stefanovicsalex@SKBibioteka_Z.rs', N'coamafija1312', '2210003710256', N'Александар', N'Стефановић', 2),
(N'stefanovicsalex@SKBibioteka_A.rs', N'coamafija1312', '2210003710256', N'Александар', N'Стефановић', 3),
(N'aleksandargerasimovic@SKBibioteka_A.rs', N'alekgera551', '1502970710742', N'Александар', N'Герасимовић', 3),
(N'milosurosevic@SKBibioteka_C.rs', N'losmi321', '2106003710932', N'Милош', N'Урошевић', 1),
(N'jelenanikolic@SKBibioteka_Z.rs', N'jecapereca95', '1707995700111', N'Јелена', N'Николић', 2),
(N'nikolavucic@SKBibioteka_Z.rs', N'dzonidep83', '1704983710932', N'Никола', N'Вучић', 2),
(N'marijapasic@SKBibioteka_C.rs', N'marija121', '3004004700932', N'Марија', N'Пашић', 1);

DELETE FROM Korisnik;

SELECT *
FROM Korisnik;

CREATE FUNCTION brojGodinaAutor(@datum_rodjenja DATE, @datum_smrti DATE)
RETURNS INT
AS
BEGIN
	DECLARE @broj INT = DATEDIFF(YEAR, @datum_rodjenja, @datum_smrti);
	IF RIGHT(CONVERT(VARCHAR, @datum_rodjenja, 112), 4) > RIGHT(CONVERT(VARCHAR, @datum_smrti, 112), 4) RETURN @broj - 1;
	RETURN @broj;
END;

DROP FUNCTION brojGodinaAutor

CREATE TABLE Autor_dodatniPodaci(
  id INT PRIMARY KEY,
  datum_rodjenja DATE,
  datum_smrti DATE,
  broj_godina AS dbo.brojGodinaAutor(datum_rodjenja, datum_smrti),
  mesto_rodjenja NVARCHAR(40),
  mesto_smrti NVARCHAR(40),
  biografija NVARCHAR(2000),
  ocena INT -- од 1 до 10
);

DROP TABLE Autor_dodatniPodaci

INSERT INTO Autor_dodatniPodaci (id, datum_rodjenja, datum_smrti, mesto_rodjenja, mesto_smrti, ocena) VALUES (1, '1892-10-09', '1975-03-13', N'Долац, Аустроугарска', N'Београд, СФР Југославија', 10), -- Иво Андрић
(2, '1821-11-11', '1881-02-09', N'Москва, Руска Империја', N'Санкт Петербург, Руска Империја', 9), -- Достојевски
(3, '1828-09-09', '1910-11-20', N'Јасна Пољана, Руска Империја', N'Астапово, Руска Империја', 8); -- Толстој

SELECT *
FROM Autor_dodatniPodaci;

DELETE FROM Autor_dodatniPodaci;

USE [Skolska biblioteka];