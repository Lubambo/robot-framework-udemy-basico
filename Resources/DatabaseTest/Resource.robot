*** Settings ***
Library  DatabaseLibrary

*** Variables ***
## Informações do banco de dados PostgreSQL
${db_api_module}  psycopg2
${db_name}  robot
${db_username}  postgres
${db_password}  postgres
${db_host}  localhost
${db_port}  5432

*** Keywords ***
Conectar com Banco de Dados
    ## PostgreSQL
    Connect To Database  dbapiModuleName=${db_api_module}  dbName=${db_name}
    ...  dbUsername=${db_username}  dbPassword=${db_password}
    ...  dbHost=${db_host}  dbPort=${db_port}

Desconectar do Banco de Dados
    Disconnect From Database

Executar script SQL
    [Arguments]  ${file}
    Execute SQL Script  sqlScriptFileName=${file}

Verificar se existe registro na tabela
    [Arguments]  ${table}  ${column}  ${value}
    ${query}  Set Variable  SELECT ${column} FROM ${table} WHERE ${column} = '${value}'
    Check If Exists In Database  selectStatement=${query}

Executar SQL string
    [Arguments]  ${sql_string}
    Execute SQL String  sqlString=${sql_string}

Executar query
    [Arguments]  ${query}
    @{result}  Query  selectStatement=${query}
    [Return]  ${result}

Limpar tabela
    [Arguments]  ${table}
    ${count}  Row Count  selectStatement=SELECT * FROM ${table}
    Run Keyword If  ${count} > 0  Delete All Rows From Table  ${table}

Remover tabela
    [Arguments]  ${table}
    Executar SQL string  DROP TABLE ${table}