*** Settings ***
Documentation  Recurso base para rodar os testes.
Library  OperatingSystem
Library  Process
Library  Collections
Library  String

*** Variables ***

*** Keywords ***
É um diretorio
    [Arguments]  ${item}=''

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
            #Set To Dictionary  ${test_dirs}  ${item}  ${EMPTY}
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
    [Arguments]  ${test_paths}  ${test_directory_path}

    ${test_cases}  Create List  @{EMPTY}

    IF  ${type} == 'dict'

        FOR  ${path}  IN  ${test_paths}

            ${type}  Evaluate  type(${file})

            IF  ${type} == 'dict'

                ${file_path}  ${test_directory_path}${/}${path}

            END
        
        END
    END

    [Return]  ${test_cases}
