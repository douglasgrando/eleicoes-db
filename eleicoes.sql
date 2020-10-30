create database eleicoes;
use eleicoes;

create table voto(
id int primary key auto_increment,
nome_ele varchar (200),
nome_candidado varchar(200),
id_eleitor int,
cd_candidado int,
data_do_voto timestamp,
nome_mesario varchar(200),
codigo_mesario int,
ano_eleicao year,
nome_eleicao varchar(200),
codigo_eleicao varchar(200)
); 
create table eleicao(
id int primary key auto_increment,
nome varchar(200) 
);

create table candidado(
id int primary key auto_increment,
nome varchar(200) ,
numero varchar(200),
data_nascimento date,
sexo varchar(500),
cpf varchar(300)
);

create table eleitor(
id int primary key auto_increment,
nome varchar(200) ,
numero varchar(200),
data_nascimento date,
sexo varchar(500),
cpf varchar(300)
);


insert into candidado(nome,numero,data_nascimento,sexo,cpf)
values('Rafael','123',current_date(),'M',11111);
insert into candidado(nome,numero,data_nascimento,sexo,cpf)
values('Ana','456',current_date(),'M',11111);
insert into candidado(nome,numero,data_nascimento,sexo,cpf)
values('Joao','789',current_date(),'M',11111);


insert into eleitor(nome,numero,data_nascimento,sexo,cpf)
values('Rafael','123',current_date(),'M',11111);

insert into eleitor(nome,numero,data_nascimento,sexo,cpf)
values('pedro','123',current_date(),'M',11111);

insert into eleitor(nome,numero,data_nascimento,sexo,cpf)
values('paulo','123',current_date(),'M',11111);


insert into eleicao (nome) values ('Eleição 2020');

insert into voto(nome_ele,nome_candidado,id_eleitor,cd_candidado,data_do_voto,nome_mesario,ano_eleicao,codigo_eleicao)
values ('Rafael','Ana',1,1,current_date(),'Mesaria Ana',2020,1);

insert into voto(nome_ele,nome_candidado,id_eleitor,cd_candidado,data_do_voto,nome_mesario,ano_eleicao,codigo_eleicao)
values ('pedro','paulo',1,1,current_date(),'Mesaria Ana',2020,1);


ALTER TABLE eleitor MODIFY COLUMN cpf int(11);
ALTER TABLE eleitor MODIFY COLUMN numero int(11);
ALTER TABLE eleitor MODIFY COLUMN sexo varchar(1);

RENAME TABLE candidado TO candidato;
ALTER TABLE candidato MODIFY COLUMN cpf int(11);
ALTER TABLE candidato MODIFY COLUMN numero int(11);
ALTER TABLE candidato MODIFY COLUMN sexo varchar(1);

ALTER TABLE voto CHANGE codigo_mesario id_mesario int(11);
ALTER TABLE voto CHANGE codigo_eleicao id_eleicao int(11);
ALTER TABLE voto CHANGE cd_candidado id_candidato int(11);
ALTER TABLE voto CHANGE nome_ele nome_eleitor varchar(200);
ALTER TABLE voto CHANGE nome_candidado nome_candidato varchar(200);

CREATE TABLE mesario(
id int PRIMARY KEY auto_increment,
nome varchar(200)
);

ALTER TABLE voto ADD FOREIGN KEY (id_eleitor) REFERENCES eleitor(id);
ALTER TABLE voto ADD FOREIGN KEY (id_candidato) REFERENCES candidato(id);
ALTER TABLE voto ADD FOREIGN KEY (id_eleicao) REFERENCES eleicao(id);
ALTER TABLE voto ADD FOREIGN KEY (id_mesario) REFERENCES mesario(id);


insert into mesario (nome) 
select DISTINCT nome_mesario from voto;

update voto set id_mesario=(
SELECT id from mesario where nome_mesario=mesario.nome
);

update voto set id_eleitor=(
SELECT id from eleitor where eleitor.nome=nome_eleitor
);

ALTER TABLE voto DROP nome_eleitor;
ALTER TABLE voto DROP nome_eleicao;
ALTER TABLE voto DROP nome_mesario;
ALTER TABLE voto DROP nome_candidato;

SELECT eleitor.nome AS Eleitor, candidato.nome AS Candidato, candidato.numero AS Número, eleicao.nome AS Eleição, mesario.nome AS Mesário FROM voto 
INNER JOIN candidato ON candidato.id=voto.id_candidato
INNER JOIN eleicao ON eleicao.id=voto.id_eleicao
INNER JOIN mesario ON mesario.id=voto.id_mesario
INNER JOIN eleitor ON eleitor.id=voto.id_eleitor;
