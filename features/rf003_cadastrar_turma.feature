# language: pt
@RF003
Funcionalidade: Cadastrar turma
  Como professor
  Eu quero cadastrar as minhas turmas
  Para que eu possa organizar os alunos e fazer a chamada de cada uma

  Contexto:
    Dado que estou logado no sistema
    E que estou na página "Cadastro de Turma"

  @CT005 @positivo
  Cenário: Cadastro de turma com dados válidos
    Dado que preenchi o campo nome com "6º Ano A"
    E preenchi o campo ano letivo com "2026"
    E selecionei o turno "Manhã"
    Quando clico no botão "Salvar"
    Então o sistema deve exibir a mensagem "Turma cadastrada com sucesso"
    E a turma "6º Ano A" deve aparecer na lista de turmas

  @CT006 @negativo
  Cenário: Tentativa de cadastro de turma sem nome
    Dado que deixei o campo nome vazio
    E preenchi o campo ano letivo com "2026"
    E selecionei o turno "Manhã"
    Quando clico no botão "Salvar"
    Então o sistema deve exibir a mensagem de erro "O nome da turma é obrigatório"
    E nenhuma nova turma deve ser cadastrada
