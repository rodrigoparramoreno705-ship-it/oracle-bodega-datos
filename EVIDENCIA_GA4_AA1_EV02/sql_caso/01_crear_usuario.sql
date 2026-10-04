-- Caso TECH TRANSITION: creacion del usuario (esquema) del departamento de facturacion
CREATE USER tech_transition IDENTIFIED BY "TechT2026"
  DEFAULT TABLESPACE users
  QUOTA 200M ON users;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO tech_transition;
