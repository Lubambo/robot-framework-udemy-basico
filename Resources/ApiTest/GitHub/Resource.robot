*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     String
Library     BuiltIn
Resource    ./Variables/Private.robot

*** Variables ***
${api}  https://api.github.com
${connection_alias}  myGitHubAuth
&{auth_header}  Authorization=Bearer ${TOKEN}

## Endpoints
${endp_user}    /user
${may_issues}   /repos/mayribeirofernandes/myudemyrobotframeworkcourse/issues

*** Keywords ***
Validate status code
    [Arguments]  ${status_code}  ${expected_status_code}
    Should Be Equal As Strings  ${status_code}  ${expected_status_code}

GET: user data
    ${response}  GET  headers=${auth_header}  url=${api}${endp_user}
    Log  Dados do usuário:\n${response.json()}
    Validate status code  ${response.status_code}  200

GET: issues -> state = "${state}"; label = "${label}"
    &{params}  Create Dictionary  state=${state}  label=${label}

    ${response}  GET  url=${api}${may_issues}  params=&{params}
    Log  May Issues:\n${response.json()}
    Validate status code  ${response.status_code}  200

POST: reaction "${reaction}" on an issue
    &{headers}  Create Dictionary  authorization=Bearer ${TOKEN}  accept=application/vnd.github.squirrel-girl-preview+json

    &{body}  Create Dictionary  content=${reaction}
    Log  Headers: &{headers}\nBody: &{body}
    
    ${response}  POST  url=${api}${ful_issues}/1/reactions  headers=&{headers}  json=&{body}
    Log  Response:\n${response.json()}
    Validate status code  ${response.status_code}  200

POST: create issue
    [Arguments]  ${title}  ${description}  @{labels}=${EMPTY}

    ${template}  Format String  ${CURDIR}/Templates/input/issue_template.json
    ...  user_git=${my_git_user}
    ...  title=${title}
    ...  description=${description}
    ...  labels=@{labels}
    ${body}  Evaluate  json.dumps(${template})  json
    Log  Body:\n${body}

    &{headers}  Create Dictionary  authorization=Bearer ${TOKEN}  accept=application/vnd.github.v3+json
    ${response}  POST  url=${api}${ful_issues}  headers=&{headers}  data=${body}
    Log  Response:\n${response.json()}
    Validate status code  ${response.status_code}  201