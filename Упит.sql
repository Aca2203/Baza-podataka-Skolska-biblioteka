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

-- Функција ,,brojGodina''

CREATE FUNCTION brojGodina(@godiste DATE)
RETURNS INT
AS
	BEGIN
		DECLARE @broj INT = DATEDIFF(YEAR, @godiste, GETDATE());
		IF RIGHT(CONVERT(VARCHAR, @godiste, 112), 4) > RIGHT(CONVERT(VARCHAR, GETDATE(), 112), 4) RETURN @broj - 1;
		RETURN @broj;
	END;

-- Табела ,,Korisnik''

CREATE TABLE Korisnik(
  email NVARCHAR(50) PRIMARY KEY,
  lozinka NVARCHAR(30) NOT NULL,
  jmbg CHAR(13) NOT NULL,
  ime NVARCHAR(20) NOT NULL,
  prezime NVARCHAR(50) NOT NULL,
  datum_rodjenja DATE,
  broj_godina AS dbo.brojGodina(datum_rodjenja),
  uloga_id INT FOREIGN KEY REFERENCES Uloga(id)
);

INSERT INTO Korisnik (email, lozinka, jmbg, ime, prezime, datum_rodjenja, uloga_id) VALUES (N'stefanovicsalex@SKBibioteka_C.rs', N'coamafija1312', '2210003710256', N'Александар', N'Стефановић', '2003-10-22', 1),
(N'stefanovicsalex@SKBibioteka_Z.rs', N'coamafija1312', '2210003710256', N'Александар', N'Стефановић', '2003-10-22', 2),
(N'stefanovicsalex@SKBibioteka_A.rs', N'coamafija1312', '2210003710256', N'Александар', N'Стефановић', '2003-10-22', 3);

DELETE FROM Korisnik;

SELECT *
FROM Korisnik;