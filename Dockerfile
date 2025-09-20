#Imagem Base
FROM python:3.9-slim-buster
#Variáveis de Ambiente
ENV PYTHONUNBUFFERED 1
#Diretório de Trabalho
WORKDIR /app
#Instalação de Dependências do Sistema, necessário para a biblioteca psycopg2 se comunicar com o PostgreSQL.
RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client \
    && rm -rf /var/lib/apt/lists/*

#Instalação de Dependências Python (com otimização de cache), Copia APENAS o requirements.txt e instala as dependências.
#Esta camada será cacheada e reutilizada se o arquivo não mudar.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

#Copia do Código da Aplicação
#Copia todo o conteúdo do diretório 'tp1/' (incluindo src/, sql/, etc.) para o diretório de trabalho /app dentro do contêiner.
COPY . .

#Criação de Diretórios, garante que os diretórios para dados e saídas existam.
RUN mkdir -p /data /app/out

#Comando Padrão, mantém o contêiner rodando caso seja iniciado com 'docker compose up -d'.
CMD ["tail", "-f", "/dev/null"]
