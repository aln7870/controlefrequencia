from django.urls import path
from . import views

urlpatterns = [
    path("", views.inicio),
    path("login/", views.login_view, name="login"),
    path("sair/", views.sair, name="sair"),
    path("inicio/", views.inicio, name="inicio"),
    path("alunos/", views.lista_alunos, name="alunos"),
    path("alunos/novo/", views.cadastrar_aluno, name="aluno_novo"),
    path("turmas/", views.lista_turmas, name="turmas"),
    path("turmas/nova/", views.cadastrar_turma, name="turma_nova"),
    path("turmas/<int:turma_id>/", views.detalhe_turma, name="turma"),
    path("turmas/<int:turma_id>/chamada/", views.registrar_chamada, name="chamada"),
    path("turmas/<int:turma_id>/chamada/<str:data>/editar/", views.editar_chamada, name="chamada_editar"),
    path("frequencia/", views.consultar_frequencia, name="frequencia"),
    path("faltas/", views.excesso_de_faltas, name="faltas"),
]
