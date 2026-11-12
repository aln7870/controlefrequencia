# language: pt
@RF004
Funcionalidade: Vincular aluno à turma
  Como professor
  Eu quero adicionar alunos a uma turma
  Para que eles apareçam na lista de chamada dessa turma

  Contexto:
    Dado que estou logado no sistema
    E que existe o aluno "Ana Souza" com a matrícula "2026001"
    E que existe a turma "6º Ano A"
    E que estou na página da turma "6º Ano A"

  @CT007 @positivo
  Cenário: Adicionar aluno à turma com sucesso
    Dado que selecionei o aluno "Ana Souza"
    Quando clico no botão "Adicionar à turma"
    Então o sistema deve exibir a mensagem "Aluno adicionado à turma com sucesso"
    E o aluno "Ana Souza" deve aparecer na lista de alunos da turma "6º Ano A"

  @CT008 @negativo
  Cenário: Tentativa de adicionar um aluno que já está na turma
    Dado que o aluno "Ana Souza" já está na turma "6º Ano A"
    E selecionei o aluno "Ana Souza"
    Quando clico no botão "Adicionar à turma"
    Então o sistema deve exibir a mensagem de erro "O aluno já está nesta turma"
    E o aluno "Ana Souza" deve aparecer apenas uma vez na lista da turma
