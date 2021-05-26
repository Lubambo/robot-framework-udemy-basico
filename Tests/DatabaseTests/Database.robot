*** Settings ***
Documentation  Testes realizados em banco de dados. O banco utilizado foi o PostgreSQL

Resource  ../../Resources/DatabaseTest/Resource.robot
Test Setup  Conectar com Banco de Dados
Test Teardown  Desconectar do Banco de Dados

*** Variables ***
${sql_scripts_directory}  ${CURDIR}/SqlScripts/Tables/Account

*** Test Cases ***
Executando scripts SQL via arquivos
    Executar script SQL  ${sql_scripts_directory}/create_table.sql
    Executar script SQL  ${sql_scripts_directory}/insert_into.sql
    Verificar se existe registro na tabela  table=Account  column=username  value=May Fernandes

Executando scripts SQL via string
    ${query}  Set Variable
    ...  INSERT INTO public.Account(user_id, username, password, email) VALUES (3, 'Bil', 'robot456', 'robotizando3@robot.com')
    Executar SQL string  sql_string=${query}
    Verificar se existe registro na tabela  table=Account  column=username  value=Bil

Select Statement
    ${query}  Set Variable  SELECT * FROM Account
    ${result}  Executar query  query=${query}
    
    ${rows_count}  Get Length  ${result}
    
    IF  ${rows_count} > 0
        ${columns_count}  Get Length  ${result[0]}

        ## Para pegar um campo específico, utilize a tupla [índice_linha][índice_coluna]
        ${report}  Set Variable  ${EMPTY}

        FOR  ${row}  IN RANGE  ${rows_count}
            ${report}  Set Variable  ${report}\n[Usuário ${row}]\n

            FOR  ${column}  IN RANGE  ${columns_count}
                ${report}  Set Variable  ${report}${result[${row}][${column}]}\n
            END

        END

        Log  ${report}
    END

Limpar e remover tabela
    Limpar tabela  Account
    Remover tabela  Account
