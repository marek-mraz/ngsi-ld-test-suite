*** Settings ***
Documentation       Verify the 4.3.6.2 auxiliary consumption-only rule on provision.
...
...                 Clause 4.3.6.2: "Auxiliary distributed operations are limited to
...                 context information consumption operations (see clause 5.7)."
...
...                 Antares extension TP — the official aux TPs (D010_01_aux,
...                 D011_01_aux) prove the consumption side (supplementary merge,
...                 local wins). Nothing covers the provision side: a matching
...                 auxiliary registration must never receive a forwarded write,
...                 even when its operations list would allow one.

Resource            ${EXECDIR}/resources/ApiUtils/Common.resource
Resource            ${EXECDIR}/resources/ApiUtils/ContextInformationProvision.resource
Resource            ${EXECDIR}/resources/ApiUtils/ContextSourceRegistration.resource
Resource            ${EXECDIR}/resources/AssertionUtils.resource
Resource            ${EXECDIR}/resources/JsonUtils.resource
Resource            ${EXECDIR}/resources/MockServerUtils.resource

Test Setup          Setup Auxiliary Registration And Start Context Source Mock Server
Test Teardown       Delete Created Entity And Registration And Stop Context Source Mock Server


*** Variables ***
${entity_payload_filename}              vehicle-simple-attributes.jsonld
${fragment_filename}                    vehicle-speed-isParked-fragment.json
${registration_payload_file_path}       csourceRegistrations/context-source-registration-vehicle-redirection-ops.jsonld


*** Test Cases ***
436_02_01 Create Is Not Forwarded To An Auxiliary Registration
    [Documentation]    4.3.6.2: auxiliary distributed operations are limited to
    ...    consumption. The auxiliary registration declares redirectionOps (which
    ...    includes createEntity), yet a create must be serviced locally only and
    ...    never forwarded to the auxiliary Context Source.
    [Tags]    dist-ops    4_3_6_2    5_6_1    since_v1.9.1
    ${response}=    Create Entity    ${entity_payload_filename}    ${entity_id}
    Check Response Status Code    201    ${response.status_code}
    Wait For No Request

436_02_02 Append Is Not Forwarded To An Auxiliary Registration
    [Documentation]    4.3.6.2: auxiliary distributed operations are limited to
    ...    consumption. Appending attributes to a locally held entity succeeds
    ...    locally (204) and is never forwarded to the auxiliary Context Source.
    [Tags]    dist-ops    4_3_6_2    5_6_3    since_v1.9.1
    ${response}=    Create Entity    ${entity_payload_filename}    ${entity_id}
    Check Response Status Code    201    ${response.status_code}
    ${response}=    Append Entity Attributes
    ...    ${entity_id}
    ...    ${fragment_filename}
    ...    ${CONTENT_TYPE_JSON}
    ...    context=${ngsild_test_suite_context}
    Check Response Status Code    204    ${response.status_code}
    Wait For No Request


*** Keywords ***
Setup Auxiliary Registration And Start Context Source Mock Server
    ${entity_id}=    Generate Random Vehicle Entity Id
    Set Test Variable    ${entity_id}
    ${registration_id}=    Generate Random CSR Id
    Set Test Variable    ${registration_id}
    ${registration_payload}=    Prepare Context Source Registration From File
    ...    ${registration_id}
    ...    ${registration_payload_file_path}
    ...    entity_id=${entity_id}
    ...    mode=auxiliary
    ${response}=    Create Context Source Registration With Return    ${registration_payload}
    Check Response Status Code    201    ${response.status_code}
    Start Context Source Mock Server

Delete Created Entity And Registration And Stop Context Source Mock Server
    Delete Context Source Registration    ${registration_id}
    Delete Entity    ${entity_id}
    Stop Context Source Mock Server
