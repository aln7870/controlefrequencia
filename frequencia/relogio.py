"""Data atual centralizada, para os testes poderem fixar o 'hoje'."""
import datetime

_fixa = None


def hoje():
    return _fixa or datetime.date.today()
