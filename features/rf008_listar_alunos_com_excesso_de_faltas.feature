# language: pt
@RF008
Funcionalidade: Listar alunos com excesso de faltas
  Como professor
  Eu quero ver quais alunos estão abaixo da frequência mínima
  Para que eu possa avisar a coordenação e os responsáveis a tempo

  Contexto:
    Dado que estou logado no sistema
    E que estou na página "Alunos com Excesso de Faltas"

  @CT015 @positivo
  Cenário: Listar alunos abaixo de 75% de frequência
    Dado que na turma "6º Ano A" o aluno "Ana Souza" tem 90% de frequência
    E o aluno "Bruno Lima" tem 60% de frequência
    E selecionei a turma "6º Ano A"
    Quando clico no botão "Gerar lista"
    Então o sistema deve exibir o aluno "Bruno Lima" com frequência "60%"
    E não deve exibir o aluno "Ana Souza"

  @CT016 @negativo
  Cenário: Tentativa de gerar a lista para turma sem chamadas registradas
    Dado que a turma "7º Ano B" não possui nenhuma chamada registrada
    E selecionei a turma "7º Ano B"
    Quando clico no botão "Gerar lista"
    Então o sistema deve exibir a mensagem "Nenhuma chamada registrada para esta turma"
    E nenhum aluno deve ser listado
