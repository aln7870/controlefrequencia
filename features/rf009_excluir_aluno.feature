# language: pt
@RF009
Funcionalidade: Excluir aluno
  Como professor
  Eu quero excluir um aluno cadastrado por engano
  Para que a lista de alunos fique correta

  Contexto:
    Dado que estou logado no sistema
    E que estou na página "Lista de Alunos"

  @CT017 @positivo
  Cenário: Excluir aluno sem chamadas registradas
    Dado que existe o aluno "Ana Souza" sem chamadas registradas
    Quando clico no botão "Excluir" do aluno "Ana Souza"
    Então o sistema deve exibir a mensagem "Aluno excluído com sucesso"
    E o aluno "Ana Souza" não deve aparecer na lista de alunos

  @CT018 @negativo
  Cenário: Tentativa de excluir aluno com chamadas registradas
    Dado que o aluno "Ana Souza" possui chamadas registradas
    Quando clico no botão "Excluir" do aluno "Ana Souza"
    Então o sistema deve exibir a mensagem de erro "Não é possível excluir um aluno com chamadas registradas"
    E o aluno "Ana Souza" deve aparecer na lista de alunos
