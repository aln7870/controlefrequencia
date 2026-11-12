# language: pt
@RF002
Funcionalidade: Cadastrar aluno
  Como professor
  Eu quero cadastrar os alunos da escola
  Para que eles possam ser incluídos nas turmas e na chamada

  Contexto:
    Dado que estou logado no sistema
    E que estou na página "Cadastro de Aluno"

  @CT003 @positivo
  Cenário: Cadastro de aluno com dados válidos
    Dado que preenchi o campo nome com "Ana Souza"
    E preenchi o campo matrícula com "2026001"
    Quando clico no botão "Salvar"
    Então o sistema deve exibir a mensagem "Aluno cadastrado com sucesso"
    E o aluno "Ana Souza" deve aparecer na lista de alunos

  @CT004 @negativo
  Cenário: Tentativa de cadastro com matrícula já existente
    Dado que já existe o aluno "Ana Souza" com a matrícula "2026001"
    E preenchi o campo nome com "Bruno Lima"
    E preenchi o campo matrícula com "2026001"
    Quando clico no botão "Salvar"
    Então o sistema deve exibir a mensagem de erro "Já existe um aluno com esta matrícula"
    E o aluno "Bruno Lima" não deve aparecer na lista de alunos
