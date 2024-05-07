enum Routes {
  cadastroPassageiro('/cadastro_passageiro'),
  cadastroViagens('/cadastro_viagens'),
  listaViagens('/lista_viagens'),
  listaPassageiros('/lista_passageiros');

  final String value;

  const Routes(this.value);

  String get valor => value;
}