# Passo 01: Instancio uma imagem de SO linux, no caso usei o FEDORA,
# mas pode ser o Ubunto, Alpine, Debian, etc...
# Procure no Docker Hub a imagem que desejar! https://hub.docker.com
FROM fedora:29

# Passo 02: Vou mapear os volumes (diretórios do container) onde deixarei
# os testes (inputs) e os resultados (outputs).
VOLUME /opt/robotframework/reports
VOLUME /opt/robotframework/tests

# Passo 03: Vou rodar os comandos que instalam tudo que preciso para rodar o robot
# nesse container linux. Como estou usando o FEDORA, os comandos aqui executados
# devem ser compatíveis com ele!!
RUN dnf upgrade -y && dnf install -y python38

# É necessário atualizar o pip para evitar erro de instalação dos pacotes
# (https://stackoverflow.com/a/53929808)
RUN pip3 install --upgrade pip

# Passo 04: Instalo o Robot e as libraries que precisarei. É preciso copiar o arquivo
# requirements.txt para dentro da imagem. Poderia ter sido especificado uma pasta dentro
# da imagem, mas não foi o caso. Aqui está sendo copiado o arquivo requirements.txt para
# dentro do arquivo criado requirements.txt (não precisava ser o mesmo nome) dentro da imagem
COPY requirements.txt requirements.txt
RUN pip3 install --user -r requirements.txt
