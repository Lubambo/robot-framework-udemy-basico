*** Settings ***
Documentation  Gerenciador de execução dos testes.
Resource  ../Resources/Runners/Resource.robot

*** Variables ***
${tests_dir}  .\\Tests

*** Test Cases ***
Executar Test Cases
    ${test_cases}  Reunir arquivos de teste  path=${tests_dir}
    Log  Arquivos de teste:\n@{test_cases}

    @{test_paths}  Gerar caminho de arquivo  @{test_cases}  test_directory_path=${tests_dir}
    Log  Caminhos dos arquivos de teste:\n@{test_paths}
