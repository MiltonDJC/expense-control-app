String getMoneyPocketName(String moneyPocketName) {
  return switch (moneyPocketName) {
    'bancoMacro' => 'Banco Macro',
    'bancoProvincia' => 'Banco Provincia',
    'bancoComafi' => 'Banco Comafi',
    'bancoNacion' => 'Banco Nación',
    'mercadoPago' => 'Mercado Pago',
    'cash' => 'Efectivo',
    _ => 'Banco no asignado',
  };
}
