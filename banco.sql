------------- USUARIO ---------------------------
CREATE TABLE usuario
(
  uid serial NOT NULL,
  tipouser integer DEFAULT 3,
  login character varying(50) NOT NULL,
  senha character varying(50) NOT NULL,
  nome character varying(100) NOT NULL,
  cpf character varying(20),
  rg_org character varying(10),
  rg_num character varying(20),
  nome_cracha character varying(100),
  email character varying(100) UNIQUE,
  logradouro character varying(100),
  complemento character varying(100),
  bairro character varying(100),
  cep character varying(20),
  cidade character varying(50),
  estado character varying(20),
  tel_tipo character varying(15),
  tel_ddd character varying(5),
  tel_num character varying(15),
  data_nasc date,
  estado_civil character varying(20),
  escolaridade character varying(50),
  profissao character varying(50),
  instituicao_origem character varying(100),
  sexo character varying(20),
  foto bytea,
  idFace varchar(100), 
  CONSTRAINT pk_usuario PRIMARY KEY (uid ),
  CONSTRAINT uk_usuario_login UNIQUE (login )
);
select * from usuario; -- "797298227076300"
alter table usuario add column foto bytea;
alter table usuario drop column idface;
delete from usuario where nome = 'nego';
-------------------- LOCAL_ED ----------------------------
CREATE TABLE local_ed
(
  id serial NOT NULL,
  logradouro character varying(100),
  complemento character varying(100),
  bairro character varying(50),
  cep character varying(15),
  cidade character varying(30),
  estado character varying(30),
  tel_tipo character varying(15),
  tel_ddd character varying(5),
  tel_num character varying(20),
  latitude character varying(30),
  longitude character varying(30),
  nome character varying(100),
  CONSTRAINT local_ed_pkey PRIMARY KEY (id ),
  CONSTRAINT local_ed_nome_key UNIQUE (nome )
);

---------------------- INSCRICAO -----------------------------
CREATE TABLE inscricao
(
  id serial NOT NULL,
  idusuario integer,
  idedicao integer,
  valor_inscricao double precision,
  conhecimento_evento character varying(150),
  acompanhante character varying(100),
  valor_pago double precision,
  data_inscricao date DEFAULT(current_date),
  status_inscricao integer DEFAULT 0,
  status_pagamento integer DEFAULT 0,
  CONSTRAINT inscricao_pkey PRIMARY KEY (id ),
  CONSTRAINT inscricao_idedicao_fkey FOREIGN KEY (idedicao)
      REFERENCES edicoes (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT inscricao_idusuario_fkey FOREIGN KEY (idusuario)
      REFERENCES usuario (uid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

---------------- FORMAS_PAGAMENTO -----------------------------
CREATE TABLE formas_pagamento
(
  id serial NOT NULL,
  formas_pagamento character varying(100),
  CONSTRAINT formas_pagamento_pkey PRIMARY KEY (id )
);


---------------------- EVENTO ---------------------------------
CREATE TABLE evento
(
  id serial NOT NULL,
  titulo character varying(200),
  descricao character varying(200),
  inf_importantes character varying(200),
  id_entidadepromotora character varying(200),
  status integer DEFAULT 0,
  CONSTRAINT evento_pkey PRIMARY KEY (id ),
  CONSTRAINT evento_titulo_key UNIQUE (titulo )
);

----------------------- ENTIDADE_PROMOTORA ----------------------
CREATE TABLE entidade_promotora
(
  id serial NOT NULL,
  nome character varying(150),
  descricao character varying(150),
  CONSTRAINT entidade_promotora_pkey PRIMARY KEY (id )
);

----------------------- EDICOES ---------------------------------
CREATE TABLE edicoes
(
  id serial NOT NULL,
  nome character varying(100),
  idlocal integer,
  nomelocal character varying(100),
  idevento integer,
  idformas_pagamento integer,
  preco double precision,
  CONSTRAINT edicoes_pkey PRIMARY KEY (id ),
  CONSTRAINT edicoes_idevento_fkey FOREIGN KEY (idevento)
      REFERENCES evento (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT edicoes_idformas_pagamento_fkey FOREIGN KEY (idformas_pagamento)
      REFERENCES formas_pagamento (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT edicoes_idlocal_fkey FOREIGN KEY (idlocal)
      REFERENCES local_ed (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT edicoes_nomelocal_fkey FOREIGN KEY (nomelocal)
      REFERENCES local_ed (nome) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

SELECT evento.status FROM evento, edicoes WHERE evento.id = edicoes.idevento AND edicoes.id = 1;
SELECT * FROM evento;
UPDATE evento SET status = 0;
SELECT * FROM edicoes;

--------------------- PERIODO ----------------------------
-- // Periodo - (id,idEdicao,tipo,dias,dataInicio,dataTermino,horaInicio,horaTermino)
CREATE TABLE periodo(
  id SERIAL PRIMARY KEY,
  idEdicao INT UNIQUE, 
  tipo INT,
  dias VARCHAR(150),
  dataInicio date,
  dataTermino date,
  horaInicio VARCHAR(20),
  horaTermino VARCHAR(20),
  CONSTRAINT periodo_idEdicao_fkey FOREIGN KEY (idEdicao)
    REFERENCES edicoes (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE CASCADE
);

SELECT * FROM edicoes;
SELECT local_ed.id FROM edicoes,local_ed WHERE local_ed.nome = 'Casa';
--- INNER JOIN ---
SELECT local_ed.id FROM local_ed 
JOIN edicoes ON(local_ed.nome = edicoes.nomeLocal)
WHERE local_ed.nome = 'Casa';
--- INNER JOIN ---

Select id from local_ed where nome = 'Casa';

SELECT * FROM periodo;
SELECT * FROM local_ed;


------------------------------------------------------------------
SELECT * FROM inscricao ORDER BY idedicao;
SELECT * FROM edicoes;
SELECT * FROM evento;
SELECT data_nasc,nome,sexo,instituicao_origem, foto, uid, tipoUser FROM usuario;
-- Consulta estatistica de UM evento todas inscricoes;
SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = 13 ;
-- Consulta estatistica de UM evento por sexo;
SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND sexo = 'masculino' AND inscricao.idedicao = 13;
-- Consutla estatistica de UM evento por instituicao_origem;
SELECT COUNT(*) FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = 13 AND instituicao_origem = 'UEL';
-- exemplo com data ate 10 anos; COLOCAR COUNT(*)
SELECT * FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = 13 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 10;
-- exemplo com data 10 - 20 anos; COLOCAR COUNT(*)
SELECT * FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = 13 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) > 10 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 20;
-- exemplo com data 20 - 30 anos; COLOCAR COUNT(*)
SELECT * FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = 13 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) > 20 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 30;
-- exemplo com data maior q 30 anos; COLOCAR COUNT(*)
SELECT * FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND inscricao.idedicao = 13 AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) > 30 ;
-- exemplo com faixa etaria e sexo; COLOCAR COUNT(*) Fem - Idade ate 10;
SELECT * FROM inscricao, usuario WHERE inscricao.idusuario = usuario.uid AND (EXTRACT(YEAR from AGE(NOW(), usuario.data_nasc))) <= 10 AND sexo = 'feminino' AND inscricao.idedicao = 13;
