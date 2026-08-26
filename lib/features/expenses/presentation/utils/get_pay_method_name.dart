String getPayMethodName(String payMethod) {
  return switch (payMethod) {
    'mercadoPago' => 'Mercado Pago',
    'creditCard' => 'Tarjeta de crédito',
    'debitCard' => 'Tarjeta de débito',
    'cash' => 'Efectivo',
    _ => 'Método de pago no asignado',
  };
}
