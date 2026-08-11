*** Settings ***
Documentation       Verify 5.6.11 Create or Update Temporal Evolution edges.
...
...                 5.6.11.4: an upsert onto an existing Temporal Evolution
...                 adds the instances and unions new Entity Type names; the
...                 4.5.7 deleted-instance representation (value =
...                 "urn:ngsi-ld:null") is legal temporal input (5.5.4 names
...                 "the temporal evolution" as an exception).
...
...                 Antares extension TP — official 016_x TPs cover neither.

Resource            ${EXECDIR}/resources/ApiUtils/Common.resource
Resource            ${EXECDIR}/resources/ApiUtils/ContextInformationProvision.resource
Resource            ${EXECDIR}/resources/AssertionUtils.resource
Resource            ${EXECDIR}/resources/JsonUtils.resource


*** Test Cases ***
5611_01_01 Upsert Unions Types And Accepts Deleted-Instance History
    [Documentation]    5.6.11.4: second upsert with a new type name and a
    ...    deletion-null instance → 204; retrieval shows both types and both
    ...    instances.
    [Tags]    te-create    5_6_11    since_v1.9.1
    ${entity_id}=    Generate Random Vehicle Entity Id
    &{headers}=    Create Dictionary    Content-Type=application/json
    ${first}=    Evaluate
    ...    {"id": $entity_id, "type": "Vehicle", "speed": [{"type": "Property", "value": 1, "observedAt": "2026-01-01T00:00:00Z"}]}
    ${response}=    POST
    ...    url=${temporal_api_url}/temporal/entities
    ...    json=${first}
    ...    headers=${headers}
    ...    expected_status=any
    Check Response Status Code    201    ${response.status_code}
    ${second}=    Evaluate
    ...    {"id": $entity_id, "type": ["Vehicle", "Truck"], "speed": [{"type": "Property", "value": "urn:ngsi-ld:null", "observedAt": "2026-01-02T00:00:00Z"}]}
    ${response}=    POST
    ...    url=${temporal_api_url}/temporal/entities
    ...    json=${second}
    ...    headers=${headers}
    ...    expected_status=any
    Check Response Status Code    204    ${response.status_code}
    ${response}=    GET
    ...    url=${temporal_api_url}/temporal/entities/${entity_id}?timerel=before&timeAt=2030-01-01T00:00:00Z
    ...    expected_status=any
    Check Response Status Code    200    ${response.status_code}
    Should Contain    ${response.text}    Truck
    Should Contain    ${response.text}    Vehicle
    ${speed}=    Evaluate    $response.json()['speed']
    ${count}=    Get Length    ${speed}
    Should Be Equal As Integers    ${count}    2
    [Teardown]    DELETE    url=${temporal_api_url}/temporal/entities/${entity_id}    expected_status=any
