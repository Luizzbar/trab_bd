# 1. Imagem Base
FROM python:3.9-slim-buster
# 2. Variáveis de Ambiente
ENV PYTHONUNBUFFERED 1
# 3. Diretório de Trabalho
WORKDIR /app
# 4. Instalação de Dependências do Sistema
# Necessário para a biblioteca psycopg2 se comunicar com o PostgreSQL.
RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# 5. Instalação de Dependências Python (com otimização de cache)
# Copia APENAS o requirements.txt e instala as dependências.
# Esta camada será cacheada e reutilizada se o arquivo não mudar.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copia do Código da Aplicação
# Copia todo o conteúdo do diretório 'tp1/' (incluindo src/, sql/, etc.)
# para o diretório de trabalho /app dentro do contêiner.
COPY . .

# 7. Criação de Diretórios
# Garante que os diretórios para dados e saídas existam.
RUN mkdir -p /data /app/out

# 8. Comando Padrão
# Mantém o contêiner rodando caso seja iniciado com 'docker compose up -d'.
CMD ["tail", "-f", "/dev/null"]