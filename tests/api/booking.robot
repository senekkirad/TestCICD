*** Settings ***
Library        RequestsLibrary
Suite Setup    Create Session    booker    ${API_URL}
Test Tags      api    smoke

*** Test Cases ***
Cycle De Vie D Une Réservation
    VAR    &{dates}    checkin=2026-12-01    checkout=2026-12-05
    VAR    &{body}     firstname=Seneque    lastname=Test    totalprice=${150}
    ...    depositpaid=${True}    bookingdates=${dates}
    ${resp}=    POST On Session    booker    /booking    json=${body}    expected_status=200
    ${id}=      Set Variable    ${resp.json()}[bookingid]

    ${resp}=    GET On Session    booker    /booking/${id}    expected_status=200
    Should Be Equal    ${resp.json()}[firstname]    Seneque

    ${token}=    Obtenir Token
    VAR    &{headers}    Cookie=token=${token}
    DELETE On Session    booker    /booking/${id}    headers=${headers}    expected_status=201

*** Keywords ***
Obtenir Token
    VAR    &{creds}    username=admin    password=%{API_PASSWORD=password123}
    ${resp}=    POST On Session    booker    /auth    json=${creds}    expected_status=200
    RETURN    ${resp.json()}[token]