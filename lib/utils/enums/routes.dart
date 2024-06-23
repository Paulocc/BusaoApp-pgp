enum Routes {
  cadastroPassageiro('/cadastro_passageiro'),
  cadastroViagens('/cadastro_viagens'),
  listaViagens('/lista_viagens'),
  listaPassageirosViagem('/lista_passageiros_viagem'),
  listaPassageirosCadastrados('/lista_passageiros_cadastrados');

  final String value;

  const Routes(this.value);

  String get valor => value;
}