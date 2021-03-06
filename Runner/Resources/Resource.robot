*** Settings ***
Documentation  Recurso base para rodar os testes.
Library  OperatingSystem
Library  Process
Library  Collections
Library  String

*** Variables ***

*** Keywords ***
Verifica tipo da variável
    [Arguments]  ${item}

    # Verifica se é possível avaliar o tipo do item.
    # Isso foi necessário pois o Robot FW acusa erro arquivo não importado como módulo,
    # quando o item avaliado possui a string com extensão de arquivo (no caso, *.robot).
    ${type_status}  Run Keyword And Return Status  Evaluate  type(${item}).__name__
    LOG  Evaluation status: ${type_status}

    # Caso o seja possível avaliar, é verificado o tipo do item.
    # Se não, é forçada a avaliação do item como sendo uma string (str)
    IF  ${type_status}
        ${type}  Evaluate  type(${item}).__name__
    ELSE
        ${type}  Set Variable  str
    END

    [Return]  ${type}

É um diretorio
    [Arguments]  ${item}

    # Verifica exentsão de arquivo robot
    ${name}  Fetch From Left  string=${item}  marker=.robot
    Log  Verificação: [Item -> ${item}] [Fetch Result -> ${name}]

    ${is_equal}  Evaluate  "${name}" == "${item}"

    [Return]  ${is_equal}

Reunir diretorios
    [Arguments]  ${path}
    
    ${test_dirs}  Create List  @{EMPTY}

    @{items}  List Directory  path=${path}

    FOR  ${item}  IN  @{items}
        ${is_dir}  É um diretorio  ${item}

        IF  ${is_dir}
            Append To List  ${test_dirs}  ${item}
        END
    END

    Log  Dicionário:\n${test_dirs}

    [Return]  ${test_dirs}

Reunir arquivos de teste
    [Arguments]  ${path}

    ${test_cases}  Create List  @{EMPTY}
    #Log  Lista de casos de teste:\n${test_cases}
    ${test_dirs}  Reunir diretorios  path=${path}
    #LOG  Diretórios:\n${test_dirs}
    @{files}  List Files In Directory  path=${path}  pattern=*.robot
    #LOG  Arquivos Robot:\n@{files}

    IF  ${test_dirs}

        # Listar diretorios do diretorio principal de testes
        FOR  ${directory}  IN  @{test_dirs}

            # Reunir os arquivos do sub-diretorio
            ${sub_dir}  Reunir arquivos de teste  path=${path}${/}${directory}
            ${dir_elements}  Create Dictionary  ${directory}  ${sub_dir}
            Append To List  ${test_cases}  ${dir_elements}
        
        END

    END

    IF  @{files}

        FOR  ${file}  IN  @{files}
            
            Append To List  ${test_cases}  ${file}
        END

    END

    [Return]  ${test_cases}

Gerar caminho de arquivo
    [Arguments]  @{test_cases}  ${test_directory_path}

    ${test_paths}  Create List  @{EMPTY}

    FOR  ${test_case_item}  IN  @{test_cases}

        ${type}  Verifica tipo da variável  ${test_case_item}

        IF  "${type}" == "list"

            FOR  ${item}  IN  @{test_case_item}

                ${test_files}  Gerar caminho de arquivo  ${item}  test_directory_path=${test_directory_path}
                FOR  ${test_file}  IN  @{test_files}

                    Append To List  ${test_paths}  ${test_file}
                
                END

            END

        ELSE IF  "${type}" == "dict"

            FOR  ${key}  IN  @{test_case_item.keys()}

                ${path}  Gerar caminho de arquivo  ${test_case_item["${key}"]}  test_directory_path=${test_directory_path}${/}${key}
                
                FOR  ${item}  IN  @{path}
                    Append To List  ${test_paths}  ${item}
                END

            END
            
        ELSE

            Append To List  ${test_paths}  ${test_directory_path}${/}${test_case_item}
        
        END

    END

    [Return]  ${test_paths}

Relacionar arquivos de teste aos diretórios de resultado
    [Arguments]  @{test_files_path}  ${tests_directory}  ${results_directory}  ${ignore_main_test_folder}=${FALSE}

    ${results_directories}  Create List  @{EMPTY}

    FOR  ${path}  IN  @{test_files_path}
        ${result_path}  Fetch From Left  string=${path}  marker=.robot
        
        IF  ${ignore_main_test_folder}
            ${main_test_folder}  Fetch From Left  string=${tests_directory}  marker=[a-z0-9]\\
            ${result_path}  Fetch From Right  string=${result_path}  marker=${main_test_folder}
        END

        ${result_path}  Catenate  SEPARATOR=  ${results_directory}  ${result_path}
        
        ${pair}  Create List  ${result_path}  ${path}
        Append To List  ${results_directories}  ${pair}
    END

    [Return]  ${results_directories}

Executar arquivos de teste
    [Arguments]  @{tests_and_results_path}

    FOR  ${pair}  IN  @{tests_and_results_path}
        ${result_directory}  Get From List  ${pair}  0
        ${test_file}  Get From List  ${pair}  1
        
        ${exec_comand}  Catenate  robot  -d  ${result_directory}  ${test_file}
        
        ${process_result}  Run Process  ${exec_comand}  cwd=${EXECDIR}  shell=True
        Log  ${process_result.stdout}
    END

Executar suites de teste
    [Arguments]  ${tests_dir}  ${results_dir}  ${ignore_main_test_folder}=${FALSE}
    @{test_cases}  Reunir arquivos de teste  path=${tests_dir}
    #Log  Arquivos de teste:\n@{test_cases}

    @{test_paths}  Gerar caminho de arquivo  @{test_cases}  test_directory_path=${tests_dir}
    #Log  Caminhos dos arquivos de teste:\n@{test_paths}

    @{results_directories}  Relacionar arquivos de teste aos diretórios de resultado
    ...  @{test_paths}  tests_directory=${tests_dir}  results_directory=${results_dir}
    ...  ignore_main_test_folder=${ignore_main_test_folder}
    #Log  Caminhos dos diretórios de resultado:\n@{results_directories}

    Executar arquivos de teste  @{results_directories}
