String getBankName(String bankName) {
  return switch (bankName) {
    'bancoMacro' => 'Banco Macro',
    'bancoProvincia' => 'Banco Provincia',
    'bancoComafi' => 'Banco Comafi',
    'bancoNacion' => 'Banco Nación',
    _ => 'Banco no asignado',
  };
}
