# language: pt
@RF010
Funcionalidade: Sair do sistema
  Como professor
  Eu quero encerrar a minha sessão
  Para que ninguém use o sistema com o meu acesso

  Contexto:
    Dado que estou logado no sistema

  @CT019 @positivo
  Cenário: Sair do sistema com sucesso
    Quando clico no link "Sair"
    Então o sistema deve exibir a mensagem "Você saiu do sistema"
    E deve exibir a tela de login

  @CT020 @negativo
  Cenário: Tentativa de acessar página restrita após sair
    Dado que realizei logout do sistema
    Quando tento acessar a página "Lista de Alunos" pela URL
    Então o sistema deve redirecionar para a tela de login
