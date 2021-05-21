*** Settings ***
Documentation  Gerenciador de execução dos testes.
Resource  ../Resources/Runners/Resource.robot

*** Variables ***
${tests_dir}  ./Tests

*** Test Cases ***
#Teste 1
#    Log  Caminho do diretório de testes:\n${tests_dir}
#    @{items}  Listar diretorio  path=${tests_dir}
#    Log  Itens do diretório de testes:\n@{items}

Teste 2
    #${test_cases}  Reunir diretorios  path=${tests_dir}
    #Log  Dicionário:\n${test_cases}
    ${test_cases}  Reunir arquivos de teste  path=${tests_dir}
    Log  Arquivos de teste:\n@{test_cases}