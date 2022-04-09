CREATE DATABASE [Skolska biblioteka];
USE [Skolska biblioteka];

CREATE TABLE Uloga(
  id INT PRIMARY KEY,
  naziv NVARCHAR(50) NOT NULL
);

INSERT INTO Uloga (id, naziv) VALUES (1, N'Члан'),
(2, N'Запослени'),
(3, N'Администратор');

SELECT *
FROM Uloga;

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