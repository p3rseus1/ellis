# Estágio 1: Base
# Usar uma imagem oficial do Python. A tag '-alpine' resulta em imagens menores.
# Usar uma tag específica como 3.12 em vez de 'latest' garante builds consistentes.
FROM python:3.12-alpine


# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Esta camada só será reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências do projeto
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta que o Gunicorn irá usar
EXPOSE 8000

# Comando para iniciar a aplicação usando Gunicorn (servidor WSGI de produção)
# Substitua 'app:app' por 'nome_do_arquivo:nome_da_instancia_flask' se for diferente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]