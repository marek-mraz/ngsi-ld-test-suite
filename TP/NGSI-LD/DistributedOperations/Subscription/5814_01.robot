*** Settings ***
Documentation       Verify 5.8.1.4 / 5.8.5.4: the consumer half of
...                 distributed subscriptions. Creating an entity
...                 Subscription (localOnly != true) creates a Context
...                 Source Registration Subscription (5.11.2) and forwards a
...                 reduced copy of the Subscription to a matching
...                 registration supporting createSubscription — with the
...                 notification endpoint set to the local broker; deleting
...                 the Subscription forwards the delete (5.11.6).
...                 Antares extension TP — no official coverage of the
...                 consumer half.

Library             RequestsLibrary
Library             Collections
Resource            ${EXECDIR}/resources/ApiUtils/Common.resource
Resource            ${EXECDIR}/resources/ApiUtils/ContextSourceRegistration.resource
Resource            ${EXECDIR}/resources/AssertionUtils.resource
Resource            ${EXECDIR}/resources/MockServerUtils.resource

Test Setup          Setup Registration And Start Mock
Test Teardown       Clean Up


*** Variables ***
${sub_id}=      urn:ngsi-ld:Subscription:distsub5814


*** Test Cases ***
5814_01_01 Subscription Forwarded To Matching Context Source And Deleted
    [Documentation]    5.8.1.4: a reduced copy of the Subscription reaches
    ...    the registered Context Source with the local broker as its
    ...    notification endpoint (never the original subscriber's); an
    ...    internal Context Source Registration Subscription exists; the
    ...    delete is forwarded (5.8.5.4).
    [Tags]    dist-ops    5_8_1_4    5_8_5_4    since_v1.9.1

    &{headers}=    Create Dictionary    Content-Type=application/json
    ${sub}=    Set Variable
    ...    {"id": "${sub_id}", "type": "Subscription", "entities": [{"type": "Vehicle"}], "q": "speed>50", "notification": {"endpoint": {"uri": "http://original.subscriber.example:9998/notify"}}}
    ${response}=    POST    url=${url}/subscriptions    data=${sub}    headers=${headers}    expected_status=any
    Check Response Status Code    201    ${response.status_code}

    # the reduced copy arrives at the Context Source
    Wait For Request    ${15}
    ${method}=    Get Request Method
    ${path}=    Get Request Url
    ${body}=    Get Request Body
    Should Be Equal    ${method}    POST
    Should Contain    ${path}    /ngsi-ld/v1/subscriptions
    ${body}=    Evaluate    $body.decode('utf-8') if isinstance($body, bytes) else $body
    Should Contain    ${body}    remote-notify
    Should Not Contain    ${body}    original.subscriber.example
    Reply By    201

    # 5.8.1.4: the internal CSR subscription is visible (5.11.2)
    ${response}=    GET    url=${url}/csourceSubscriptions    expected_status=any
    Check Response Status Code    200    ${response.status_code}
    Should Not Be Empty    ${response.json()}

    # 5.8.5.4: the delete is forwarded with the mapped subscriptionId
    ${response}=    DELETE    url=${url}/subscriptions/${sub_id}    expected_status=any
    Check Response Status Code    204    ${response.status_code}
    Wait For Request    ${15}
    ${method}=    Get Request Method
    ${path}=    Get Request Url
    Should Be Equal    ${method}    DELETE
    Should Contain    ${path}    /ngsi-ld/v1/subscriptions/
    Reply By    204

    # and the internal CSR subscription is gone
    ${response}=    GET    url=${url}/csourceSubscriptions    expected_status=any
    Should Be Empty    ${response.json()}


*** Keywords ***
Setup Registration And Start Mock
    ${registration_id}=    Generate Random CSR Id
    Set Test Variable    ${registration_id}
    &{headers}=    Create Dictionary    Content-Type=application/json
    ${reg}=    Set Variable
    ...    {"id": "${registration_id}", "type": "ContextSourceRegistration", "information": [{"entities": [{"type": "Vehicle"}]}], "operations": ["federationOps"], "endpoint": "http://${context_source_host}:${context_source_port}"}
    ${response}=    POST    url=${url}/csourceRegistrations    data=${reg}    headers=${headers}    expected_status=any
    Check Response Status Code    201    ${response.status_code}
    Start Context Source Mock Server

Clean Up
    ${response}=    DELETE    url=${url}/subscriptions/${sub_id}    expected_status=any
    Delete Context Source Registration    ${registration_id}
    Stop Context Source Mock Server
