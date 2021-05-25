*** Settings ***
Documentation  Gerenciador de execução dos testes.
Resource  ../Resources/Runners/Resource.robot

*** Variables ***
${tests_dir}  .\\Tests
${results_dir}  .\\Results

*** Test Cases ***
Executar todos os casos de teste
    # Para manter a divisão entre testes e runners, substituir True por False
    Executar suites de teste  ${tests_dir}  ${results_dir}  True
