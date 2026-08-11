*** Settings ***
Documentation       Check the Geoquery Language grammar and semantics edge cases
...                 (CIM 009 clause 4.10) the official geoquery TPs skip.
...
...                 Normative sources: "PositiveNumber shall be a non-zero positive
...                 number ... excluding the 'minus' symbol and excluding the number 0";
...                 nearRel = nearOp andOp distance equal PositiveNumber (exactly one
...                 distance modifier is in the grammar); within semantics "as specified
...                 by [14]" (a polygon hole excludes contained points); geoproperty
...                 "to express the target geometry of an Entity ... location is the
...                 default"; "Entities which do not convey the target GeoProperty of
...                 the query shall be considered as non-matching."
...
...                 Antares extension TP — the official 019_10/019_11 cover only the
...                 seven relationships' happy paths on the default geoproperty.

Resource            ${EXECDIR}/resources/ApiUtils/Common.resource
Resource            ${EXECDIR}/resources/ApiUtils/ContextInformationConsumption.resource
Resource            ${EXECDIR}/resources/ApiUtils/ContextInformationProvision.resource
Resource            ${EXECDIR}/resources/AssertionUtils.resource
Resource            ${EXECDIR}/resources/JsonUtils.resource

Suite Setup         Setup Initial Entities
Suite Teardown      Delete Initial Entities
Test Template       Query Entities With Geoquery Expecting Count


*** Variables ***
${first_entity_filename}=       building-geo-hole-probe.jsonld
${second_entity_filename}=      building-geo-shell-probe.jsonld
${holed_polygon}=               [[[0,0],[10,0],[10,10],[0,10],[0,0]],[[4,4],[6,4],[6,6],[4,6],[4,4]]]


*** Test Cases ***    GEOREL    GEOMETRY    COORDINATES    EXPECTED_STATUS    EXPECTED_COUNT    GEOPROPERTY
019_30_01 Zero MaxDistance Is Rejected
    [Documentation]    4.10 PositiveNumber: "excluding the number 0" — a zero distance
    ...    violates the georel grammar and shall be rejected
    [Tags]    e-query    4_10    since_v1.9.1
    near;maxDistance==0    Point    [8,40]    400    ${None}

019_30_02 Negative MaxDistance Is Rejected
    [Documentation]    4.10 PositiveNumber: "excluding the 'minus' symbol" — a negative
    ...    distance violates the georel grammar and shall be rejected
    [Tags]    e-query    4_10    since_v1.9.1
    near;maxDistance==-100    Point    [8,40]    400    ${None}

019_30_03 Near With Two Distance Modifiers Is Rejected
    [Documentation]    4.10 nearRel = nearOp andOp distance equal PositiveNumber — the
    ...    grammar admits exactly one distance modifier
    [Tags]    e-query    4_10    since_v1.9.1
    near;maxDistance==5;minDistance==1    Point    [8,40]    400    ${None}

019_30_04 Near Without A Distance Modifier Is Rejected
    [Documentation]    4.10 nearRel: the distance modifier is not optional in the grammar
    [Tags]    e-query    4_10    since_v1.9.1
    near    Point    [8,40]    400    ${None}

019_30_05 Unknown Geo Relationship Is Rejected
    [Documentation]    4.10 georel admits exactly seven relationships; "touches" is not
    ...    one of them
    [Tags]    e-query    4_10    since_v1.9.1
    touches    Point    [8,40]    400    ${None}

019_30_06 Within A Polygon Hole Excludes The Contained Point
    [Documentation]    4.10 within "as specified by [14]": the hole ring is not part of
    ...    the polygon interior — the point at [5,5] (inside the hole) must NOT match,
    ...    the point at [2,2] (in the shell) must
    [Tags]    e-query    4_10    since_v1.9.1
    within    Polygon    ${holed_polygon}    200    1

019_30_07 Geoproperty Parameter Targets A Non-Default GeoProperty
    [Documentation]    4.10: geoproperty selects the target geometry; only the hole-probe
    ...    entity carries observationSpace near [8,40] — the entity without that
    ...    GeoProperty "shall be considered as non-matching"
    [Tags]    e-query    4_10    since_v1.9.1
    near;maxDistance==2000    Point    [8,40]    200    1    observationSpace

019_30_08 Default Geoproperty Is Location
    [Documentation]    4.10: "If no geoproperty is specified, the geoquery is applied to
    ...    the default Property location" — both locations are far from [8,40], so the
    ...    observationSpace match of 019_30_07 must NOT appear here
    [Tags]    e-query    4_10    since_v1.9.1
    near;maxDistance==2000    Point    [8,40]    200    0


*** Keywords ***
Query Entities With Geoquery Expecting Count
    [Arguments]    ${georel}    ${geometry}    ${coordinates}    ${expected_status_code}    ${expected_count}    ${geoproperty}=${EMPTY}
    ${response}=    Query Entities
    ...    entity_types=Building
    ...    georel=${georel}
    ...    geometry=${geometry}
    ...    coordinates=${coordinates}
    ...    geoproperty=${geoproperty}
    ...    count=true
    ...    context=${ngsild_test_suite_context}
    Check Response Status Code    ${expected_status_code}    ${response.status_code}
    IF    $expected_count is not None
        Check Response Headers Containing NGSILD-Results-Count Equals To
        ...    ${expected_count}
        ...    ${response.headers}
    END

Setup Initial Entities
    ${first_entity_id}=    Generate Random Building Entity Id
    Set Suite Variable    ${first_entity_id}
    ${create_response1}=    Create Entity Selecting Content Type
    ...    ${first_entity_filename}
    ...    ${first_entity_id}
    ...    ${CONTENT_TYPE_LD_JSON}
    Check Response Status Code    201    ${create_response1.status_code}
    ${second_entity_id}=    Generate Random Building Entity Id
    Set Suite Variable    ${second_entity_id}
    ${create_response2}=    Create Entity Selecting Content Type
    ...    ${second_entity_filename}
    ...    ${second_entity_id}
    ...    ${CONTENT_TYPE_LD_JSON}
    Check Response Status Code    201    ${create_response2.status_code}

Delete Initial Entities
    Delete Entity    ${first_entity_id}
    Delete Entity    ${second_entity_id}
