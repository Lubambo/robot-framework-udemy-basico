*** Settings ***
Documentation  Gerenciador de execução dos testes.
Resource  ../Resources/Runners/Resource.robot

*** Variables ***
${tests_dir}  ./Tests

*** Test Cases ***
Executar Test Cases
    ${test_cases}  Reunir arquivos de teste  path=${tests_dir}
    #Log  Arquivos de teste:\n@{test_cases}