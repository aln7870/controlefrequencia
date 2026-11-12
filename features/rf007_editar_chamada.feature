# language: pt
@RF007
Funcionalidade: Editar chamada
  Como professor
  Eu quero corrigir uma chamada já registrada
  Para que a frequência dos alunos fique correta caso eu tenha marcado algo errado

  Contexto:
    Dado que estou logado no sistema
    E que a turma "6º Ano A" possui os alunos "Ana Souza" e "Bruno Lima"
    E que existe uma chamada em "05/11/2026" com "Ana Souza" ausente e "Bruno Lima" presente
    E que estou na página de edição da chamada de "05/11/2026" da turma "6º Ano A"

  @CT013 @positivo
  Cenário: Corrigir a situação de um aluno na chamada
    Dado que alterei o aluno "Ana Souza" para "Presente"
    Quando clico no botão "Salvar alterações"
    Então o sistema deve exibir a mensagem "Chamada atualizada com sucesso"
    E o aluno "Ana Souza" deve constar como "Presente" na chamada de "05/11/2026"

  @CT014 @negativo
  Cenário: Tentativa de salvar a chamada com aluno sem situação marcada
    Dado que removi a marcação do aluno "Bruno Lima"
    Quando clico no botão "Salvar alterações"
    Então o sistema deve exibir a mensagem de erro "Informe a presença de todos os alunos"
    E a chamada de "05/11/2026" deve permanecer sem alterações
