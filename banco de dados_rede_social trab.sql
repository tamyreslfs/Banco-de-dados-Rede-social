create database rede_social;

use rede_social;

CREATE TABLE Usuarios (
    id_usuarios INT primary KEY,
    nome VARCHAR(255)
);


CREATE TABLE Postagens (
    id_postagens INT auto_increment PRIMARY KEY,
    id_usuarios INT,
    texto TEXT,
    data_postagem DATE,
    FOREIGN KEY (id_usuarios) REFERENCES Usuarios(id_usuarios)

);

drop table Postagens;
CREATE TABLE Comentarios (
    id_comentarios INT PRIMARY KEY,
    id_postagens INT,
    texto TEXT,
    data_comentario DATE,
    FOREIGN KEY (id_postagens) REFERENCES Postagens(id_postagens)
);

CREATE TABLE Amizades (
    id1_usuario INT,
    id2_usuario INT,
    data_amizade DATE,
    PRIMARY KEY (id1_usuario, id2_usuario),
    FOREIGN KEY (id1_usuario) REFERENCES Usuarios(id_usuarios),
    FOREIGN KEY (id2_usuario) REFERENCES Usuarios(id_usuarios)
);

insert into Usuarios (nome) values ('João');
select * from Usuarios where nome = 'João';
insert into Usuarios (nome) values ('Maria');

insert into Postagens (id_usuarios, texto, data_postagem) values (1, 'Bom dia, Mundo', current_date);
insert into Postagens (id_usuarios, texto, data_postagem) values (2, 'Boa noite, Mundo', current_date);

SELECT * FROM Postagens WHERE id_usuarios = (SELECT id_usuarios FROM Usuarios WHERE nome = 'João');

SELECT Usuarios.nome, COUNT(Postagens.id_postagens) AS total_postagens, COUNT(Comentarios.id_comentarios) AS total_comentarios
FROM Usuarios
LEFT JOIN Postagens ON Usuarios.id_usuarios = Postagens.id_usuarios
LEFT JOIN Comentarios ON Usuarios.id_usuarios = (SELECT Usuarios.id_usuarios FROM Usuarios WHERE nome = 'João') AND Comentarios.id_postagens = Postagens.id_postagens
GROUP BY Usuarios.id_usuarios;

SELECT Usuarios.*, Postagens.*, Amizades.*
FROM Usuarios
LEFT JOIN Postagens ON Usuarios.id_usuarios = Postagens.id_usuarios
LEFT JOIN Amizades ON Usuarios.id_usuarios = Amizades.id1_usuario OR Usuarios.id_usuarios = Amizades.id2_usuario
WHERE Usuarios.nome = 'Maria';

SELECT * FROM Amizades WHERE data_amizade >= NOW() - INTERVAL 30 DAY;

SELECT * FROM Postagens WHERE id_postagens = 2;


