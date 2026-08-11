*** Settings ***
Documentation       Check the OrderingParams data type (CIM 009 clause 5.2.43,
...                 Table 5.2.43-1) on POST /entityOperations/query: orderBy String[]
...                 orders the payload, coordinates (a JSON array, mandatory when
...                 orderBy uses order by distance) + geometry form the distance
...                 reference, and an explicit collation is refused while only
...                 codepoint order is offered.
...
...                 Antares extension TP — no official TP sends the ordering member.

Library             RequestsLibrary
Resource            ${EXECDIR}/resources/ApiUtils/Common.resource
Resource            ${EXECDIR}/resources/ApiUtils/ContextInformationConsumption.resource
Resource            ${EXECDIR}/resources/AssertionUtils.resource

Suite Setup         Setup Ordering Entities
Suite Teardown      Delete Ordering Entities


*** Variables ***
${near_vehicle}=    urn:ngsi-ld:Vehicle:52430-near
${far_vehicle}=     urn:ngsi-ld:Vehicle:52430-far


*** Test Cases ***
5243_01_01 Ordering By Distance Ascending Orders Nearest First
    [Documentation]    Table 5.2.43-1: orderBy dist-asc with coordinates as the reference
    [Tags]    e-query    5_2_43    since_v1.9.1
    ${body}=    Post Ordering Query Expecting    200
    ...    {"orderBy": ["location;dist-asc"], "coordinates": [8, 40], "geometry": "Point"}
    ${near}=    Evaluate    $body.find("52430-near")
    ${far}=    Evaluate    $body.find("52430-far")
    Should Be True    ${near} < ${far}    dist-asc must order near before far

5243_01_02 Distance Ordering Without Coordinates Is Rejected
    [Documentation]    Table 5.2.43-1: coordinates "shall be one if orderBy uses order
    ...    by distance"
    [Tags]    e-query    5_2_43    since_v1.9.1
    Post Ordering Query Expecting    400    {"orderBy": ["location;dist-asc"]}

5243_01_03 Non-Array Coordinates Are Rejected
    [Tags]    e-query    5_2_43    since_v1.9.1
    Post Ordering Query Expecting    400    {"orderBy": ["location;dist-asc"], "coordinates": "8,40"}

5243_01_04 A Non-String Geometry Is Rejected
    [Tags]    e-query    5_2_43    since_v1.9.1
    Post Ordering Query Expecting    400    {"orderBy": ["id;asc"], "geometry": 5}

5243_01_05 An Explicit Collation Is Refused Loudly
    [Documentation]    4.23.1: only codepoint order is offered — silent mis-ordering
    ...    would violate "shall be ordered according to the collation given"
    [Tags]    e-query    5_2_43    since_v1.9.1
    Post Ordering Query Expecting    400    {"orderBy": ["id;asc"], "collation": "de-u-co-phonebk"}


*** Keywords ***
Post Ordering Query Expecting
    [Arguments]    ${expected_status_code}    ${ordering_json}
    ${payload}=    Evaluate
    ...    {"type": "Query", "entities": [{"type": "Vehicle"}], "ordering": json.loads('''${ordering_json}''')}
    ...    modules=json
    ${response}=    POST
    ...    url=${url}/${ENTITY_OPERATIONS_QUERY_ENDPOINT_PATH}
    ...    json=${payload}
    ...    headers=${{ {"Content-Type": "application/json"} }}
    ...    expected_status=any
    Check Response Status Code    ${expected_status_code}    ${response.status_code}
    RETURN    ${response.text}

Setup Ordering Entities
    FOR    ${id}    ${lon}    ${lat}    IN
    ...    ${near_vehicle}    ${8.01}    ${40.01}
    ...    ${far_vehicle}    ${10.0}    ${45.0}
        ${payload}=    Evaluate
        ...    json.dumps({"id": $id, "type": "Vehicle", "location": {"type": "GeoProperty", "value": {"type": "Point", "coordinates": [$lon, $lat]}}})
        ...    modules=json
        ${response}=    POST
        ...    url=${url}/${ENTITIES_ENDPOINT_PATH}
        ...    data=${payload}
        ...    headers=${{ {"Content-Type": "application/json"} }}
        ...    expected_status=any
        Check Response Status Code    201    ${response.status_code}
    END

Delete Ordering Entities
    FOR    ${id}    IN    ${near_vehicle}    ${far_vehicle}
        ${response}=    DELETE
        ...    url=${url}/${ENTITIES_ENDPOINT_PATH}${id}
        ...    expected_status=any
    END
