*** Settings ***

Resource    ./environment.resource
Library    Collections
Library    RequestsLibrary
Library    JSONLibrary

*** Keywords ***
POST /${endpoint}
    [Arguments]    ${filename}    ${expected_status}
    ${payload}    Load Json From File    ${PAYLOAD_DIR}${/}${filename}
    ${response}    POST On Session    alias=${SESSION_NAME}    url=${endpoint}    json=${payload}    expected_status=${expected_status}
    RETURN    ${response}

GET /${endpoint}
    [Arguments]    ${expected_status}
    ${response}    GET On Session    alias=${SESSION_NAME}    url=${endpoint}    expected_status=${expected_status}
    RETURN    ${response}

GET /${endpoint}/${id}
    [Arguments]    ${expected_status}
    ${response}    GET On Session    alias=${SESSION_NAME}    url=${endpoint}/${id}    expected_status=${expected_status}
    RETURN    ${response}

PUT /${endpoint}/${id}
    [Arguments]    ${filename}    ${expected_status}
    ${token}    Get Token
    ${payload}    Load Json From File    ${PAYLOAD_DIR}${/}PutBooking.json
    ${headers}    Create Dictionary    Cookie=token\=${token}
    ${response}    PUT On Session    alias=${SESSION_NAME}    url=/booking/${id}    json=${payload}    headers=${headers}    expected_status=${expected_status}
    RETURN    ${response}

PATCH /${endpoint}/${id}
    [Arguments]    ${filename}    ${expected_status}
    ${token}    Get Token
    ${payload}    Load Json From File    ${PAYLOAD_DIR}${/}PatchBooking.json
    ${headers}    Create Dictionary    Cookie=token\=${token}
    ${response}    PATCH On Session    alias=${SESSION_NAME}    url=/booking/${id}    json=${payload}    headers=${headers}    expected_status=${expected_status}
    RETURN    ${response}

DELETE /${endpoint}/${id}
    [Arguments]    ${expected_status}
    ${token}    Get Token
    ${headers}    Create Dictionary    Cookie=token\=${token}
    ${response}    DELETE On Session    alias=${SESSION_NAME}    url=/booking/${id}    headers=${headers}    expected_status=${expected_status}
    RETURN    ${response}

Validate Json
    [Arguments]    ${response}    ${filename}
    Validate Json By Schema File    ${response.json()}    ${CONTRACTS_DIR}${/}${filename}

Select Random BookingId From Booking List
    ${response}    GET /booking    200
    ${bookingid}    Evaluate    random.choice($response.json())['bookingid']    modules=random
    RETURN    ${bookingid}

Get Token
    ${response}    POST /auth    PostAuthValid.json    200
    ${token}    Set Variable    ${response.json()}[token]
    RETURN    ${token}