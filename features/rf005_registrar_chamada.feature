# language: pt
@RF005
Funcionalidade: Registrar chamada
  Como professor
  Eu quero marcar a presença ou a falta de cada aluno
  Para que a frequência da turma fique registrada

  Contexto:
    Dado que estou logado no sistema
    E que hoje é "10/11/2026"
    E que a turma "6º Ano A" possui os alunos "Ana Souza" e "Bruno Lima"
    E que estou na página de chamada da turma "6º Ano A"

  @CT009 @positivo
  Cenário: Registrar a chamada do dia com sucesso
    Dado que informei a data "10/11/2026"
    E marquei o aluno "Ana Souza" como "Presente"
    E marquei o aluno "Bruno Lima" como "Ausente"
    Quando clico no botão "Salvar chamada"
    Então o sistema deve exibir a mensagem "Chamada registrada com sucesso"
    E o aluno "Bruno Lima" deve ter 1 falta registrada na turma "6º Ano A"

  @CT010 @negativo
  Cenário: Tentativa de registrar chamada em data futura
    Dado que informei a data "15/11/2026"
    E marquei o aluno "Ana Souza" como "Presente"
    E marquei o aluno "Bruno Lima" como "Presente"
    Quando clico no botão "Salvar chamada"
    Então o sistema deve exibir a mensagem de erro "Não é permitido registrar chamada em data futura"
    E nenhuma chamada deve ser registrada para a turma "6º Ano A"
