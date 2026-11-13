# Controle de Frequência Escolar

Django com RF001 a RF008 e regras RN001 a RN004. Os cenários Gherkin do professor estão em
`features/*.feature` (referência) e foram automatizados em Robot Framework + SeleniumLibrary.

## Rodar o sistema
```
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver        # http://127.0.0.1:8000/login/
```
Crie o usuário de uso próprio com `python manage.py createsuperuser` (o login é pelo e-mail).

## Rodar os testes (Selenium)
Com o servidor ligado em outro terminal:
```
robot frequencia/tests                                   # todos (CT001 a CT016), abre o Edge
robot --include CT009 frequencia/tests                   # um só
robot --variable BROWSER:chrome frequencia/tests         # outro navegador
robot --variable SPEED:0s frequencia/tests               # sem pausa entre os comandos
```
Os resultados ficam em `log.html` e `report.html`.

**Atenção:** antes de cada teste, `python manage.py preparar_testes <cenario>` APAGA todos os
alunos, turmas e chamadas do banco e recria o professor `carlos@escola.com` / `prof123`.
Rode os testes num banco de desenvolvimento (se quiser guardar dados, copie o `db.sqlite3` antes).

## Estrutura dos testes
- `frequencia/tests/CTxxx_*.robot`: um arquivo por caso de teste, escrito como o cenário Gherkin.
- `frequencia/tests/Keywords/*_Steps.robot`: os passos (Dado/Quando/Então).
- `frequencia/tests/Pages/*_Page.robot`: locators e variáveis.
- `frequencia/management/commands/preparar_testes.py`: monta os dados de cada cenário.
