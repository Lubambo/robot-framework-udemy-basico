*** Settings ***
Resource  BaseResource.robot

*** Variables ***
### POST
${ENDPOINT_POST_BOOKS}  Books

*** Keywords ***
Adicionar livro
    [Arguments]  &{BOOK_DATA}

    ${REPONSE}  Realizar Request  ${POST_METHOD}  ${ENDPOINT_POST_BOOKS}  JSON=&{BOOK_DATA}
    Conferir Response  ${REPONSE}  200  Ok
    &{RESULT}  Convert To Dictionary  ${REPONSE.json()}
    Dictionaries Should Be Equal  dict1=&{BOOK_DATA}  dict2=${REPONSE.json()}