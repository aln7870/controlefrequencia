"""Prepara o banco para os testes de interface (Robot Framework).

Uso: python manage.py preparar_testes <cenario>
Apaga alunos, turmas e chamadas, garante o professor de teste e monta o cenário pedido.
"""
import datetime

from django.contrib.auth.models import User
from django.core.management.base import BaseCommand, CommandError

from frequencia.models import Aluno, Chamada, Registro, Turma

PROFESSOR = {"email": "carlos@escola.com", "senha": "prof123", "nome": "Carlos Lima"}


def turma(nome="6º Ano A", *alunos):
    t = Turma.objects.create(nome=nome, ano_letivo=2026, turno="Manhã")
    t.alunos.add(*alunos)
    return t


def historico(t, aluno, presencas, total=10):
    """Cria `total` chamadas na turma (se faltarem) e marca `presencas` presenças para o aluno."""
    base = datetime.date(2026, 1, 1)
    while t.chamadas.count() < total:
        Chamada.objects.create(turma=t, data=base + datetime.timedelta(days=t.chamadas.count()))
    for i, c in enumerate(t.chamadas.order_by("data")[:total]):
        Registro.objects.create(chamada=c, aluno=aluno, presente=i < presencas)


def ana():
    return Aluno.objects.create(nome="Ana Souza", matricula="2026001")


def bruno():
    return Aluno.objects.create(nome="Bruno Lima", matricula="2026002")


def c_base(): pass
def c_aluno_ana(): ana()
def c_turma_com_ana(): turma("6º Ano A"); ana()
def c_turma_ana_vinculada(): turma("6º Ano A", ana())
def c_turma_ana_bruno(): turma("6º Ano A", ana(), bruno())
def c_frequencia_ana(): historico(turma("6º Ano A", a := ana()), a, 8)


def c_chamada_editar():
    a, b = ana(), bruno()
    t = turma("6º Ano A", a, b)
    c = Chamada.objects.create(turma=t, data=datetime.date(2026, 11, 5))
    Registro.objects.create(chamada=c, aluno=a, presente=False)
    Registro.objects.create(chamada=c, aluno=b, presente=True)


def c_excesso_de_faltas():
    a, b = ana(), bruno()
    t = turma("6º Ano A", a, b)
    historico(t, a, 9)
    historico(t, b, 6)
    turma("7º Ano B")


CENARIOS = {
    "base": c_base,                          # só o professor (CT001 a CT003, CT005, CT006)
    "aluno_ana": c_aluno_ana,                # CT004
    "turma_com_ana": c_turma_com_ana,        # CT007 e CT008 (a Ana ainda não está na turma)
    "turma_ana_vinculada": c_turma_ana_vinculada,  # CT008
    "turma_ana_bruno": c_turma_ana_bruno,    # CT009 e CT010
    "frequencia_ana": c_frequencia_ana,      # CT011 e CT012 (8 presenças e 2 faltas)
    "chamada_editar": c_chamada_editar,      # CT013 e CT014
    "excesso_de_faltas": c_excesso_de_faltas,  # CT015 e CT016
}


class Command(BaseCommand):
    help = __doc__

    def add_arguments(self, parser):
        parser.add_argument("cenario", choices=sorted(CENARIOS))

    def handle(self, *args, cenario, **opts):
        for modelo in (Registro, Chamada, Turma, Aluno):
            modelo.objects.all().delete()
        u, _ = User.objects.get_or_create(username=PROFESSOR["email"])
        u.email, u.first_name = PROFESSOR["email"], PROFESSOR["nome"]
        u.set_password(PROFESSOR["senha"])
        u.save()
        CENARIOS[cenario]()
        self.stdout.write(f"cenário '{cenario}' pronto")
