CREATE USER bd2016 PASSWORD 'senha';

CREATE DATABASE bd2016 OWNER bd2016;

CREATE TABLE usuario (
  uid SERIAL,
  login VARCHAR(15) NOT NULL,
  senha VARCHAR(250) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  CONSTRAINT pk_usuario PRIMARY KEY(uid),
  CONSTRAINT uk_usuario_login UNIQUE(login)
);

/*
 * Try with resource
 * https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html
 *
 * DAO Pattern
 * http://www.oracle.com/technetwork/java/dataaccessobject-138824.html
 *
 * Interface EntityManager
 * http://docs.oracle.com/javaee/7/api/javax/persistence/EntityManager.html#find-java.lang.Class-java.lang.Object-
 *
 */