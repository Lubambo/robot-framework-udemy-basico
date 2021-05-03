*** Settings ***
Resource  BaseResource.robot

*** Variables ***
### GET
${ENDPOINT_GET_BOOKS}  Books

*** Keywords ***
Requisitar livro: ${ID}
    IF  ${ID} == ${ALL}
        ${ENDPOINT}  Set Variable  ${ENDPOINT_GET_BOOKS}
    ELSE
        ${ENDPOINT}  Set Variable  ${ENDPOINT_GET_BOOKS}/${ID}
    END

    ${RESPONSE}  Realizar Request  ${GET_METHOD}  ${ENDPOINT}
    Conferir Response  ${RESPONSE}

    IF  ${ID} == ${ALL}
        Length Should Be  ${RESPONSE.json()}  200
    END
    
    Log  ${RESPONSE.text}