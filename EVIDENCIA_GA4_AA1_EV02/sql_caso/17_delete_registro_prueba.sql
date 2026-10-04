-- DELETE: se agrega una forma de pago de prueba y luego se elimina
INSERT INTO formas_pago (id_forma_pago, descripcion, dias_plazo)
  VALUES (7, 'Cheque (prueba)', 0);

DELETE FROM formas_pago
 WHERE id_forma_pago = 7;

COMMIT;
