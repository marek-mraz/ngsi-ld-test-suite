# ETSI NGSI-LD — Failing tests report

## ❌ Errors: 97   (✅ passing: 789)

| Suite | Pass | **Fail** |
|---|---|---|
| 047 | 7 | **13** |
| CommonBehaviours | 33 | **0** |
| Consumption-Discovery | 14 | **0** |
| Consumption-Entity | 190 | **0** |
| Consumption-TemporalEntity | 123 | **1** |
| ContextSource | 87 | **27** |
| Provision-BatchEntities | 58 | **0** |
| Provision-Entities | 55 | **0** |
| Provision-EntityAttributes | 88 | **0** |
| Provision-TemporalEntity | 11 | **0** |
| Provision-TemporalEntityAttributes | 32 | **1** |
| Subscription | 91 | **31** |
| iop | 0 | **24** |
| **TOTAL** | **789** | **97** |

### Suites left out (no results)

- **DistributedOperations** — not run
- **jsonldContext** — left out — hangs ~30 min on an unreachable external @context server (053_05_01)

Below: only FAILED tests. Each entry has the requirement (spec clauses), what is wrong (expected vs actual), and the HTTP request/response under test.


## 047  (13 failing)

### 047_01_01 Receive cSourceNotification Periodically And Initially On Subscription
- **Requirement (doc):** Check that if the created context source registration subscription defines a timeInterval member, a cSourceNotification will be sent periodically, initially on subscription and when the time interval is reached
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- **Request under test:**

```json
{
    "method": "POST",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Type": "application/ld+json",
        "Content-Length": "395"
    },
    "body": {
        "id": "urn:ngsi-ld:Subscription:1425163346816215",
        "type": "Subscription",
        "timeInterval": 10,
        "entities": [
            {
                "type": "Building"
            }
        ],
        "notification": {
            "format": "keyValues",
            "endpoint": {
                "uri": "http://0.0.0.0:8085/notify",
                "accept": "application/json"
            }
        },
        "@context": [
            "https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld"
        ]
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions",
    "headers": {
        "Location": "/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:1425163346816215",
        "content-length": "0"
    },
    "status_code": 201,
    "reason": "Created",
    "body": null
}
```

### 047_02_01 Receive cSourceNotification Initially On Subscription And Whenever There Is A Change Of A Matching Context Source Registration
- **Requirement (doc):** Check that if the created context source registration subscription does not define a timeInterval member, a cSourceNotification, with the appropriate trigger reason in the "triggerReason" member, will be sent initially on subscription and whenever there is a change of a matching Context Source Registration
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Setup failed:
Timeout: request was not received.
  ```
- **Expected body (reference):**

```json
['urn:ngsi-ld:ContextSourceRegistration:2193535310947609']
```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5908739599835329",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5908739599835329",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_03_01 Receive cSourceNotification With Relevant Information
- **Requirement (doc):** Check that instead of providing the original context source registration, implementations should return context source registration information relevant for the subscription, in particular only matching RegistrationInfo elements
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Dictionary '${registration_information}[entities]' has no key '0'.
  ```
- **Expected body (reference):**

```json
1
```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5125551146678950",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5125551146678950",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_04_01 Receive cSourceNotification With Compliant Structure
- **Requirement (doc):** The structure of the csource notification message shall be as mandated by clause 5.3.2
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:2585160822698673",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:2585160822698673",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_05_01 If A cSourceNotification Is Successfully Sent The Notification Member Shall Be Updated
- **Requirement (doc):** Check that if a cSourceNotification is sent successfully to the "endpoint" member, the "notification.timesSent" member shall be incremented by one and the "notification.lastSuccess" and "notification.lastNotification" members shall be updated with the current timestamp and the status of the context source registration subscription shall be updated to "ok"
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:9572640867887409",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:9572640867887409",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_06_01 If A cSourceNotification Is Not Successfully Sent The Notification Member Shall Be Updated
- **Requirement (doc):** Check that if a cSourceNotification is not sent successfully, the "notification.timesSent" member shall be incremented by one and the notification.lastFailure" and "notification.lastNotification" members shall be updated with the current timestamp and the status of the context source registration subscription shall be updated to "failed"
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['status'] removed from dictionary.
Item root['timesSent'] removed from dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 {
   'format': 'keyValues',
   'endpoint': {
-     'uri': 'http://localhost:1111/notify',
+     'uri': 'http://unreachable.endpoint/notify',
     'accept': 'application/json',
   },
-   'status': 'failed',
-   'timesSent': 1,
 }

```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4950393022594114",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4950393022594114",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_08_01 Receive cSourceNotification For Matching Context Source Registrations Providing Latest Information
- **Requirement (doc):** Check if a context source registration subscription does not define a temporalQ member, a CsourceNotification will be triggered from matching context source registrations for context sources providing latest information
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5381864533260544",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5381864533260544",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_09_01 Receive cSourceNotification For No Longer Matching Context Source Registrations Providing Latest Information
- **Requirement (doc):** Check if a context source registration subscription defines an "entities" member, a CsourceNotification will be triggered from context source registrations with information member matching the described "entities"
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- **Request under test:**

```json
{
    "method": "PATCH",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:4131227586281332",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "54",
        "Content-Type": "application/json"
    },
    "body": {
        "information": [
            {
                "entities": [
                    {
                        "type": "NewType"
                    }
                ]
            }
        ]
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:4131227586281332",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_12_01 Receive cSourceNotification For Matching Context Source Registrations On Watched Attributes
- **Requirement (doc):** Check if a context source registrations subscription defines entities member and watchedAttributes member, a CsourceNotification will be triggered from context source registrations with information member matching the described "entities" and "attributes"
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:1439799949635608",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:1439799949635608",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_14_01 Receive cSourceNotification For Matching Context Source Registrations On Location
- **Requirement (doc):** Check if a context source registrations subscription defines a geoQ member, a CsourceNotification will be triggered from matching context source registrations with a matching location member
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5571659447686387",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5571659447686387",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_15_01 Receive cSourceNotification For Matching Context Source Registrations On Location As Default
- **Requirement (doc):** Check if a context source registrations subscription does not define a geoproperty in the geoQ member, a CsourceNotification will be triggered from matching context source registrations with a matching location member
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:7444415732390101",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:7444415732390101",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_16_01 MatchFirstContextSourceRegistration
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:4231881588054911",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:4231881588054911",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_16_03 MatchBothContextSourceRegistrations
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3085836000467625",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3085836000467625",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```


## Consumption-TemporalEntity  (1 failing)

### 021_25 Query All Temporal Entities With Local Flag
- **Requirement (doc):** Check that one can query all temporal evolution of entities if query is local
- **Spec clauses / tags:** 5_7_4, not-implemented, te-query
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:Vehicle:021-06-B'] added to dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Vehicle:021-06-A',
     'type': 'Vehicle',
     'fuelLevel': [
       {
         'type': 'Property',
-         'value': 40,
+         'value': 67,
-         'observedAt': '2020-08-01T14:07:00Z',
+         'observedAt': '2020-08-01T12:03:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:f1568acc-9580-4089-8121-4285c87b4518',
       },
       {
         'type': 'Property',
-         'value': 67,
+         'value': 53,
-         'observedAt': '2020-08-01T12:03:00Z',
+         'observedAt': '2020-08-01T13:05:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:55efc8c1-54c2-4a68-aa93-4ea0612d65a5',
       },
       {
         'type': 'Property',
-         'value': 53,
+         'value': 40,
-         'observedAt': '2020-08-01T13:05:00Z',
+         'observedAt': '2020-08-01T14:07:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:896a8bcb-220f-4fee-a5ce-6fd91395e5f5',
       },
     ],
     'speed': [
       {
         'type': 'Property',
-         'value': 100,
+         'value': 120,
-         'observedAt': '2020-08-01T12:07:00Z',
+         'observedAt': '2020-08-01T12:03:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:32c7f409-f8ff-42ee-9330-961921cbfd3b',
       },
       {
         'type': 'Property',
         'value': 80,
         'observedAt': '2020-08-01T12:05:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:00bbcfaf-1779-4f73-8909-8a50f26fe6ef',
       },
       {
         'type': 'Property',
-         'value': 120,
+         'value': 100,
-         'observedAt': '2020-08-01T12:03:00Z',
+         'observedAt': '2020-08-01T12:07:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:cd485557-63f7-4cde-b8b0-2ddd5632723c',
       },
     ],
   },
+   {
+     'id': 'urn:ngsi-ld:Vehicle:021-06-B',
+     'type': 'Vehicle',
+     'fuelLevel': [
+       {
+         'type': 'Property',
+         'value': 67,
+         'observedAt': '2020-09-01T12:03:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:9b45380a-c46a-468f-8aa8-4e4084d78f43',
+       },
+       {
+         'type': 'Property',
+         'value': 53,
+         'observedAt': '2020-09-01T13:05:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:a7b52e57-7dfd-4335-8efc-d585f02c54c9',
+       },
+       {
+         'type': 'Property',
+         'value': 40,
+         'observedAt': '2020-09-01T14:07:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:23436f12-a36d-4a27-889b-2bb779b46c0f',
+       },
+     ],
+     'speed': [
+       {
+         'type': 'Property',
+         'value': 120,
+         'observedAt': '2020-09-01T12:03:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:64cf5b92-cf53-4ef3-91c1-fc651a050373',
+       },
+       {
+         'type': 'Property',
+         'value': 80,
+         'observedAt': '2020-09-01T12:05:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:97462946-6402-4e97-ba7f-1e51e3e7512b',
+       },
+       {
+         'type': 'Property',
+         'value': 100,
+         'observedAt': '2020-09-01T12:07:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:4c8b8091-4fac-4f18-ae85-96866d4be274',
+       },
+     ],
+   },
 ]

```
- **Request under test:**

```json
{
    "method": "GET",
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities?timerel=after&timeAt=2020-07-01T12%3A05%3A00Z&local=true",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Link": "<https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\""
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities?timerel=after&timeAt=2020-07-01T12%3A05%3A00Z&local=true",
    "headers": {
        "content-length": "2276",
        "Content-Type": "application/json",
        "Link": "<https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\""
    },
    "status_code": 200,
    "reason": "OK",
    "body": [
        {
            "id": "urn:ngsi-ld:Vehicle:021-06-A",
            "type": "Vehicle",
            "fuelLevel": [
                {
                    "type": "Property",
                    "value": 67,
                    "observedAt": "2020-08-01T12:03:00Z",
                    "instanceId": "urn:ngsi-ld:Instance:f1568acc-9580-4089-8121-4285c87b4518"
                },
                {
                    "type": "Property",
                    "value": 53,
                    "observedAt": "2020-08-01T13:05:00Z",
                    "instanceId": "urn:ngsi-ld:Instance:55efc8c1-54c2-4a68-aa93-4ea0612d65a5"
                },
                {
                    "type": "Property",
                    "value": 40,
                    "observedAt": "2020-08-01T14:07:00Z",
                    "instanceId": "urn:ngsi-ld:Instance:896a8bcb-220f-4fee-a5ce-6fd91395e5f5"
                }
            ],
            "speed": [
                {
                    "type": "Property",
                    "value": 120,
                    "observedAt": "2020-08-01T12:03:00Z",
                    "instanceId": "urn:ngsi-ld:Instance:32c7f409-f8ff-42ee-9330-961921cbfd3b"
                },
                {
                    "type": "Property",
                    "value": 80,
                    "observedAt": "2020-08-01T12:05:00Z",
                    "instanceId": "urn:ngsi-ld:Instance:00bbcfaf-1779-4f73-8909-8a50f26fe6ef"
                },
                {
           
```


## ContextSource  (27 failing)

### 037_07_01 Near Point
- **Spec clauses / tags:** 5_10_2, csr-query
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:ContextSourceRegistration:4162959855500940']['location']['coordinates'] added to dictionary.
Item root['urn:ngsi-ld:ContextSourceRegistration:4162959855500940']['location']['value'] removed from dictionary.
Value of root['urn:ngsi-ld:ContextSourceRegistration:4162959855500940']['location']['type'] changed from "GeoProperty" to "Point".
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:ContextSourceRegistration:4162959855500940',
     'type': 'ContextSourceRegistration',
     'information': [
       {
         'entities': [
           {
             'type': 'Building',
           },
         ],
       },
     ],
     'location': {
-       'type': 'GeoProperty',
+       'type': 'Point',
-       'value': {
-         'type': 'Point',
-         'coordinates': [
-           -8.521,
-           41.2,
-         ],
-       },
+       'coordinates': [
+         -8.521,
+         41.2,
+       ],
     },
     'endpoint': 'http://my.csource.org:1026',
   },
 ]

```
- _(test also issued 2 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:4162959855500940",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:4162959855500940",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 037_07_02 Within Polygon
- **Spec clauses / tags:** 5_10_2, csr-query
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 200 != 400
  ```
- _(test also issued 2 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:2442139276966472",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:2442139276966472",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 037_10_01 With List Of Entity Ids
- **Spec clauses / tags:** 5_10_2, csr-query
- **What is wrong (expected vs actual):**

  ```
  Value of root changed from {'urn:ngsi-ld:ContextSourceRegistration:7960633968462031,urn:ngsi-ld:ContextSourceRegistration:3488522983298822': {'type': 'ContextSourceRegistration', 'information': [{'entities': [{'type': 'Building'}]}], 'endpoint': 'http://my.csource.org:1026'}, 'urn:ngsi-ld:ContextSourceRegistration:randomUUID': {'type': 'ContextSourceRegistration', 'information': [{'entities': [{'type': 'Building'}]}], 'location': {'type': 'Point', 'coordinates': [-8.521, 41.2]}, 'endpoint': 'http://my.csource.org:1026', 'csourceProperty1': 'aValue', 'csourceProperty2': 'anotherValue', '@context': ['https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld']}} to {'urn:ngsi-ld:ContextSourceRegistration:3488522983298822': {'type': 'ContextSourceRegistration', 'csourceProperty1': 'aValue', 'csourceProperty2': 'anotherValue', 'endpoint': 'http://my.csource.org:1026', 'information': [{'entities': [{'type': 'Building'}]}]}, 'urn:ngsi-ld:ContextSourceRegistration:2802547354379509': {'type': 'ContextSourceRegistration', 'endpoint': 'http://my.csource.org:1026', 'information': [{'entities': [{'type': 'Building'}], 'propertyNames': ['name', 'subCategory'], 'relationshipNames': ['locatedAt']}]}}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
-     'id': 'urn:ngsi-ld:ContextSourceRegistration:7960633968462031,urn:ngsi-ld:ContextSourceRegistration:3488522983298822',
+     'id': 'urn:ngsi-ld:ContextSourceRegistration:3488522983298822',
     'type': 'ContextSourceRegistration',
     'information': [
       {
         'entities': [
           {
             'type': 'Building',
           },
         ],
       },
     ],
     'endpoint': 'http://my.csource.org:1026',
+     'csourceProperty1': 'aValue',
+     'csourceProperty2': 'anotherValue',
   },
   {
-     'id': 'urn:ngsi-ld:ContextSourceRegistration:randomUUID',
+     'id': 'urn:ngsi-ld:ContextSourceRegistration:2802547354379509',
     'type': 'ContextSourceRegistration',
     'information': [
       {
         'entities': [
           {
             'type': 'Building',
           },
         ],
+         'propertyNames': [
+           'name',
+           'subCategory',
+         ],
+         'relationshipNames': [
+           'locatedAt',
+         ],
       },
     ],
-     'location': {
-       'type': 'Point',
-       'coordinates': [
-         -8.521,
-         41.2,
-       ],
-     },
     'endpoint': 'http://my.csource.org:1026',
-     'csourceProperty1': 'aValue',
-     'csourceProperty2': 'anotherValue',
-     '@context': [
-       'https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld',
-     ],
   },
 ]

```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3488522983298822",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3488522983298822",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 037_10_02 With NGSI-LD Query
- **Spec clauses / tags:** 5_10_2, csr-query
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:ContextSourceRegistration:9753339557065998'] removed from dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
-   {
-     'id': 'urn:ngsi-ld:ContextSourceRegistration:9753339557065998',
-     'type': 'ContextSourceRegistration',
-     'information': [
-       {
-         'entities': [
-           {
-             'type': 'Building',
-           },
-         ],
-       },
-     ],
-     'location': {
-       'type': 'Point',
-       'coordinates': [
-         -8.521,
-         41.2,
-       ],
-     },
-     'endpoint': 'http://my.csource.org:1026',
-     'csourceProperty1': 'aValue',
-     'csourceProperty2': 'anotherValue',
-     '@context': [
-       'https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld',
-     ],
-   },
 ]

```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9753339557065998",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9753339557065998",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 037_11_01 Query Second Subscription
- **Spec clauses / tags:** 5_10_2, csr-query
- **What is wrong (expected vs actual):**

  ```
  0 != 1
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9991651581220103",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9991651581220103",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 037_11_02 Query Last Subscription
- **Spec clauses / tags:** 5_10_2, csr-query
- **What is wrong (expected vs actual):**

  ```
  0 != 1
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9475210288951578",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9475210288951578",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_01_01 Receive cSourceNotification Periodically And Initially On Subscription
- **Requirement (doc):** Check that if the created context source registration subscription defines a timeInterval member, a cSourceNotification will be sent periodically, initially on subscription and when the time interval is reached
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- **Request under test:**

```json
{
    "method": "POST",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Type": "application/ld+json",
        "Content-Length": "395"
    },
    "body": {
        "id": "urn:ngsi-ld:Subscription:5133346611974782",
        "type": "Subscription",
        "timeInterval": 10,
        "entities": [
            {
                "type": "Building"
            }
        ],
        "notification": {
            "format": "keyValues",
            "endpoint": {
                "uri": "http://0.0.0.0:8085/notify",
                "accept": "application/json"
            }
        },
        "@context": [
            "https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld"
        ]
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions",
    "headers": {
        "Location": "/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5133346611974782",
        "content-length": "0"
    },
    "status_code": 201,
    "reason": "Created",
    "body": null
}
```

### 047_02_01 Receive cSourceNotification Initially On Subscription And Whenever There Is A Change Of A Matching Context Source Registration
- **Requirement (doc):** Check that if the created context source registration subscription does not define a timeInterval member, a cSourceNotification, with the appropriate trigger reason in the "triggerReason" member, will be sent initially on subscription and whenever there is a change of a matching Context Source Registration
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Setup failed:
Timeout: request was not received.
  ```
- **Expected body (reference):**

```json
['urn:ngsi-ld:ContextSourceRegistration:6009984126573530']
```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6989623594790343",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6989623594790343",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_03_01 Receive cSourceNotification With Relevant Information
- **Requirement (doc):** Check that instead of providing the original context source registration, implementations should return context source registration information relevant for the subscription, in particular only matching RegistrationInfo elements
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Dictionary '${registration_information}[entities]' has no key '0'.
  ```
- **Expected body (reference):**

```json
1
```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:2972651932368187",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:2972651932368187",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_04_01 Receive cSourceNotification With Compliant Structure
- **Requirement (doc):** The structure of the csource notification message shall be as mandated by clause 5.3.2
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:8852280901476081",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:8852280901476081",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_05_01 If A cSourceNotification Is Successfully Sent The Notification Member Shall Be Updated
- **Requirement (doc):** Check that if a cSourceNotification is sent successfully to the "endpoint" member, the "notification.timesSent" member shall be incremented by one and the "notification.lastSuccess" and "notification.lastNotification" members shall be updated with the current timestamp and the status of the context source registration subscription shall be updated to "ok"
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4672717203428031",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4672717203428031",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_06_01 If A cSourceNotification Is Not Successfully Sent The Notification Member Shall Be Updated
- **Requirement (doc):** Check that if a cSourceNotification is not sent successfully, the "notification.timesSent" member shall be incremented by one and the notification.lastFailure" and "notification.lastNotification" members shall be updated with the current timestamp and the status of the context source registration subscription shall be updated to "failed"
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['status'] removed from dictionary.
Item root['timesSent'] removed from dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 {
   'format': 'keyValues',
   'endpoint': {
-     'uri': 'http://localhost:1111/notify',
+     'uri': 'http://unreachable.endpoint/notify',
     'accept': 'application/json',
   },
-   'status': 'failed',
-   'timesSent': 1,
 }

```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:3537202945945100",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:3537202945945100",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_08_01 Receive cSourceNotification For Matching Context Source Registrations Providing Latest Information
- **Requirement (doc):** Check if a context source registration subscription does not define a temporalQ member, a CsourceNotification will be triggered from matching context source registrations for context sources providing latest information
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4720913430232182",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4720913430232182",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_09_01 Receive cSourceNotification For No Longer Matching Context Source Registrations Providing Latest Information
- **Requirement (doc):** Check if a context source registration subscription defines an "entities" member, a CsourceNotification will be triggered from context source registrations with information member matching the described "entities"
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- **Request under test:**

```json
{
    "method": "PATCH",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:4618486280099970",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "54",
        "Content-Type": "application/json"
    },
    "body": {
        "information": [
            {
                "entities": [
                    {
                        "type": "NewType"
                    }
                ]
            }
        ]
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:4618486280099970",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_12_01 Receive cSourceNotification For Matching Context Source Registrations On Watched Attributes
- **Requirement (doc):** Check if a context source registrations subscription defines entities member and watchedAttributes member, a CsourceNotification will be triggered from context source registrations with information member matching the described "entities" and "attributes"
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5970135190480066",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5970135190480066",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_14_01 Receive cSourceNotification For Matching Context Source Registrations On Location
- **Requirement (doc):** Check if a context source registrations subscription defines a geoQ member, a CsourceNotification will be triggered from matching context source registrations with a matching location member
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:9997539332567258",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:9997539332567258",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_15_01 Receive cSourceNotification For Matching Context Source Registrations On Location As Default
- **Requirement (doc):** Check if a context source registrations subscription does not define a geoproperty in the geoQ member, a CsourceNotification will be triggered from matching context source registrations with a matching location member
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:7432511806097469",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:7432511806097469",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_16_01 MatchFirstContextSourceRegistration
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3013801012490442",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3013801012490442",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_16_03 MatchBothContextSourceRegistrations
- **Spec clauses / tags:** 5_11_7, csrsub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3851906906713777",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3851906906713777",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 038_02_01 Create Context Source Registration Subscription Without An Id
- **Requirement (doc):** Check that one can create a context source registration subscription without providing an id and it will be automatically generated
- **Spec clauses / tags:** 5_11_2, csrsub-create
- **What is wrong (expected vs actual):**

  ```
  Value of root changed from {'type': 'Subscription', 'entities': [{'type': 'Building'}], 'notification': {'format': 'keyValues', 'endpoint': {'uri': 'http://localhost:1111/notify', 'accept': 'application/json'}}, '@context': ['https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld']} to {'type': 'https://uri.etsi.org/ngsi-ld/errors/MethodNotAllowed', 'title': 'Method not supported on this endpoint.', 'detail': 'Method not supported on this endpoint.', 'status': 405}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 {
-   'type': 'Subscription',
+   'type': 'https://uri.etsi.org/ngsi-ld/errors/MethodNotAllowed',
-   'entities': [
-     {
-       'type': 'Building',
-     },
-   ],
-   'notification': {
-     'format': 'keyValues',
-     'endpoint': {
-       'uri': 'http://localhost:1111/notify',
-       'accept': 'application/json',
-     },
-   },
-   '@context': [
-     'https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld',
-   ],
+   'title': 'Method not supported on this endpoint.',
+   'detail': 'Method not supported on this endpoint.',
+   'status': 405,
 }

```
- _(test also issued 1 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "GET",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions//ngsi-ld/v1/csourceSubscriptions/urn:36410bdf-0389-4613-afa3-d7a6188f8def",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "application/ld+json",
        "Connection": "keep-alive",
        "Link": "<https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\""
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions//ngsi-ld/v1/csourceSubscriptions/urn:36410bdf-0389-4613-afa3-d7a6188f8def",
    "headers": {
        "content-length": "175",
        "Content-Type": "application/json"
    },
    "status_code": 405,
    "reason": "Method Not Allowed",
    "body": {
        "type": "https://uri.etsi.org/ngsi-ld/errors/MethodNotAllowed",
        "title": "Method not supported on this endpoint.",
        "detail": "Method not supported on this endpoint.",
        "status": 405
    }
}
```

### 038_08_03 InvalidQuery
- **Spec clauses / tags:** 5_11_2, csrsub-create
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 400 != 201
  ```
- **Request under test:**

```json
{
    "method": "POST",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Type": "application/ld+json",
        "Content-Length": "398"
    },
    "body": {
        "id": "urn:ngsi-ld:Subscription:2298139981390441",
        "type": "Subscription",
        "entities": [
            {
                "type": "Building"
            }
        ],
        "q": "invalidQuery",
        "notification": {
            "format": "keyValues",
            "endpoint": {
                "uri": "http://localhost:1111/notify",
                "accept": "application/json"
            }
        },
        "@context": [
            "https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld"
        ]
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions",
    "headers": {
        "Location": "/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:2298139981390441",
        "content-length": "0"
    },
    "status_code": 201,
    "reason": "Created",
    "body": null
}
```

### 041_01_01 Query Context Source Registration Subscriptions
- **Requirement (doc):** Check that one can query context source registration subscriptions
- **Spec clauses / tags:** 5_11_5, csrsub-query
- **What is wrong (expected vs actual):**

  ```
  Item root[2] added to iterable.
Item root[3] added to iterable.
Value of root[1] changed from {'id': 'urn:ngsi-ld:Subscription:8062284917466892', 'type': 'Subscription', 'watchedAttributes': ['name', 'subCategory'], 'entities': [{'type': 'Building'}], 'notification': {'format': 'keyValues', 'endpoint': {'uri': 'http://localhost:1111/notify', 'accept': 'application/json'}}, 'status': 'active'} to {'id': 'urn:ngsi-ld:Subscription:2298139981390441', 'type': 'Subscription', 'entities': [{'type': 'Building'}], 'notification': {'endpoint': {'accept': 'application/json', 'uri': 'http://localhost:1111/notify'}, 'format': 'keyValues'}, 'q': 'invalidQuery'}.
Value of root[0] changed from {'id': 'urn:ngsi-ld:Subscription:7555501825829494', 'type': 'Subscription', 'entities': [{'type': 'Building'}], 'notification': {'format': 'keyValues', 'endpoint': {'uri': 'http://localhost:1111/notify', 'accept': 'application/json'}}, 'status': 'active'} to {'id': 'urn:36410bdf-0389-4613-afa3-d7a6188f8def', 'type': 'Subscription', 'entities': [{'type': 'Building'}], 'notification': {'endpoint': {'accept': 'application/json', 'uri': 'http://localhost:1111/notify'}, 'format': 'keyValues'}}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
-     'id': 'urn:ngsi-ld:Subscription:7555501825829494',
+     'id': 'urn:36410bdf-0389-4613-afa3-d7a6188f8def',
     'type': 'Subscription',
     'entities': [
       {
         'type': 'Building',
       },
     ],
     'notification': {
       'format': 'keyValues',
       'endpoint': {
         'uri': 'http://localhost:1111/notify',
         'accept': 'application/json',
       },
     },
-     'status': 'active',
   },
   {
-     'id': 'urn:ngsi-ld:Subscription:8062284917466892',
+     'id': 'urn:ngsi-ld:Subscription:2298139981390441',
     'type': 'Subscription',
-     'watchedAttributes': [
-       'name',
-       'subCategory',
-     ],
     'entities': [
       {
         'type': 'Building',
       },
     ],
     'notification': {
       'format': 'keyValues',
       'endpoint': {
         'uri': 'http://localhost:1111/notify',
         'accept': 'application/json',
       },
     },
-     'status': 'active',
+     'q': 'invalidQuery',
   },
+   {
+     'id': 'urn:ngsi-ld:Subscription:7555501825829494',
+     'type': 'Subscription',
+     'entities': [
+       {
+         'type': 'Building',
+       },
+     ],
+     'notification': {
+       'endpoint': {
+         'accept': 'application/json',
+         'uri': 'http://localhost:1111/notify',
+       },
+       'format': 'keyValues',
+     },
+   },
+   {
+     'id': 'urn:ngsi-ld:Subscription:8062284917466892',
+     'type': 'Subscription',
+     'entities': [
+       {
+         'type': 'Building',
+       },
+     ],
+     'notification': {
+       'endpoint': {
+         'accept': 'application/json',
+         'uri': 'http://localhost:1111/notify',
+       },
+       'format': 'keyValues',
+     },
+     'watchedAttributes': [
+       'name',
+       'subCategory',
+     ],
+   },
 ]

```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:8062284917466892",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:8062284917466892",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 041_02_03 Query All Subscriptions
- **Spec clauses / tags:** 5_11_5, csrsub-query
- **What is wrong (expected vs actual):**

  ```
  5 != 3
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6483468522456797",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6483468522456797",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 041_03_01 Query Second Subscription
- **Spec clauses / tags:** 5_11_5, csrsub-query
- **What is wrong (expected vs actual):**

  ```
  Lists are different:
Index 1: <https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>;rel="http://www.w3.org/ns/json-ld#context";type="application/ld+json" != </ngsi-ld/v1/csourceSubscriptions?limit=1&offset=2>;rel="next";type="application/ld+json"
  ```
- **Expected body (reference):**

```json
['</ngsi-ld/v1/csourceSubscriptions?limit=1&offset=0>;rel="prev";type="application/ld+json"', '</ngsi-ld/v1/csourceSubscriptions?limit=1&offset=2>;rel="next";type="application/ld+json"']
```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6276725662039941",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6276725662039941",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 041_03_02 Query Last Subscription
- **Spec clauses / tags:** 5_11_5, csrsub-query
- **What is wrong (expected vs actual):**

  ```
  2 != 1
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:1910232744301637",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:1910232744301637",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 041_03_03 Query All Subscriptions
- **Spec clauses / tags:** 5_11_5, csrsub-query
- **What is wrong (expected vs actual):**

  ```
  5 != 3
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:8549451478249181",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:8549451478249181",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 039_01_01 Update Context Source Registration Subscription
- **Requirement (doc):** Check that one can update a context source registration subscription
- **Spec clauses / tags:** 5_11_3, csrsub-update
- **What is wrong (expected vs actual):**

  ```
  Item root['status'] added to dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 {
   'id': 'urn:ngsi-ld:Subscription:1584904685674626',
   'type': 'Subscription',
   'entities': [
     {
       'type': 'Building',
     },
   ],
   'notification': {
     'format': 'keyValues',
     'endpoint': {
       'uri': 'http://my.second.endpoint.org/notify',
       'accept': 'application/json',
     },
   },
   '@context': [
     'https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld',
   ],
+   'status': 'active',
 }

```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:1584904685674626",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:1584904685674626",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```


## Provision-TemporalEntityAttributes  (1 failing)

### 017_02_05 Delete An Attribute Instance In Temporal Representation Of An Entity If The Attribute Name Is Not Present
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 400 != 404
  ```
- **Expected body (reference):**

```json
{'id': 'urn:ngsi-ld:Vehicle:randomUUID', 'type': 'Vehicle', 'speed': [{'type': 'Property', 'value': 120, 'observedAt': '2020-09-01T12:03:00Z'}, {'type': 'Property', 'value': 80, 'observedAt': '2020-09...
```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Vehicle:2283069509434240",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Vehicle:2283069509434240",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```


## Subscription  (31 failing)

### 046_02_01 Check That A Notification Is Sent On The timeInterval
- **Requirement (doc):** If a Subscription defines a timeInterval member, a Notification shall be sent periodically, when the time interval (in seconds) specified in such value field is reached, regardless of Attribute changes.
- **Spec clauses / tags:** 5_8_6, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 1 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "POST",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Type": "application/ld+json",
        "Content-Length": "419"
    },
    "body": {
        "id": "urn:ngsi-ld:Subscription:3810057468718294",
        "type": "Subscription",
        "timeInterval": 10,
        "entities": [
            {
                "type": "Building",
                "id": "urn:ngsi-ld:Building:9496077585746465"
            }
        ],
        "notification": {
            "endpoint": {
                "uri": "http://0.0.0.0:8085/notify",
                "accept": "application/json"
            }
        },
        "@context": [
            "https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld"
        ]
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/",
    "headers": {
        "Location": "/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:3810057468718294",
        "content-length": "0"
    },
    "status_code": 201,
    "reason": "Created",
    "body": null
}
```

### 046_10_01 Check That The Notification Is Sent As JSON
- **Requirement (doc):** The Notification shall be sent as JSON
- **Spec clauses / tags:** 5_8_6, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Value of dictionary key 'Link' does not match: <http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json" != <https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"
  ```
- **Expected body (reference):**

```json
<https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"
```
- **Request under test:**

```json
{
    "method": "PATCH",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:4322569293468848/attrs/",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Type": "application/ld+json",
        "Content-Length": "318"
    },
    "body": {
        "airQualityLevel": {
            "type": "Property",
            "value": 5,
            "unitCode": "C62",
            "observedAt": "2020-10-10T16:40:00.000Z"
        },
        "@context": [
            "https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld"
        ]
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:4322569293468848/attrs/",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_16_01 Check That A Notification Is Sent With Entity Matching The Entity Type Selection
- **Requirement (doc):** If a subscription defines an entity type selection query, a notification shall be sent whenever an entity matches the query.
- **Spec clauses / tags:** 5_8_6, since_v1.5.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- **Request under test:**

```json
{
    "method": "POST",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Type": "application/ld+json",
        "Content-Length": "487"
    },
    "body": {
        "id": "urn:ngsi-ld:Building:6289192550683629",
        "type": "Building",
        "name": {
            "type": "Property",
            "value": "Eiffel Tower"
        },
        "subCategory": {
            "type": "Property",
            "value": "tourism"
        },
        "airQualityLevel": {
            "type": "Property",
            "value": 4,
            "unitCode": "C62",
            "observedAt": "2020-09-09T16:40:00.000Z"
        },
        "almostFull": {
            "type": "Property",
            "value": false
        },
        "@context": [
            "https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld"
        ]
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/",
    "headers": {
        "Location": "/ngsi-ld/v1/entities/urn:ngsi-ld:Building:6289192550683629",
        "content-length": "0"
    },
    "status_code": 201,
    "reason": "Created",
    "body": null
}
```

### 046_19 Check That Only The Attribute Instances That Match The datasetId Member Are Included In The Entity In The Notification
- **Requirement (doc):** If a subscription has a datasetId member instances should be filtered based on that datasetId.
- **Spec clauses / tags:** 4_5_5, 5_8_6, since_v1.8.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Type of root['@context'] changed from str to list and value changed from "https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld" to [None].
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 {
-   'id': 'urn:ngsi-ld:Building:randomUUID',
+   'id': 'urn:ngsi-ld:Building:0542611328814480',
   'type': 'Building',
   'name': {
     'type': 'Property',
     'value': 'Le Tour Eiffel',
     'datasetId': 'urn:ngsi-ld:Dataset:french-name',
   },
   'locatedAt': {
     'type': 'Relationship',
     'datasetId': 'urn:ngsi-ld:Dataset:french-name',
     'object': 'urn:ngsi-ld:Ville:Paris',
   },
-   '@context': 'https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld',
+   '@context': [
+     None,
+   ],
 }

```
- **Request under test:**

```json
{
    "method": "PATCH",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:0542611328814480/attrs/",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Type": "application/ld+json",
        "Content-Length": "277"
    },
    "body": {
        "name": {
            "type": "Property",
            "value": "Le Tour Eiffel",
            "datasetId": "urn:ngsi-ld:Dataset:french-name"
        },
        "@context": [
            "https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld"
        ]
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:0542611328814480/attrs/",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_21_01 Check That A Notification Is Sent With Matching Entity
- **Requirement (doc):** Delete an entity and check the received notification
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Length of '{'id': 'urn:ngsi-ld:Building:None', 'type': 'Building', 'name': 'Eiffel Tower', 'subCategory': 'tourism', 'deletedAt': '2026-06-26T11:36:28.810000Z', 'location': {'type': 'Point', 'coordinates': [13.3986, 52.5547]}}' should be 3 but is 6.
  ```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:4428670029359696",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:4428670029359696",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_21_02 Check That A Notification Is Sent With Matching Entity
- **Requirement (doc):** Delete an entity and check the received notification
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Length of '{'id': 'urn:ngsi-ld:Building:None', 'type': 'Building', 'name': 'Eiffel Tower', 'subCategory': 'tourism', 'createdAt': '2026-06-26T11:36:29.471000Z', 'deletedAt': '2026-06-26T11:36:29.506000Z', 'location': {'type': 'Point', 'coordinates': [13.3986, 52.5547]}, 'modifiedAt': '2026-06-26T11:36:29.471000Z'}' should be 5 but is 8.
  ```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:7013609476222878",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:7013609476222878",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_03 Check That A Notification Is Not Sent With Updated Entity
- **Requirement (doc):** Delete a not watched attribute and check no notification is received
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Request was received: POST /notify
b'{\n  "id" : "notification:-5356969376181867957",\n  "type" : "Notification",\n  "subscriptionId" : "urn:ngsi-ld:Subscription:8097532885436656",\n  "notifiedAt" : "2026-06-26T11:36:31.554000Z",\n  "data" : [ {\n    "id" : "urn:ngsi-ld:Building:None",\n    "type" : "Building",\n    "airQualityLevel" : "urn:ngsi-ld:null",\n    "almostFull" : false,\n    "name" : "Eiffel Tower",\n    "subCategory" : "tourism"\n  } ]\n}'.
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_05 Check That A Notification Is Sent With Matching Entity
- **Requirement (doc):** Delete an attribute and check the received notification
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  No value found for path ['deletedAt']
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_07 Check That A Notification Is Sent With Matching Entity
- **Requirement (doc):** Delete an attribute with a specific datasetId and check the received notification
- **Spec clauses / tags:** 4_5_5, 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Type of root['name'] changed from dict to list and value changed from {'dataset': {'urn:ngsi-ld:Dataset:german-name': 'Eiffelturm', '@none': 'Eiffel Tower', 'urn:ngsi-ld:Dataset:french-name': 'urn:ngsi-ld:null'}} to ['Eiffel Tower', 'urn:ngsi-ld:null', 'Eiffelturm'].
Type of root['locatedAt'] changed from dict to list and value changed from {'dataset': {'urn:ngsi-ld:Dataset:french-name': 'urn:ngsi-ld:Ville:Paris', 'urn:ngsi-ld:Dataset:spanish-name': 'urn:ngsi-ld:Ciudad:ParÃ\xads', '@none': 'urn:ngsi-ld:City:Paris'}} to ['urn:ngsi-ld:City:Paris', 'urn:ngsi-ld:Ville:Paris', 'urn:ngsi-ld:Ciudad:ParÃ\xads'].
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 {
-   'id': 'urn:ngsi-ld:Building:randomUUID',
+   'id': 'urn:ngsi-ld:Building:None',
   'type': 'Building',
-   'name': {
-     'dataset': {
-       'urn:ngsi-ld:Dataset:german-name': 'Eiffelturm',
-       '@none': 'Eiffel Tower',
-       'urn:ngsi-ld:Dataset:french-name': 'urn:ngsi-ld:null',
-     },
-   },
+   'name': [
+     'Eiffel Tower',
+     'urn:ngsi-ld:null',
+     'Eiffelturm',
+   ],
-   'locatedAt': {
-     'dataset': {
-       'urn:ngsi-ld:Dataset:french-name': 'urn:ngsi-ld:Ville:Paris',
-       'urn:ngsi-ld:Dataset:spanish-name': 'urn:ngsi-ld:Ciudad:ParÃ\xads',
-       '@none': 'urn:ngsi-ld:City:Paris',
-     },
-   },
+   'locatedAt': [
+     'urn:ngsi-ld:City:Paris',
+     'urn:ngsi-ld:Ville:Paris',
+     'urn:ngsi-ld:Ciudad:ParÃ\xads',
+   ],
 }

```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_08 Check That A Notification Is Sent With Matching Entity
- **Requirement (doc):** Delete all instances of an attribute and check the received notification
- **Spec clauses / tags:** 4_5_5, 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Resolving variable '${response_body['name']['value']}' failed: TypeError: list indices must be integers or slices, not str
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_09_02 Check That A Notification Is Sent With Matching Entity When Deleting Via Update Attributes Operation
- **Requirement (doc):** Delete an attribute via Update Attributes operation and check the received notification
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_09_03 Check That A Notification Is Sent With Matching Entity When Deleting Via Partial Attribute Update Operation
- **Requirement (doc):** Delete an attribute via Update Partial Attribute Update operation and check the received notification
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_10_02 Check That A Notification Is Sent With Matching Entity When Deleting Via Update Attributes Operation
- **Requirement (doc):** Delete a relationship via Update Attributes operation and check the received notification
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_10_03 Check That A Notification Is Sent With Matching Entity When Deleting Via Partial Attribute Update Operation
- **Requirement (doc):** Delete a relationship via Update Partial Attribute Update operation and check the received notification
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_11_01 Check That A Notification Is Sent With Matching Entity When Deleting Via Merge Entity Operation
- **Requirement (doc):** Delete a language property via Merge Entity operation and check the received notification
- **Spec clauses / tags:** 4_5_18, 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['street']['value'] added to dictionary.
Item root['street']['languageMap'] removed from dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 {
-   'id': 'urn:ngsi-ld:Building:4446320091579470',
+   'id': 'urn:ngsi-ld:Building:None',
   'type': 'Building',
   'location': {
     'type': 'GeoProperty',
     'value': {
       'type': 'Point',
       'coordinates': [
         -8.5,
         41.2,
       ],
     },
   },
   'street': {
     'type': 'LanguageProperty',
-     'languageMap': {
-       '@none': 'urn:ngsi-ld:null',
-     },
+     'value': 'urn:ngsi-ld:null',
   },
   'locatedAt': {
     'type': 'Relationship',
     'object': 'urn:ngsi-ld:City:Paris',
   },
   'name': {
     'type': 'Property',
     'value': 'Eiffel Tower',
   },
 }

```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_11_02 Check That A Notification Is Sent With Matching Entity When Deleting Via Update Attributes Operation
- **Requirement (doc):** Delete a language property via Update Attributes operation and check the received notification
- **Spec clauses / tags:** 4_5_18, 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_11_03 Check That A Notification Is Sent With Matching Entity When Deleting Via Partial Attribute Update Operation
- **Requirement (doc):** Delete a language property via Update Partial Attribute Update operation and check the received notification
- **Spec clauses / tags:** 4_5_18, 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_22_12 Check That A Notification Is Sent With Matching Entity
- **Requirement (doc):** Delete an entity with a matching attribute and check the received notification
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "content-length": "137",
        "Content-Type": "application/json"
    },
    "status_code": 404,
    "reason": "Not Found",
    "body": {
        "type": "https://uri.etsi.org/ngsi-ld/errors/ResourceNotFound",
        "title": "Resource not found.",
        "detail": "Resource not found.",
        "status": 404
    }
}
```

### 046_22_13 Check That A Notification Is Sent With Matching Entity
- **Requirement (doc):** Delete an entity with a matching attribute and check the received notification
- **Spec clauses / tags:** 5_8_6, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Timeout: request was not received.
  ```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:None",
    "headers": {
        "content-length": "137",
        "Content-Type": "application/json"
    },
    "status_code": 404,
    "reason": "Not Found",
    "body": {
        "type": "https://uri.etsi.org/ngsi-ld/errors/ResourceNotFound",
        "title": "Resource not found.",
        "detail": "Resource not found.",
        "status": 404
    }
}
```

### 046_25_01 Check That A Notification Is Sent With Flat Linked Entity In Simplified Format
- **Requirement (doc):** Create an attribute in linking entity and check the notification contains linked entity in simplified format
- **Spec clauses / tags:** 4_5_23, 5_8_6, since_v1.8.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Type of root['urn:ngsi-ld:Building:046_25:EiffelTower']['name'] changed from str to dict and value changed from "Tour Eiffel" to {'type': 'Property', 'value': 'Tour Eiffel'}.
Type of root['urn:ngsi-ld:Building:046_25:EiffelTower']['locatedAt'] changed from str to dict and value changed from "urn:ngsi-ld:City:Paris" to {'type': 'Relationship', 'object': 'urn:ngsi-ld:City:Paris'}.
Type of root['urn:ngsi-ld:City:Paris']['description'] changed from str to dict and value changed from "Paris is the capital and largest city of France" to {'type': 'Property', 'value': 'Paris is the capital and largest city of France'}.
Type of root['urn:ngsi-ld:City:Paris']['name'] changed from str to dict and value changed from "Paris" to {'type': 'Property', 'value': 'Paris'}.
Type of root['urn:ngsi-ld:City:Paris']['isInCountry'] changed from str to dict and value changed from "urn:ngsi-ld:Country:France" to {'type': 'Relationship', 'object': 'urn:ngsi-ld:Country:France'}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Building:046_25:EiffelTower',
     'type': 'Building',
-     'name': 'Tour Eiffel',
+     'name': {
+       'type': 'Property',
+       'value': 'Tour Eiffel',
+     },
-     'locatedAt': 'urn:ngsi-ld:City:Paris',
+     'locatedAt': {
+       'type': 'Relationship',
+       'object': 'urn:ngsi-ld:City:Paris',
+     },
   },
   {
     'id': 'urn:ngsi-ld:City:Paris',
     'type': 'City',
-     'description': 'Paris is the capital and largest city of France',
+     'description': {
+       'type': 'Property',
+       'value': 'Paris is the capital and largest city of France',
+     },
-     'name': 'Paris',
+     'name': {
+       'type': 'Property',
+       'value': 'Paris',
+     },
-     'isInCountry': 'urn:ngsi-ld:Country:France',
+     'isInCountry': {
+       'type': 'Relationship',
+       'object': 'urn:ngsi-ld:Country:France',
+     },
   },
 ]

```
- _(test also issued 8 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_26_01 Check That A Notification Is Sent With Flat Linked Entity And Selected Attributes
- **Requirement (doc):** Create an attribute in linking entity and check the notification contains linked entity with selected attributes
- **Spec clauses / tags:** 4_5_23, 5_8_6, since_v1.8.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:Building:046_26:EiffelTower']['name'] added to dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Building:046_26:EiffelTower',
     'type': 'Building',
     'locatedAt': {
       'type': 'Relationship',
       'object': 'urn:ngsi-ld:City:Paris',
     },
+     'name': {
+       'type': 'Property',
+       'value': 'Tour Eiffel',
+     },
   },
   {
     'id': 'urn:ngsi-ld:City:Paris',
     'type': 'City',
     'description': {
       'type': 'Property',
       'value': 'Paris is the capital and largest city of France',
     },
     'name': {
       'type': 'Property',
       'value': 'Paris',
     },
     'isInCountry': {
       'type': 'Relationship',
       'object': 'urn:ngsi-ld:Country:France',
     },
   },
 ]

```
- _(test also issued 8 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_27_01 Check That A Notification Is Sent With Linked Entity In Inline Representation
- **Requirement (doc):** Create an attribute in linking entity and check the notification contains linked entity
- **Spec clauses / tags:** 4_5_23, 5_8_6, since_v1.8.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:Building:046_27:EiffelTower']['locatedAt']['entity'] removed from dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Building:046_27:EiffelTower',
     'type': 'Building',
     'name': {
       'type': 'Property',
       'value': 'Tour Eiffel',
     },
     'locatedAt': {
       'type': 'Relationship',
       'object': 'urn:ngsi-ld:City:Paris',
-       'entity': {
-         'id': 'urn:ngsi-ld:City:Paris',
-         'type': 'City',
-       },
     },
   },
 ]

```
- _(test also issued 8 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_28_01 Check That A Notification Is Sent With Linked Entity In Inline Representation With sysAttrs
- **Requirement (doc):** Create an attribute in linking entity and check the notification contains linked entity with sysAttrs
- **Spec clauses / tags:** 4_5_23, 5_8_6, since_v1.8.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:Building:046_28:EiffelTower']['locatedAt']['entity'] removed from dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Building:046_28:EiffelTower',
     'type': 'Building',
-     'createdAt': '2025-05-19T14:50:30.958947Z',
+     'createdAt': '2026-06-26T11:38:05.004000Z',
     'name': {
       'type': 'Property',
       'value': 'Tour Eiffel',
-       'createdAt': '2025-05-19T14:50:31.117947Z',
+       'createdAt': '2026-06-26T11:38:05.004000Z',
-       'modifiedAt': '2025-05-19T14:50:31.117947Z',
+       'modifiedAt': '2026-06-26T11:38:05.004000Z',
     },
-     'modifiedAt': '2025-05-19T14:50:31.117947Z',
+     'modifiedAt': '2026-06-26T11:38:05.004000Z',
     'locatedAt': {
       'type': 'Relationship',
-       'createdAt': '2025-05-19T14:50:30.958947Z',
+       'createdAt': '2026-06-26T11:38:04.958000Z',
       'object': 'urn:ngsi-ld:City:Paris',
-       'modifiedAt': '2025-05-19T14:50:30.958947Z',
+       'modifiedAt': '2026-06-26T11:38:04.958000Z',
-       'entity': {
-         'id': 'urn:ngsi-ld:City:Paris',
-         'type': 'City',
-         'createdAt': '2025-05-19T14:50:31.023683Z',
-         'modifiedAt': '2025-05-19T14:50:31.023683Z',
-       },
     },
   },
 ]

```
- _(test also issued 8 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_29_01 Check That A Notification Is Sent With Inline Linked Entity In Simplified Format
- **Requirement (doc):** Create an attribute in linking entity and check the notification contains linked entity in simplified format
- **Spec clauses / tags:** 4_5_23, 5_8_6, since_v1.8.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Type of root['urn:ngsi-ld:Building:046_29:EiffelTower']['name'] changed from str to dict and value changed from "Tour Eiffel" to {'type': 'Property', 'value': 'Tour Eiffel'}.
Value of root['urn:ngsi-ld:Building:046_29:EiffelTower']['locatedAt'] changed from {'id': 'urn:ngsi-ld:City:Paris', 'type': 'City', 'description': 'Paris is the capital and largest city of France', 'name': 'Paris', 'isInCountry': 'urn:ngsi-ld:Country:France'} to {'type': 'Relationship', 'object': 'urn:ngsi-ld:City:Paris'}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Building:046_29:EiffelTower',
     'type': 'Building',
-     'name': 'Tour Eiffel',
+     'name': {
+       'type': 'Property',
+       'value': 'Tour Eiffel',
+     },
     'locatedAt': {
-       'id': 'urn:ngsi-ld:City:Paris',
-       'type': 'City',
+       'type': 'Relationship',
-       'description': 'Paris is the capital and largest city of France',
-       'name': 'Paris',
-       'isInCountry': 'urn:ngsi-ld:Country:France',
+       'object': 'urn:ngsi-ld:City:Paris',
     },
   },
 ]

```
- _(test also issued 8 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_30_01 Check That A Notification Is Sent With Inline Linked Entity And Selected Attributes
- **Requirement (doc):** Create an attribute in linking entity and check the notification contains linked entity with selected attributes
- **Spec clauses / tags:** 4_5_23, 5_8_6, since_v1.8.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:Building:046_30:EiffelTower']['name'] added to dictionary.
Item root['urn:ngsi-ld:Building:046_30:EiffelTower']['locatedAt']['entity'] removed from dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Building:046_30:EiffelTower',
     'type': 'Building',
     'locatedAt': {
       'type': 'Relationship',
       'object': 'urn:ngsi-ld:City:Paris',
-       'entity': {
-         'id': 'urn:ngsi-ld:City:Paris',
-         'type': 'City',
-         'description': {
-           'type': 'Property',
-           'value': 'Paris is the capital and largest city of France',
-         },
-         'name': {
-           'type': 'Property',
-           'value': 'Paris',
-         },
-         'isInCountry': {
-           'type': 'Relationship',
-           'object': 'urn:ngsi-ld:Country:France',
-         },
-       },
     },
+     'name': {
+       'type': 'Property',
+       'value': 'Tour Eiffel',
+     },
   },
 ]

```
- _(test also issued 8 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:City:Paris",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_32_01 Update Json Property And Check Previous Value In Notification
- **Requirement (doc):** Update the JsonProperty in the entity and check the notification contains the previous value
- **Spec clauses / tags:** 4_5_24, 5_8_6, show_changes, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:Building:046_32']['jsonProperty']['previousJson']['null'] removed from dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Building:046_32',
     'type': 'Building',
     'jsonProperty': {
       'type': 'JsonProperty',
       'json': {
         'city': 'Nantes',
         'street': 'Place Royale',
       },
       'previousJson': {
         'id': 'some-id',
-         'null': None,
         'type': 'some-type',
         'anythingElse': 'anything-else',
       },
     },
   },
 ]

```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:046_32",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:046_32",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_37_01 Delete Entity And Check Previous Values In Notification
- **Requirement (doc):** Delete an entity and check the notification contains the previous values for all attributes
- **Spec clauses / tags:** 4_5_18, 5_8_6, show_changes, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 204 != 500
  ```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:5949479067436726",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:5949479067436726",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_38_01 Delete Entity And Check Previous Values In Notification
- **Requirement (doc):** Delete an entity and check the notification contains the previous values for a JsonProperty
- **Spec clauses / tags:** 4_5_18, 4_5_24, 5_8_6, show_changes, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:Building:046_38']['jsonProperty']['previousJson'] removed from dictionary.
Type of root['urn:ngsi-ld:Building:046_38']['jsonProperty']['json'] changed from str to dict and value changed from "urn:ngsi-ld:null" to {'id': 'some-id', 'null': None, 'type': 'some-type', 'anythingElse': 'anything-else'}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Building:046_38',
     'type': 'Building',
-     'deletedAt': '2025-08-22T19:48:35.450282Z',
+     'deletedAt': '2026-06-26T11:38:14.230000Z',
     'jsonProperty': {
       'type': 'JsonProperty',
-       'previousJson': {
-         'id': 'some-id',
-         'null': None,
-         'type': 'some-type',
-         'anythingElse': 'anything-else',
-       },
-       'json': 'urn:ngsi-ld:null',
+       'json': {
+         'id': 'some-id',
+         'null': None,
+         'type': 'some-type',
+         'anythingElse': 'anything-else',
+       },
     },
   },
 ]

```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:4640479192343545",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:4640479192343545",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_39_01 Delete Entity And Check Previous Values In Notification
- **Requirement (doc):** Delete an entity and check the notification contains the previous values for a VocabProperty
- **Spec clauses / tags:** 4_5_18, 4_5_20, 5_8_6, show_changes, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:Building:046_39']['vocabProperty']['previousVocab'] removed from dictionary.
Value of root['urn:ngsi-ld:Building:046_39']['vocabProperty']['vocab'] changed from "urn:ngsi-ld:null" to "monument".
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Building:046_39',
     'type': 'Building',
-     'deletedAt': '2025-08-22T19:49:49.491466Z',
+     'deletedAt': '2026-06-26T11:38:14.820000Z',
     'vocabProperty': {
       'type': 'VocabProperty',
-       'previousVocab': 'monument',
-       'vocab': 'urn:ngsi-ld:null',
+       'vocab': 'monument',
     },
   },
 ]

```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:7445762481139207",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:7445762481139207",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 046_40_01 Create Entity And Check No Previous Value In Notification
- **Requirement (doc):** Create entity and check that notification has no previous value
- **Spec clauses / tags:** 5_8_6, show_changes, since_v1.6.1, sub-notification
- **What is wrong (expected vs actual):**

  ```
  Match found for parent $..previousValue: ['urn:ngsi-ld:null', 'urn:ngsi-ld:null', 'urn:ngsi-ld:null', 'urn:ngsi-ld:null']
  ```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:6925465918566812",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:6925465918566812",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 058_04_01 Basic Subscription
- **Spec clauses / tags:** 5_8_6, sub-mqtt-notification
- **What is wrong (expected vs actual):**

  ```
  ValueError: Argument 'dictionary' got value '[{'test-receiver-key': 'test-receiver-info'}]' (list) that cannot be converted to Mapping.
  ```
- _(test also issued 5 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:3484246590379329",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:3484246590379329",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```


## iop  (24 failing)

### IOP_CNF_01_01 Query Entities Of Type OffstreetParking Via GET
- **Requirement (doc):** Pre-conditions: no user context. Data only on leaves. B contains OffStreetParking1 and OffStreetParking2 without location and totalSpotsNumber. C contains OffStreetParking2.
Registrations established: Inclusive in A to B. Exclusive in A to C.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_2, 6_4_3_1, additive-inclusive, cf_06, iop, proxy-exclusive, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  '[][OffstreetParking1]' does not contain 'availableSpotsNumber'
  ```
- _(test also issued 15 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio3:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:5331311900002742",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio3:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:5331311900002742",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_01_01 Query Entities Of Type OffstreetParking Via POST
- **Requirement (doc):** Pre-conditions: no user context. Data only on leaves. B contains OffStreetParking1 and OffStreetParking2 without location and totalSpotsNumber. C contains OffStreetParking2.
Registrations established: Inclusive in A to B. Exclusive in A to C.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_2, 6_23_2_1, additive-inclusive, cf_06, iop, proxy-exclusive, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  '[{'id': 'urn:ngsi-ld:OffStreetParking:5285892375934213', 'type': 'https://ngsi-ld-test-suite/context#OffStreetParking', 'location': {'type': 'GeoProperty', 'value': {'type': 'Point', 'coordinates': [-8.45, 41.2]}}}][OffstreetParking1]' does not contain 'availableSpotsNumber'
  ```
- _(test also issued 15 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio3:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:5285892375934213",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio3:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:5285892375934213",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_02_01 Query Entities Of Type OffstreetParking Via GET
- **Requirement (doc):** Pre-conditions: no user context. Data on every broker. B contains OffStreetParking1 without location and OffStreetParking2 without location. C contains OffStreetParking1 and OffStreetParking2. D contains OffStreetParking2 with location and name only.
Registrations established: Inclusive in A to B. Redirect in A to C. Redirect in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_2, 6_4_3_1, additive-inclusive, cf_06, iop, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  IndexError: Given index 0 is out of the range 0--1.
  ```
- _(test also issued 25 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:7596363978827303",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:7596363978827303",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_02_02 Query Entities Of Type OffstreetParking And Vehicle with attrs
- **Requirement (doc):** Pre-conditions: no user context. Data only on leaves. B contains OffStreetParking1 and Vehicle1. C contains OffStreetParking1 with location and name only and OffStreetParking2. D contains OffStreetParking2 with location and name only and Vehicle2.
Registrations established: Inclusive in A to B. Redirect in A to C. Redirect in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_2, 6_4_3_1, additive-inclusive, cf_06, iop, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  Dictionary does not contain key 'urn:ngsi-ld:OffStreetParking:4683599597627364'.
  ```
- _(test also issued 28 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:4724525866397768",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:4724525866397768",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_03_01 Query Entities Of Type OffstreetParking Via GET
- **Requirement (doc):** Pre-conditions: No user context. Data only on leaves. B contains OffStreetParking2 without location. C contains OffStreetParking1. D contains OffStreetParking1 without location.
Registration established: Auxiliary in A to B. Inclusive in A to C. Inclusive in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_2, 6_4_3_1, additive-auxiliary, additive-inclusive, cf_06, iop, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  Dictionary does not contain key 'OffstreetParking:1'.
  ```
- _(test also issued 15 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:2429877254588265",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:2429877254588265",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_03_02 Query Entities Of Type OffstreetParking And Vehicle with attrs
- **Requirement (doc):** Pre-conditions: No user context. Data only on leaves. B contains Vehicle:1. C contains OffStreetParking:1 with location and name only. D contains OffStreetParking:1, OffStreetParking:2 and Vehicle2.
Registrations established: Auxiliary in A to B. Inclusive in A to C. Inclusive in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_2, 6_4_3_1, additive-auxiliary, additive-inclusive, cf_06, iop, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  Dictionary does not contain key 'OffstreetParking:1'.
  ```
- _(test also issued 25 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Vehicle:1650388856874309",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Vehicle:1650388856874309",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_04_01 Query Entities Of Type OffstreetParking Via GET
- **Requirement (doc):** Pre-conditions: No user context. Data only on leaves. D contains OffStreetParking:1 with location and name only and OffStreetParking:2. E contains OffStreetParking:1 and OffStreetParking:2 with location and name only.
Registrations established: Auxiliary in A to B and Inclusive in A to C. Redirect in B to D and Redirect in B to E. Exclusive in C to E.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_2, 6_4_3_1, additive-auxiliary, additive-inclusive, cf_06, iop, proxy-exclusive, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  Setup failed:
HTTP status code comparison failed with (expected, actual) ->: 201 != 409

Also teardown failed:
Several failures occurred:

1) Variable '${registration_id1}' not found.

2) Variable '${registration_id2}' not found.

3) Variable '${registration_id3}' not found.

4) Variable '${registration_id4}' not found.

5) Variable '${registration_id5}' not found.

6) Variable '${registration_id6}' not found.
  ```
- _(test also issued 9 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6779809482197951",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6779809482197951",
    "headers": {
        "content-length": "137",
        "Content-Type": "application/json"
    },
    "status_code": 404,
    "reason": "Not Found",
    "body": {
        "type": "https://uri.etsi.org/ngsi-ld/errors/ResourceNotFound",
        "title": "Resource not found.",
        "detail": "Resource not found.",
        "status": 404
    }
}
```

### IOP_CNF_04_02 Query Entities Of Type OffstreetParking Via POST
- **Requirement (doc):** Pre-conditions: No user context. Data only on leaves. D contains OffStreetParking:1 with location and name only and OffStreetParking2. E contains OffStreetParking:1 and OffStreetParking:2 with location and name only.
Registrations established: Auxiliary in A to B and Inclusive in A to C. Redirect in B to D and Redirect in B to E. Exclusive in C to E.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_2, 6_23_2_1, additive-auxiliary, additive-inclusive, cf_06, iop, proxy-exclusive, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  Setup failed:
HTTP status code comparison failed with (expected, actual) ->: 201 != 409

Also teardown failed:
Several failures occurred:

1) Variable '${registration_id1}' not found.

2) Variable '${registration_id2}' not found.

3) Variable '${registration_id3}' not found.

4) Variable '${registration_id4}' not found.

5) Variable '${registration_id5}' not found.

6) Variable '${registration_id6}' not found.
  ```
- _(test also issued 9 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:8247326407070008",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:8247326407070008",
    "headers": {
        "content-length": "137",
        "Content-Type": "application/json"
    },
    "status_code": 404,
    "reason": "Not Found",
    "body": {
        "type": "https://uri.etsi.org/ngsi-ld/errors/ResourceNotFound",
        "title": "Resource not found.",
        "detail": "Resource not found.",
        "status": 404
    }
}
```

### IOP_CNF_01_01 Retrieve OffStreetParking:1
- **Requirement (doc):** Pre-conditions: no user context. Data only on leaves. B contains OffStreetParking1 and OffStreetParking2. C contains OffStreetParking2.
Registrations established: Inclusive in A to B. Exclusive in A to C.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_1, additive-inclusive, cf_06, iop, proxy-exclusive, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 200 != 404
  ```
- _(test also issued 13 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio3:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3116827933516474",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio3:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3116827933516474",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_01_02 Retrieve OffStreetParking:2
- **Requirement (doc):** Pre-conditions: no user context. Data only on leaves. B contains OffStreetParking2 without location. C contains OffStreetParking2.
Registrations established: Inclusive in A to B. Exclusive in A to C.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_1, additive-inclusive, cf_06, iop, proxy-exclusive, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  Dictionary '${payload}' has no key 'availableSpotNumbers'.
  ```
- **Expected body (reference):**

```json
{'id': 'urn:ngsi-ld:OffStreetParking:4398985074532759', 'type': 'https://ngsi-ld-test-suite/context#OffStreetParking', 'https://ngsi-ld-test-suite/context#availableSpotsNumber': {'type': 'Property', '...
```
- _(test also issued 12 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio3:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:4398985074532759",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio3:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:4398985074532759",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_02_01 Retrieve OffStreetParking:1
- **Requirement (doc):** Pre-conditions: no user context. Data only on leaves. B contains OffStreetParking1 without location. C contains OffStreetParking1. D contains OffStreetParking2.
Registrations established: Inclusive in A to B. Redirect in A to C. Redirect in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_1, additive-inclusive, cf_06, iop, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 207 != 200
  ```
- _(test also issued 15 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:2358107930466729",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:2358107930466729",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_02_02 Retrieve OffStreetParking:1 Location Attribute
- **Requirement (doc):** Pre-conditions: no user context. Data only on leaves. B contains OffStreetParking1. C contains OffStreetParking1 with location and name only. D contains OffStreetParking2.
Registrations established: Inclusive in A to B. Redirect in A to C. Redirect in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_1, additive-inclusive, cf_06, iop, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 207 != 200
  ```
- _(test also issued 15 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:5646747162668685",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:5646747162668685",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_03_01 Retrieve OffStreetParking:1
- **Requirement (doc):** Pre-conditions: no user context. Data on every broker. A contains OffStreetParking1 without location. B contains OffStreetParking1. C contains OffStreetParking1 without location. D contains OffStreetParking2.
Registrations established: Auxiliary in A to B. Inclusive in A to C. Inclusive in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_1, additive-auxiliary, additive-inclusive, cf_06, iop, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 207 != 200
  ```
- _(test also issued 16 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3945843325979351",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3945843325979351",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_03_02 Retrieve OffStreetParking:1 Location Attribute
- **Requirement (doc):** Pre-conditions: no user context. Data on every broker. A contains OffStreetParking1 without location. B contains OffStreetParking1. C contains OffStreetParking1 with location and name only. D contains OffStreetParking1 without location.
Registrations established: Auxiliary in A to B. Inclusive in A to C. Inclusive in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_1, additive-auxiliary, additive-inclusive, cf_06, iop, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 207 != 200
  ```
- _(test also issued 16 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3071689201253347",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio4:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3071689201253347",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_04_01 Retrieve OffStreetParking:1
- **Requirement (doc):** Pre-conditions: no user context. Data only on leaves. D contains OffStreetParking1 without location. E contains OffStreetParking1.
Registrations established: Auxiliary in A to B and Inclusive in A to C. Redirect in B to D and Redirect in B to E. Exclusive in C to E.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_1, additive-auxiliary, additive-inclusive, cf_06, iop, proxy-exclusive, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 200 != 404
  ```
- _(test also issued 16 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6077798897909819",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6077798897909819",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_04_02 Retrieve OffStreetParking:1 Location Attribute
- **Requirement (doc):** Pre-conditions: no user context. Data on every broker. A contains OffStreetParking1 without location. B contains OffStreetParking1 without location. C contains OffStreetParking1 without location. D contains OffStreetParking1. E contains OffStreetParking1 with location and name only.
Registrations established: Auxiliary in A to B and  Inclusive in A to C. Redirect in B to D and Redirect in B to E. Exclusive in C to E.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_7_1, additive-auxiliary, additive-inclusive, cf_06, iop, proxy-exclusive, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  '{'id': 'urn:ngsi-ld:OffStreetParking:4865861596234288', 'type': 'https://ngsi-ld-test-suite/context#OffStreetParking', 'https://ngsi-ld-test-suite/context#availableSpotsNumber': {'type': 'Property', 'value': 169, 'observedAt': '2017-07-29T12:10:02Z', 'reliability': {'type': 'Property', 'value': 0.3}}, 'https://ngsi-ld-test-suite/context#name': {'type': 'Property', 'value': 'Downtown One'}, 'https://ngsi-ld-test-suite/context#totalSpotsNumber': {'type': 'Property', 'value': 200}}' does not contain 'location'
  ```
- _(test also issued 25 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:4865861596234288",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:4865861596234288",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_01_01 Create OffStreetParking:1
- **Requirement (doc):** Pre-conditions: No user context. No data in any broker.
Registrations established: Inclusive in A to B. Exclusive in A to C.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_6_1, additive-inclusive, cf_06, iop, proxy-exclusive, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  {'id': 'urn:ngsi-ld:OffStreetParking:3311117419046330', 'type': 'https://ngsi-ld-test-suite/context#OffStreetParking', 'https://ngsi-ld-test-suite/context#availableSpotsNumber': {'type': 'Property', 'value': 121, 'observedAt': '2017-07-29T12:05:02Z', 'reliability': {'type': 'Property', 'value': 0.7}}, 'https://ngsi-ld-test-suite/context#name': {'type': 'Property', 'value': 'Downtown One'}, 'https://ngsi-ld-test-suite/context#totalSpotsNumber': {'type': 'Property', 'value': 200}, 'location': {'type': 'GeoProperty', 'value': {'type': 'Point', 'coordinates': [-8.5, 41.2]}}} != {'id': 'urn:ngsi-ld:OffStreetParking:3311117419046330', 'type': 'OffStreetParking', 'name': {'type': 'Property', 'value': 'Downtown One'}, 'availableSpotsNumber': {'type': 'Property', 'value': 121, 'observedAt': '2017-07-29T12:05:02Z', 'reliability': {'type': 'Property', 'value': 0.7}}, 'totalSpotsNumber': {'type': 'Property', 'value': 200}, 'location': {'type': 'GeoProperty', 'value': {'type': 'Point', 'coordinates': [-8.5, 41.2]}}, '@context': [{'OffStreetParking': 'https://ngsi-ld-test-suite/context#OffStreetParking', 'Vehicle': 'https://ngsi-ld-test-suite/context#Vehicle', 'availableSpotsNumber': 'https://ngsi-ld-test-suite/context#availableSpotsNumber', 'brandName': 'https://ngsi-ld-test-suite/context#brandName', 'isParked': 'https://ngsi-ld-test-suite/context#isParked', 'name': 'https://ngsi-ld-test-suite/context#name', 'source': 'https://ngsi-ld-test-suite/context#source', 'speed': 'https://ngsi-ld-test-suite/context#speed', 'totalSpotsNumber': 'https://ngsi-ld-test-suite/context#totalSpotsNumber'}, 'https://uri.etsi.org/ngsi-ld/v1/ngsi-ld-core-context-v1.6.jsonld']}
  ```
- **Expected body (reference):**

```json
{'id': 'urn:ngsi-ld:OffStreetParking:3311117419046330', 'type': 'OffStreetParking', 'name': {'type': 'Property', 'value': 'Downtown One'}, 'availableSpotsNumber': {'type': 'Property', 'value': 121, 'o...
```
- _(test also issued 7 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3311117419046330",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3311117419046330",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_01_02 Create OffStreetParking:2
- **Requirement (doc):** Pre-conditions: No user context. No data in any broker.
Registrations established: Inclusive in A to B. Exclusive in A to C.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_6_1, additive-inclusive, cf_06, iop, proxy-exclusive, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  '{'id': 'urn:ngsi-ld:OffStreetParking:1788578200730538', 'type': 'https://ngsi-ld-test-suite/context#OffStreetParking', 'https://ngsi-ld-test-suite/context#availableSpotsNumber': {'type': 'Property', 'value': 112, 'observedAt': '2017-07-29T12:05:02Z', 'reliability': {'type': 'Property', 'value': 0.4}}, 'https://ngsi-ld-test-suite/context#name': {'type': 'Property', 'value': 'Downtown Two'}, 'https://ngsi-ld-test-suite/context#totalSpotsNumber': {'type': 'Property', 'value': 150}, 'location': {'type': 'GeoProperty', 'value': {'type': 'Point', 'coordinates': [-8.45, 41.2]}}}' contains 'location'
  ```
- _(test also issued 7 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:1788578200730538",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:1788578200730538",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_02_01 Create OffStreetParking:1
- **Requirement (doc):** Pre-conditions: No user context. No data in any broker.
Registrations established: Inclusive in A to B. Redirect in A to C. Redirect in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_6_1, additive-inclusive, cf_06, iop, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  '{'id': 'urn:ngsi-ld:OffStreetParking:6431033295548531', 'type': 'https://ngsi-ld-test-suite/context#OffStreetParking', 'https://ngsi-ld-test-suite/context#availableSpotsNumber': {'type': 'Property', 'value': 121, 'observedAt': '2017-07-29T12:05:02Z', 'reliability': {'type': 'Property', 'value': 0.7}}, 'https://ngsi-ld-test-suite/context#name': {'type': 'Property', 'value': 'Downtown One'}, 'https://ngsi-ld-test-suite/context#totalSpotsNumber': {'type': 'Property', 'value': 200}, 'location': {'type': 'GeoProperty', 'value': {'type': 'Point', 'coordinates': [-8.5, 41.2]}}}' contains 'location'
  ```
- _(test also issued 9 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6431033295548531",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6431033295548531",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_02_02 Create OffStreetParking:2
- **Requirement (doc):** Pre-conditions: No user context. No data in any broker.
Registrations established: Inclusive in A to B. Redirect in A to C. Redirect in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_6_1, additive-inclusive, cf_06, iop, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 200 != 404
  ```
- _(test also issued 10 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3070497264580575",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:3070497264580575",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_03_01 Create OffStreetParking:1
- **Requirement (doc):** Pre-conditions: No user context. No data in any broker.
Registrations established: Auxiliary in A to B. Inclusive in A to C. Inclusive in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_6_1, additive-auxiliary, additive-inclusive, cf_06, iop, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  Resolving variable '${response.json()}' failed: JSONDecodeError: Expecting value: line 1 column 1 (char 0)
  ```
- _(test also issued 8 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6591286022431982",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6591286022431982",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_03_02 Create Partial OffStreetParking:1
- **Requirement (doc):** Pre-conditions: No user context. No data in any broker.
Registrations established: Auxiliary in A to B. Inclusive in A to C. Inclusive in A to D.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_6_1, additive-auxiliary, additive-inclusive, cf_06, iop, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  Resolving variable '${response.json()}' failed: JSONDecodeError: Expecting value: line 1 column 1 (char 0)
  ```
- _(test also issued 8 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:0764962718337934",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:0764962718337934",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_04_01 Create OffStreetParking:1
- **Requirement (doc):** Pre-conditions: No user context. No data in any broker.
Registrations established: Auxiliary in A to B. Inclusive in A to C. Redirect in B to D. Redirect in B to E. Exclusive in C to E.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_6_1, additive-auxiliary, additive-inclusive, cf_06, iop, proxy-exclusive, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 200 != 404
  ```
- _(test also issued 15 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6294751432274397",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio1:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:6294751432274397",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### IOP_CNF_04_02 Create OffStreetParking:2
- **Requirement (doc):** Pre-conditions: No user context. No data in any broker.
Registrations established: Auxiliary in A to B. Inclusive in A to C. Redirect in B to D. Redirect in B to E. Exclusive in C to E.
- **Spec clauses / tags:** 4_3_3, 4_3_6, 5_6_1, additive-auxiliary, additive-inclusive, cf_06, iop, proxy-exclusive, proxy-redirect, since_v1.6.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 200 != 404
  ```
- _(test also issued 19 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:7072916156231010",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Length": "0"
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://scorpio5:9090/ngsi-ld/v1/entities/urn:ngsi-ld:OffStreetParking:7072916156231010",
    "headers": {
        "content-length": "137",
        "Content-Type": "application/json"
    },
    "status_code": 404,
    "reason": "Not Found",
    "body": {
        "type": "https://uri.etsi.org/ngsi-ld/errors/ResourceNotFound",
        "title": "Resource not found.",
        "detail": "Resource not found.",
        "status": 404
    }
}
```


---
**Total failing tests: 97**
