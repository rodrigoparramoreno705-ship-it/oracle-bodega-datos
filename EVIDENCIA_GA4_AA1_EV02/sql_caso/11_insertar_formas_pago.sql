-- Insercion de registros en FORMAS_PAGO (datos ficticios con fines academicos)
INSERT INTO formas_pago (id_forma_pago, descripcion, dias_plazo)
  VALUES (1, 'Efectivo', 0);

INSERT INTO formas_pago (id_forma_pago, descripcion, dias_plazo)
  VALUES (2, 'Tarjeta débito', 0);

INSERT INTO formas_pago (id_forma_pago, descripcion, dias_plazo)
  VALUES (3, 'Tarjeta crédito', 0);

INSERT INTO formas_pago (id_forma_pago, descripcion, dias_plazo)
  VALUES (4, 'Transferencia bancaria', 0);

INSERT INTO formas_pago (id_forma_pago, descripcion, dias_plazo)
  VALUES (5, 'Crédito 30 días', 30);

INSERT INTO formas_pago (id_forma_pago, descripcion, dias_plazo)
  VALUES (6, 'Crédito 60 días', 60);

COMMIT;
