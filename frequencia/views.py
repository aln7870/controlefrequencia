import datetime
from functools import wraps

from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.shortcuts import get_object_or_404, redirect, render

from . import relogio
from .models import FREQUENCIA_MINIMA, Aluno, Chamada, Registro, Turma, calcular_frequencia


def login_obrigatorio(view):
    """RN004: somente usuários autenticados acessam o sistema."""
    @wraps(view)
    def envelope(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect("login")
        return view(request, *args, **kwargs)
    return envelope


# RF001 ---------------------------------------------------------------
def login_view(request):
    if request.method == "POST":
        email = request.POST.get("email", "").strip()
        senha = request.POST.get("senha", "")
        usuario = User.objects.filter(email__iexact=email).first()
        auth = authenticate(request, username=usuario.username, password=senha) if usuario else None
        if auth is None:
            messages.error(request, "E-mail ou senha inválidos")
            return render(request, "frequencia/login.html")
        login(request, auth)
        messages.success(request, f"Olá, {auth.first_name or auth.email}!")
        return redirect("inicio")
    return render(request, "frequencia/login.html")


def sair(request):
    logout(request)
    return redirect("login")


@login_obrigatorio
def inicio(request):
    return render(request, "frequencia/inicio.html")


# RF002 ---------------------------------------------------------------
@login_obrigatorio
def lista_alunos(request):
    return render(request, "frequencia/alunos.html", {"alunos": Aluno.objects.all()})


@login_obrigatorio
def cadastrar_aluno(request):
    if request.method == "POST":
        nome = request.POST.get("nome", "").strip()
        matricula = request.POST.get("matricula", "").strip()
        if not nome or not matricula:
            messages.error(request, "Informe o nome e a matrícula do aluno")
        elif Aluno.objects.filter(matricula=matricula).exists():
            messages.error(request, "Já existe um aluno com esta matrícula")
        else:
            Aluno.objects.create(nome=nome, matricula=matricula)
            messages.success(request, "Aluno cadastrado com sucesso")
            return redirect("alunos")
        return redirect("aluno_novo")
    return render(request, "frequencia/aluno_form.html")


# RF003 ---------------------------------------------------------------
@login_obrigatorio
def lista_turmas(request):
    return render(request, "frequencia/turmas.html", {"turmas": Turma.objects.all()})


@login_obrigatorio
def cadastrar_turma(request):
    if request.method == "POST":
        nome = request.POST.get("nome", "").strip()
        ano = request.POST.get("ano_letivo", "").strip()
        turno = request.POST.get("turno", "").strip()
        if not nome:
            messages.error(request, "O nome da turma é obrigatório")
        elif not ano.isdigit() or turno not in Turma.TURNOS:
            messages.error(request, "Informe o ano letivo e o turno da turma")
        else:
            Turma.objects.create(nome=nome, ano_letivo=int(ano), turno=turno)
            messages.success(request, "Turma cadastrada com sucesso")
            return redirect("turmas")
        return redirect("turma_nova")
    return render(request, "frequencia/turma_form.html", {"turnos": Turma.TURNOS})


# RF004 ---------------------------------------------------------------
@login_obrigatorio
def detalhe_turma(request, turma_id):
    turma = get_object_or_404(Turma, pk=turma_id)
    if request.method == "POST":
        aluno = Aluno.objects.filter(pk=request.POST.get("aluno") or 0).first()
        if aluno is None:
            messages.error(request, "Selecione um aluno")
        elif turma.alunos.filter(pk=aluno.pk).exists():
            messages.error(request, "O aluno já está nesta turma")
        else:
            turma.alunos.add(aluno)
            messages.success(request, "Aluno adicionado à turma com sucesso")
        return redirect("turma", turma_id=turma.pk)
    disponiveis = Aluno.objects.all()  # a validação de duplicidade é feita ao salvar
    return render(request, "frequencia/turma.html",
                  {"turma": turma, "alunos": turma.alunos.all(), "disponiveis": disponiveis})


# RF005 ---------------------------------------------------------------
def _ler_data(texto):
    try:
        return datetime.datetime.strptime(texto.strip(), "%d/%m/%Y").date()
    except ValueError:
        return None


def _ler_presencas(request, turma):
    """Retorna {aluno: bool} ou None se algum aluno ficou sem marcação."""
    marcas = {}
    for aluno in turma.alunos.all():
        valor = request.POST.get(f"presenca_{aluno.pk}")
        if valor not in ("P", "A"):
            return None
        marcas[aluno] = valor == "P"
    return marcas


@login_obrigatorio
def registrar_chamada(request, turma_id):
    turma = get_object_or_404(Turma, pk=turma_id)
    if request.method == "POST":
        data = _ler_data(request.POST.get("data", ""))
        if data is None:
            messages.error(request, "Informe uma data válida (dd/mm/aaaa)")
        elif data > relogio.hoje():
            messages.error(request, "Não é permitido registrar chamada em data futura")
        elif Chamada.objects.filter(turma=turma, data=data).exists():
            messages.error(request, "Já existe uma chamada desta turma nesta data. Use a edição de chamada")
        else:
            marcas = _ler_presencas(request, turma)
            if marcas is None:
                messages.error(request, "Informe a presença de todos os alunos")
            else:
                chamada = Chamada.objects.create(turma=turma, data=data)
                Registro.objects.bulk_create(
                    Registro(chamada=chamada, aluno=a, presente=p) for a, p in marcas.items())
                messages.success(request, "Chamada registrada com sucesso")
                return redirect("turma", turma_id=turma.pk)
        return redirect("chamada", turma_id=turma.pk)
    return render(request, "frequencia/chamada.html", {
        "turma": turma, "alunos": turma.alunos.all(),
        "hoje": relogio.hoje().strftime("%d/%m/%Y"),
        "chamadas": turma.chamadas.order_by("-data")})


# RF007 ---------------------------------------------------------------
@login_obrigatorio
def editar_chamada(request, turma_id, data):
    turma = get_object_or_404(Turma, pk=turma_id)
    try:
        dia = datetime.date.fromisoformat(data)
    except ValueError:
        dia = None
    chamada = get_object_or_404(Chamada, turma=turma, data=dia)
    if request.method == "POST":
        marcas = _ler_presencas(request, turma)
        if marcas is None:
            messages.error(request, "Informe a presença de todos os alunos")
        else:
            for aluno, presente in marcas.items():
                Registro.objects.update_or_create(
                    chamada=chamada, aluno=aluno, defaults={"presente": presente})
            messages.success(request, "Chamada atualizada com sucesso")
            return redirect("turma", turma_id=turma.pk)
        return redirect("chamada_editar", turma_id=turma.pk, data=data)
    atuais = {r.aluno_id: r.presente for r in chamada.registros.all()}
    linhas = [(a, atuais.get(a.pk)) for a in turma.alunos.all()]
    return render(request, "frequencia/chamada_editar.html",
                  {"turma": turma, "chamada": chamada, "linhas": linhas})


# RF006 ---------------------------------------------------------------
@login_obrigatorio
def consultar_frequencia(request):
    contexto = {}
    if request.method == "POST":
        aluno = Aluno.objects.filter(matricula=request.POST.get("matricula", "").strip()).first()
        if aluno is None:
            messages.error(request, "Aluno não encontrado")
        else:
            contexto = {"aluno": aluno, "freq": calcular_frequencia(aluno)}
    return render(request, "frequencia/frequencia.html", contexto)


# RF008 ---------------------------------------------------------------
@login_obrigatorio
def excesso_de_faltas(request):
    contexto = {"turmas": Turma.objects.all(), "minimo": FREQUENCIA_MINIMA}
    if request.method == "POST":
        turma = Turma.objects.filter(pk=request.POST.get("turma") or 0).first()
        if turma is None:
            messages.error(request, "Selecione uma turma")
        elif not turma.chamadas.exists():
            messages.error(request, "Nenhuma chamada registrada para esta turma")
        else:
            lista = []
            for aluno in turma.alunos.all():
                f = calcular_frequencia(aluno, turma)
                if f["percentual"] is not None and f["situacao"] == "Em risco":
                    lista.append((aluno, f["percentual"]))
            contexto.update(turma=turma, lista=lista, gerou=True)
    return render(request, "frequencia/faltas.html", contexto)
