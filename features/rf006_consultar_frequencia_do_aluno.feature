# language: pt
@RF006
Funcionalidade: Consultar frequência do aluno
  Como professor
  Eu quero consultar a frequência de um aluno
  Para que eu saiba se ele está dentro do mínimo exigido

  Contexto:
    Dado que estou logado no sistema
    E que o aluno "Ana Souza", matrícula "2026001", possui 8 presenças e 2 faltas registradas
    E que estou na página "Consultar Frequência"

  @CT011 @positivo
  Cenário: Consultar frequência de um aluno existente
    Dado que preenchi o campo matrícula com "2026001"
    Quando clico no botão "Consultar"
    Então o sistema deve exibir o total de "10" aulas, "8" presenças e "2" faltas
    E deve exibir a frequência "80%"
    E deve exibir a situação "Regular"

  @CT012 @negativo
  Cenário: Consultar frequência com matrícula inexistente
    Dado que preenchi o campo matrícula com "9999999"
    Quando clico no botão "Consultar"
    Então o sistema deve exibir a mensagem de erro "Aluno não encontrado"
    E nenhum dado de frequência deve ser exibido
