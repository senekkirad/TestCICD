*** Settings ***
Library           Browser
Suite Setup       New Browser    ${BROWSER}    headless=${HEADLESS}
Test Setup        New Page    ${BASE_URL}
Suite Teardown    Close Browser    ALL
Test Tags         web    smoke

*** Test Cases ***
Ajouter Deux Tâches
    Ajouter Une Tâche    Préparer la recette
    Ajouter Une Tâche    Lancer la campagne
    Get Element Count    .todo-list li    ==    3

*** Keywords ***
Ajouter Une Tâche
    [Arguments]    ${texte}
    Fill Text     .new-todo    ${texte}
    Keyboard Key  press    Enter