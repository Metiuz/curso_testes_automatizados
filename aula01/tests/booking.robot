*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    JSONLibrary
Suite Setup    Create Session    alias=${SESSION_NAME}    url=${BASE_URL}
Resource    ../resources/environment.resource
Resource    ../resources/keywords.resource

*** Test Cases ***

TC3: obter reservas
    #${response}    GET On Session    alias=iqs    url=/booking    expected_status=200
    ${response}    GET /booking    200
    Validate Json    ${response}    GetBooking.json

TC4: obter reserva por ID
    ${bookingid}    Select Random BookingId From Booking List
    ${response}    GET /booking/${bookingid}    200
    
    Validate Json    ${response}    GetBookingID.json

TC5: criar reserva
    ${response}    POST /booking    PostBooking.json    200
    Validate Json    ${response}    CreateBooking.json
    ${bookingid}    Set Variable    ${response.json()}[bookingid]
    ${booking}    Set Variable    ${response.json()}[booking]

    ${response}    GET /booking/${bookingid}    200
    Dictionaries Should Be Equal    ${booking}    ${response.json()}

TC6: substituir reserva
    ${bookingid}    Select Random BookingId From Booking List
    ${response}    PUT /booking/${bookingid}    PutBooking.json    200
    Validate Json    ${response}    UpdateBooking.json

    ${newResponse}    GET /booking/${bookingid}    200
    Dictionaries Should Be Equal    ${newResponse.json()}    ${response.json()}

TC7: editar reserva
    ${bookingid}    Select Random BookingId From Booking List
    ${response}    PATCH /booking/${bookingid}    PatchBooking.json    200
    Validate Json    ${response}    PartialUpdateBooking.json

    ${newResponse}    GET /booking/${bookingid}    200
    Dictionaries Should Be Equal    ${newResponse.json()}    ${response.json()}

TC8: deletar reserva
    ${bookingid}    Select Random BookingId From Booking List
    ${response}    DELETE /booking/${bookingid}    201

    GET /booking/${bookingid}    404

    ${response}    GET /booking    200
    Should Not Have Value In Json    ${response.json()}    json_path=$[?(@.bookingid == ${bookingid})].bookingid