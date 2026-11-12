from django.db import models

FREQUENCIA_MINIMA = 75


class Aluno(models.Model):
    nome = models.CharField(max_length=150)
    matricula = models.CharField(max_length=30, unique=True)  # RN001

    class Meta:
        ordering = ["nome"]

    def __str__(self):
        return f"{self.nome} ({self.matricula})"


class Turma(models.Model):
    TURNOS = ["Manhã", "Tarde", "Noite"]
    nome = models.CharField(max_length=100)
    ano_letivo = models.PositiveIntegerField()
    turno = models.CharField(max_length=10)
    alunos = models.ManyToManyField(Aluno, related_name="turmas", blank=True)

    class Meta:
        ordering = ["nome"]

    def __str__(self):
        return self.nome


class Chamada(models.Model):
    turma = models.ForeignKey(Turma, on_delete=models.CASCADE, related_name="chamadas")
    data = models.DateField()

    class Meta:
        unique_together = ("turma", "data")  # RN002: uma chamada por turma/data


class Registro(models.Model):
    chamada = models.ForeignKey(Chamada, on_delete=models.CASCADE, related_name="registros")
    aluno = models.ForeignKey(Aluno, on_delete=models.CASCADE, related_name="registros")
    presente = models.BooleanField()

    class Meta:
        unique_together = ("chamada", "aluno")


def calcular_frequencia(aluno, turma=None):
    """RN003. Retorna dict com total, presencas, faltas, percentual e situacao."""
    qs = aluno.registros.all()
    if turma is not None:
        qs = qs.filter(chamada__turma=turma)
    total = qs.count()
    presencas = qs.filter(presente=True).count()
    if total == 0:
        return {"total": 0, "presencas": 0, "faltas": 0, "percentual": None,
                "situacao": "Sem aulas registradas"}
    pct = presencas / total * 100
    arredondado = round(pct, 1)  # 74,6% não pode aparecer como 75% e ficar "Em risco"
    if arredondado == int(arredondado):
        arredondado = int(arredondado)
    return {"total": total, "presencas": presencas, "faltas": total - presencas,
            "percentual": arredondado,
            "situacao": "Regular" if pct >= FREQUENCIA_MINIMA else "Em risco"}
