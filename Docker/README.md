## Criar o build da imagem
```bash
docker build -t <nome_da_sua_imagem> ./diretorio/do/seu/dockerfile
```
Comando usado no curso: `docker build -t run_robot ./Docker/docker_images`

## Consultar as imagens do seu Docker
```bash
docker images
```

## Remover uma imagem criada
```bash
docker rmi <nome_da_sua_imagem>
```

## Iniciar um container
```bash
docker run -itd --name <nome_do_container> -v <diretório_local>:<diretório_no_container> <imagem_utilizada>
```
* `-itd:` junção dos comandos `-it(--interactive)` `-d(--detach)`, esse comando leva o usuário direto para o container (`-it`) e desengata o usuário do container (`-d`), permitindo que o container rode mesmo sem uma aplicação executando
(fonte: [stackoverflow/what-is-docker-run-it-flag](https://stackoverflow.com/questions/48368411/what-is-docker-run-it-flag))
* `--name:` informa um nome para o container
* `-v:` cria espaço de armazenamento dentro do container, mas separado do sistema de arquivos do container (*[filesystem](https://medium.com/@BeNitinAgarwal/docker-containers-filesystem-demystified-b6ed8112a04a)*)
* `${pwd}:` diretório atual de trabalho

Comando usado no curso: `docker run -itd --name execucao_robot -v ${pwd}/Docker/tests:/opt/robotframework/tests -v ${pwd}/Docker/reports:/opt/robotframework/reports run_robot`

## Inspecionar container
```bash
docker inspect <nome_do_container>
```

## Executar comando no container
Este comando funciona apenas em um container em execução. Documentação para *[docker exec](https://docs.docker.com/engine/reference/commandline/exec/)*.
```bash
docker exec <opções> <nome_do_container> <comando>
```
`opções`: tags utilizadas para refinar o comando no docker. Na documentação existe a *[lista de opções](https://docs.docker.com/engine/reference/commandline/exec/#options)*.
Comando usado no curso: `docker exec -it execucao_robot python3 -m robot -d /opt/robotframework/reports /opt/robotframework/tests/test.robot`

## Parar o container
```bash
docker container stop <nome_do_container>
```

## Remover container
```bash
docker container rm <nome_do_container>
```

---
**Soluções para os erros encontrados no curso de robot:**
| | Erro | Solução encontrada |
|---|---|---|
| 1 | invalid reference | Resolvido informando o diretório do windows para os volumes utilizando a nomenclatura do linux, ou seja, utilizar `/` e não `\`. Por estar utilizando a nomenclatura linux para descrever o caminho do diretório, não há necessidade do uso de àspas. |
| 2 | unable to find image `<image>` locally | Removida a tag da versão da imagem (antes foi usado `<image>:latest`, agora apenas `<image>`). |
| 3 | "robot": executable file not found in $PATH: unknown | Adicionado o `python3 -m` para o container entender que se trata de uma linha de comando que utilizará `python3` e, através de `-m`, executará um módulo, no caso o robot.
---
