*** Variables ***
${URL}         http://127.0.0.1:8000
${BROWSER}     edge
${SPEED}       0.5s
${DRIVER}      ${None}
${OPTIONS}     ${None}
# por padrão usa o mesmo Python que está rodando o Robot (o do venv); troque com --variable PYTHON:caminho
${PYTHON}      ${{sys.executable}}

&{PAGINAS}     Cadastro de Aluno=/alunos/novo/
...            Cadastro de Turma=/turmas/nova/
...            Consultar Frequência=/frequencia/
...            Alunos com Excesso de Faltas=/faltas/

# nome do campo do feature -> atributo name do input
&{CAMPOS}      e-mail=email    senha=senha    nome=nome    matrícula=matricula
...            ano letivo=ano_letivo    data=data

&{MATRICULAS}  Ana Souza=2026001    Bruno Lima=2026002
