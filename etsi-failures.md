# ETSI NGSI-LD — Failing tests report

## ❌ Errors: 77   (✅ passing: 765)

| Suite | Pass | **Fail** |
|---|---|---|
| CommonBehaviours | 33 | **0** |
| Consumption-Discovery | 14 | **0** |
| Consumption-Entity | 189 | **1** |
| Consumption-TemporalEntity | 120 | **4** |
| ContextSource | 79 | **35** |
| Provision-BatchEntities | 58 | **0** |
| Provision-Entities | 55 | **0** |
| Provision-EntityAttributes | 86 | **2** |
| Provision-TemporalEntity | 11 | **0** |
| Provision-TemporalEntityAttributes | 32 | **1** |
| Subscription | 88 | **34** |
| **TOTAL** | **765** | **77** |

### Suites left out (no results)

- **DistributedOperations** — not run
- **jsonldContext** — left out — hangs ~30 min on an unreachable external @context server (053_05_01)

Below: only FAILED tests. Each entry has the requirement (spec clauses), what is wrong (expected vs actual), and the HTTP request/response under test.


## Consumption-Entity  (1 failing)

### 019_12_07 Filter Based On Attrs And datasetId With No Match
- **Spec clauses / tags:** 4_5_5, 5_7_2, e-query, since_v1.8.1
- **What is wrong (expected vs actual):**

  ```
  Resolving variable '${response.json()[0]}' failed: IndexError: list index out of range
  ```
- **Request under test:**

```json
{
    "method": "GET",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/?attrs=name&type=Building&datasetId=urn%3Angsi-ld%3ADataset%3Aspanish-name",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/?attrs=name&type=Building&datasetId=urn%3Angsi-ld%3ADataset%3Aspanish-name",
    "headers": {
        "content-length": "3",
        "Content-Type": "application/ld+json",
        "NGSILD-EntityMap": "ngsi-ld:scorpio:ignore"
    },
    "status_code": 200,
    "reason": "OK",
    "body": []
}
```


## Consumption-TemporalEntity  (4 failing)

### 021_21_03 QueryWithPickOnNonCoreMembers
- **Requirement (doc):** Check that one can query temporal entities with pick on core members
- **Spec clauses / tags:** 4_2_1, 5_7_4, since_v1.8.1, te-query
- **What is wrong (expected vs actual):**

  ```
  Value of root changed from {'urn:ngsi-ld:Bus:021-21-C': {}, 'urn:ngsi-ld:Vehicle:021-21-A': {}, 'urn:ngsi-ld:Vehicle:021-21-B': {}} to {}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
-   {
-     'id': 'urn:ngsi-ld:Bus:021-21-C',
-   },
-   {
-     'id': 'urn:ngsi-ld:Vehicle:021-21-A',
-   },
-   {
-     'id': 'urn:ngsi-ld:Vehicle:021-21-B',
-   },
 ]

```
- _(test also issued 6 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Bus:021-21-C",
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
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Bus:021-21-C",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

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
+         'instanceId': 'urn:ngsi-ld:Instance:665b0db0-c95a-4ec2-a92f-1e920d4dff5d',
       },
       {
         'type': 'Property',
-         'value': 67,
+         'value': 53,
-         'observedAt': '2020-08-01T12:03:00Z',
+         'observedAt': '2020-08-01T13:05:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:2b17427e-e72f-4699-84eb-33694e347f52',
       },
       {
         'type': 'Property',
-         'value': 53,
+         'value': 40,
-         'observedAt': '2020-08-01T13:05:00Z',
+         'observedAt': '2020-08-01T14:07:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:d9ea07e2-ea93-41d5-bc57-6b5a9110f91c',
       },
     ],
     'speed': [
       {
         'type': 'Property',
-         'value': 100,
+         'value': 120,
-         'observedAt': '2020-08-01T12:07:00Z',
+         'observedAt': '2020-08-01T12:03:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:3d3c248f-f7c3-406d-bda6-9fee28400672',
       },
       {
         'type': 'Property',
         'value': 80,
         'observedAt': '2020-08-01T12:05:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:b79c3d65-5c2e-4fcb-9aa5-90c9cdb7e95b',
       },
       {
         'type': 'Property',
-         'value': 120,
+         'value': 100,
-         'observedAt': '2020-08-01T12:03:00Z',
+         'observedAt': '2020-08-01T12:07:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:c8c043bd-7539-4dc5-8b77-3f116c08d109',
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
+         'instanceId': 'urn:ngsi-ld:Instance:dad46f1d-37ad-4df4-a377-909378d49318',
+       },
+       {
+         'type': 'Property',
+         'value': 53,
+         'observedAt': '2020-09-01T13:05:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:2d682d12-7084-4aee-8dcb-77edda08e81a',
+       },
+       {
+         'type': 'Property',
+         'value': 40,
+         'observedAt': '2020-09-01T14:07:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:16ef5542-6665-48a5-90e5-e47d593f2fd2',
+       },
+     ],
+     'speed': [
+       {
+         'type': 'Property',
+         'value': 120,
+         'observedAt': '2020-09-01T12:03:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:80daf70b-2a78-418b-98d5-db30a6ca5c1f',
+       },
+       {
+         'type': 'Property',
+         'value': 80,
+         'observedAt': '2020-09-01T12:05:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:1c211a75-0778-4b01-8616-5044b8bfa51f',
+       },
+       {
+         'type': 'Property',
+         'value': 100,
+         'observedAt': '2020-09-01T12:07:00Z',
+         'instanceId': 'urn:ngsi-ld:Instance:f694ada8-6c73-4744-b377-31e645920a48',
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
                    "instanceId": "urn:ngsi-ld:Instance:665b0db0-c95a-4ec2-a92f-1e920d4dff5d"
                },
                {
                    "type": "Property",
                    "value": 53,
                    "observedAt": "2020-08-01T13:05:00Z",
                    "instanceId": "urn:ngsi-ld:Instance:2b17427e-e72f-4699-84eb-33694e347f52"
                },
                {
                    "type": "Property",
                    "value": 40,
                    "observedAt": "2020-08-01T14:07:00Z",
                    "instanceId": "urn:ngsi-ld:Instance:d9ea07e2-ea93-41d5-bc57-6b5a9110f91c"
                }
            ],
            "speed": [
                {
                    "type": "Property",
                    "value": 120,
                    "observedAt": "2020-08-01T12:03:00Z",
                    "instanceId": "urn:ngsi-ld:Instance:3d3c248f-f7c3-406d-bda6-9fee28400672"
                },
                {
                    "type": "Property",
                    "value": 80,
                    "observedAt": "2020-08-01T12:05:00Z",
                    "instanceId": "urn:ngsi-ld:Instance:b79c3d65-5c2e-4fcb-9aa5-90c9cdb7e95b"
                },
                {
           
```

### 020_14_01 Retrieve An Entity With 60 Instances Of Unsynchronized Attributes
- **Spec clauses / tags:** 5_7_3, 6_3_10, since_v1.5.1, te-retrieve
- **What is wrong (expected vs actual):**

  ```
  '[{'type': 'Property', 'value': 1, 'observedAt': '2020-01-02T01:01:00Z', 'instanceId': 'urn:ngsi-ld:Instance:6277b6a0-d406-4f54-b9ef-481ab831e985'}, {'type': 'Property', 'value': 2, 'observedAt': '2020-01-02T01:02:00Z', 'instanceId': 'urn:ngsi-ld:Instance:d6cdbe25-c667-45ad-8c3f-e716758169b7'}, {'type': 'Property', 'value': 3, 'observedAt': '2020-01-02T01:03:00Z', 'instanceId': 'urn:ngsi-ld:Instance:e5ba0790-3619-47e0-b042-df1f1094d943'}, {'type': 'Property', 'value': 4, 'observedAt': '2020-01-02T01:04:00Z', 'instanceId': 'urn:ngsi-ld:Instance:65d0ee81-e57c-424b-b41a-6f4cd773f289'}, {'type': 'Property', 'value': 5, 'observedAt': '2020-01-02T01:05:00Z', 'instanceId': 'urn:ngsi-ld:Instance:2b82f2ff-c62b-4c70-b1f3-f0e2ea8f0c01'}, {'type': 'Property', 'value': 6, 'observedAt': '2020-01-02T01:06:00Z', 'instanceId': 'urn:ngsi-ld:Instance:f9024a05-be17-4982-8ede-5a87a2b1f46e'}, {'type': 'Property', 'value': 7, 'observedAt': '2020-01-02T01:07:00Z', 'instanceId': 'urn:ngsi-ld:Instance:87a69238-6c54-4a72-8163-d3de52590161'}, {'type': 'Property', 'value': 8, 'observedAt': '2020-01-02T01:08:00Z', 'instanceId': 'urn:ngsi-ld:Instance:d4eb77c4-aaa8-495b-be07-f00f41467fda'}, {'type': 'Property', 'value': 9, 'observedAt': '2020-01-02T01:09:00Z', 'instanceId': 'urn:ngsi-ld:Instance:fcd3b145-2ccd-40c0-9ebe-f459ffe04032'}, {'type': 'Property', 'value': 10, 'observedAt': '2020-01-02T01:10:00Z', 'instanceId': 'urn:ngsi-ld:Instance:0915a5a6-f0f4-4521-9d85-4a716205f9ee'}, {'type': 'Property', 'value': 11, 'observedAt': '2020-01-02T01:11:00Z', 'instanceId'...
    [ Message content over the limit has been removed. ]
...rn:ngsi-ld:Instance:a2b342b7-70b6-45d1-a7ed-ab0135ab0344'}, {'type': 'Property', 'value': 50, 'observedAt': '2020-01-02T01:50:00Z', 'instanceId': 'urn:ngsi-ld:Instance:52a4c810-15cf-43e5-b7d9-2caa2647dfed'}, {'type': 'Property', 'value': 51, 'observedAt': '2020-01-02T01:51:00Z', 'instanceId': 'urn:ngsi-ld:Instance:8309b947-6bce-4d1c-bb9a-e40e2cf6b217'}, {'type': 'Property', 'value': 52, 'observedAt': '2020-01-02T01:52:00Z', 'instanceId': 'urn:ngsi-ld:Instance:788b850f-a47a-42cd-aa5c-7de7ad629700'}, {'type': 'Property', 'value': 53, 'observedAt': '2020-01-02T01:53:00Z', 'instanceId': 'urn:ngsi-ld:Instance:ea4e12ee-16ce-4f00-b02f-0209f3e98455'}, {'type': 'Property', 'value': 54, 'observedAt': '2020-01-02T01:54:00Z', 'instanceId': 'urn:ngsi-ld:Instance:5a93560d-32b8-4f07-9ccc-0951119dcd0a'}, {'type': 'Property', 'value': 55, 'observedAt': '2020-01-02T01:55:00Z', 'instanceId': 'urn:ngsi-ld:Instance:242c6c4f-cd8c-4448-9113-09cf25f8f623'}, {'type': 'Property', 'value': 56, 'observedAt': '2020-01-02T01:56:00Z', 'instanceId': 'urn:ngsi-ld:Instance:9e3c7475-2cc9-4576-8970-128bfd48e4d6'}, {'type': 'Property', 'value': 57, 'observedAt': '2020-01-02T01:57:00Z', 'instanceId': 'urn:ngsi-ld:Instance:b8afdc4a-77e7-412c-865b-deaa22770aee'}, {'type': 'Property', 'value': 58, 'observedAt': '2020-01-02T01:58:00Z', 'instanceId': 'urn:ngsi-ld:Instance:6cfde749-bbe8-4060-be9c-95c916fda27b'}, {'type': 'Property', 'value': 59, 'observedAt': '2020-01-02T01:59:00Z', 'instanceId': 'urn:ngsi-ld:Instance:4a47ff9d-d36f-43c0-bb6e-cc2ec67497c1'}]' should be empty.
  ```
- **Request under test:**

```json
{
    "method": "GET",
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Vehicle:0557771416183912?timerel=after&timeAt=2019-01-01T01%3A01%3A00Z",
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
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Vehicle:0557771416183912?timerel=after&timeAt=2019-01-01T01%3A01%3A00Z",
    "headers": {
        "transfer-encoding": "chunked",
        "Content-Range": "date-time 2019-01-01T01:01:00Z-2020-01-02T01:59:00Z/*",
        "Content-Type": "application/json",
        "Link": "<https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\""
    },
    "status_code": 206,
    "reason": "Partial Content",
    "body": {
        "id": "urn:ngsi-ld:Vehicle:0557771416183912",
        "type": "Vehicle",
        "fuelLevel": [
            {
                "type": "Property",
                "value": 1,
                "observedAt": "2020-01-02T01:01:00Z",
                "instanceId": "urn:ngsi-ld:Instance:6277b6a0-d406-4f54-b9ef-481ab831e985"
            },
            {
                "type": "Property",
                "value": 2,
                "observedAt": "2020-01-02T01:02:00Z",
                "instanceId": "urn:ngsi-ld:Instance:d6cdbe25-c667-45ad-8c3f-e716758169b7"
            },
            {
                "type": "Property",
                "value": 3,
                "observedAt": "2020-01-02T01:03:00Z",
                "instanceId": "urn:ngsi-ld:Instance:e5ba0790-3619-47e0-b042-df1f1094d943"
            },
            {
                "type": "Property",
                "value": 4,
                "observedAt": "2020-01-02T01:04:00Z",
                "instanceId": "urn:ngsi-ld:Instance:65d0ee81-e57c-424b-b41a-6f4cd773f289"
            },
            {
                "type": "Property",
                "value": 5,
                "observedAt": "2020-01-02T01:05:00Z",
                "instanceId": "urn:ngsi-ld:Instance:2b82f2ff-c62b-4c70-b1f3-f0e2ea8f0c01"
            },
            {
                "type": "Property",
                "value": 6,
 
```

### 020_14_02 Retrieve The Entity With lastN
- **Spec clauses / tags:** 5_7_3, 6_3_10, since_v1.5.1, te-retrieve
- **What is wrong (expected vs actual):**

  ```
  '[{'type': 'Property', 'value': 59, 'observedAt': '2020-01-01T01:59:00Z', 'instanceId': 'urn:ngsi-ld:Instance:056231a1-8321-4418-9fa4-1ccd0965252e'}, {'type': 'Property', 'value': 58, 'observedAt': '2020-01-01T01:58:00Z', 'instanceId': 'urn:ngsi-ld:Instance:56fa3a08-b1cd-4e03-b842-7ace52dae719'}, {'type': 'Property', 'value': 57, 'observedAt': '2020-01-01T01:57:00Z', 'instanceId': 'urn:ngsi-ld:Instance:9e9253b3-23f6-482f-b2de-5bb32d8cb37b'}, {'type': 'Property', 'value': 56, 'observedAt': '2020-01-01T01:56:00Z', 'instanceId': 'urn:ngsi-ld:Instance:24b9976b-92f6-4261-9c35-428dc33f4d9c'}, {'type': 'Property', 'value': 55, 'observedAt': '2020-01-01T01:55:00Z', 'instanceId': 'urn:ngsi-ld:Instance:e6c7657b-20c5-477b-a1ac-bb6686d6e9fa'}, {'type': 'Property', 'value': 54, 'observedAt': '2020-01-01T01:54:00Z', 'instanceId': 'urn:ngsi-ld:Instance:ef1fe7b9-70fb-4063-a421-7eb0aa6e7dac'}, {'type': 'Property', 'value': 53, 'observedAt': '2020-01-01T01:53:00Z', 'instanceId': 'urn:ngsi-ld:Instance:c446a609-621d-40d1-a28b-149d9346567e'}, {'type': 'Property', 'value': 52, 'observedAt': '2020-01-01T01:52:00Z', 'instanceId': 'urn:ngsi-ld:Instance:fb9f9955-3c8b-48d0-a1d9-9c647326b2d3'}, {'type': 'Property', 'value': 51, 'observedAt': '2020-01-01T01:51:00Z', 'instanceId': 'urn:ngsi-ld:Instance:bbd22f18-588d-4dc7-b225-dcf39d4448d6'}, {'type': 'Property', 'value': 50, 'observedAt': '2020-01-01T01:50:00Z', 'instanceId': 'urn:ngsi-ld:Instance:a71053a2-b109-4261-a551-9ec3f0596c32'}, {'type': 'Property', 'value': 49, 'observedAt': '2020-01-01T01:49:00Z', 'in...
    [ Message content over the limit has been removed. ]
...ceId': 'urn:ngsi-ld:Instance:275c280d-0bc8-4eb4-beb5-7e7e5f4960fe'}, {'type': 'Property', 'value': 10, 'observedAt': '2020-01-01T01:10:00Z', 'instanceId': 'urn:ngsi-ld:Instance:f5c50bf9-37ff-4909-895d-45daddf3389b'}, {'type': 'Property', 'value': 9, 'observedAt': '2020-01-01T01:09:00Z', 'instanceId': 'urn:ngsi-ld:Instance:8ab048ca-4e71-4da7-8bb6-eb7842d1738e'}, {'type': 'Property', 'value': 8, 'observedAt': '2020-01-01T01:08:00Z', 'instanceId': 'urn:ngsi-ld:Instance:cb45cf6b-8cb8-46fc-a7e3-388042fb6484'}, {'type': 'Property', 'value': 7, 'observedAt': '2020-01-01T01:07:00Z', 'instanceId': 'urn:ngsi-ld:Instance:6fdeba52-71bd-413e-bfe6-fb58e7660903'}, {'type': 'Property', 'value': 6, 'observedAt': '2020-01-01T01:06:00Z', 'instanceId': 'urn:ngsi-ld:Instance:45a774d3-7cb4-47f5-8c8c-71fc596c1148'}, {'type': 'Property', 'value': 5, 'observedAt': '2020-01-01T01:05:00Z', 'instanceId': 'urn:ngsi-ld:Instance:356a0379-9802-41ba-87aa-7a0f730ab4ea'}, {'type': 'Property', 'value': 4, 'observedAt': '2020-01-01T01:04:00Z', 'instanceId': 'urn:ngsi-ld:Instance:4e425327-1d99-49e9-9495-6f4735ce2ef9'}, {'type': 'Property', 'value': 3, 'observedAt': '2020-01-01T01:03:00Z', 'instanceId': 'urn:ngsi-ld:Instance:3d9a6679-4ac5-491e-be49-0ba8f745a836'}, {'type': 'Property', 'value': 2, 'observedAt': '2020-01-01T01:02:00Z', 'instanceId': 'urn:ngsi-ld:Instance:56764ae0-f49d-45bd-a50d-3497ef000453'}, {'type': 'Property', 'value': 1, 'observedAt': '2020-01-01T01:01:00Z', 'instanceId': 'urn:ngsi-ld:Instance:87120d1e-60df-4a58-957e-f47d7787aa0d'}]' should be empty.
  ```
- **Request under test:**

```json
{
    "method": "GET",
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Vehicle:0557771416183912?timerel=before&timeAt=2021-01-01T01%3A01%3A00Z&lastN=100",
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
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Vehicle:0557771416183912?timerel=before&timeAt=2021-01-01T01%3A01%3A00Z&lastN=100",
    "headers": {
        "transfer-encoding": "chunked",
        "Content-Range": "date-time 2021-01-01T01:01:00Z-2020-01-01T01:01:00Z/100",
        "Content-Type": "application/json",
        "Link": "<https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\""
    },
    "status_code": 206,
    "reason": "Partial Content",
    "body": {
        "id": "urn:ngsi-ld:Vehicle:0557771416183912",
        "type": "Vehicle",
        "fuelLevel": [
            {
                "type": "Property",
                "value": 59,
                "observedAt": "2020-01-02T01:59:00Z",
                "instanceId": "urn:ngsi-ld:Instance:4a47ff9d-d36f-43c0-bb6e-cc2ec67497c1"
            },
            {
                "type": "Property",
                "value": 58,
                "observedAt": "2020-01-02T01:58:00Z",
                "instanceId": "urn:ngsi-ld:Instance:6cfde749-bbe8-4060-be9c-95c916fda27b"
            },
            {
                "type": "Property",
                "value": 57,
                "observedAt": "2020-01-02T01:57:00Z",
                "instanceId": "urn:ngsi-ld:Instance:b8afdc4a-77e7-412c-865b-deaa22770aee"
            },
            {
                "type": "Property",
                "value": 56,
                "observedAt": "2020-01-02T01:56:00Z",
                "instanceId": "urn:ngsi-ld:Instance:9e3c7475-2cc9-4576-8970-128bfd48e4d6"
            },
            {
                "type": "Property",
                "value": 55,
                "observedAt": "2020-01-02T01:55:00Z",
                "instanceId": "urn:ngsi-ld:Instance:242c6c4f-cd8c-4448-9113-09cf25f8f623"
            },
            {
                "type": "Property",
           
```


## ContextSource  (35 failing)

### 037_07_01 Near Point
- **Spec clauses / tags:** 5_10_2, csr-query
- **What is wrong (expected vs actual):**

  ```
  Item root['urn:ngsi-ld:ContextSourceRegistration:0313769466114834']['location']['coordinates'] added to dictionary.
Item root['urn:ngsi-ld:ContextSourceRegistration:0313769466114834']['location']['value'] removed from dictionary.
Value of root['urn:ngsi-ld:ContextSourceRegistration:0313769466114834']['location']['type'] changed from "GeoProperty" to "Point".
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:ContextSourceRegistration:0313769466114834',
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:0313769466114834",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:0313769466114834",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:1215863907838239",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:1215863907838239",
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
  Value of root changed from {'urn:ngsi-ld:ContextSourceRegistration:8672743031273700,urn:ngsi-ld:ContextSourceRegistration:2664087280447813': {'type': 'ContextSourceRegistration', 'information': [{'entities': [{'type': 'Building'}]}], 'endpoint': 'http://my.csource.org:1026'}, 'urn:ngsi-ld:ContextSourceRegistration:randomUUID': {'type': 'ContextSourceRegistration', 'information': [{'entities': [{'type': 'Building'}]}], 'location': {'type': 'Point', 'coordinates': [-8.521, 41.2]}, 'endpoint': 'http://my.csource.org:1026', 'csourceProperty1': 'aValue', 'csourceProperty2': 'anotherValue', '@context': ['https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld']}} to {'urn:ngsi-ld:ContextSourceRegistration:2664087280447813': {'type': 'ContextSourceRegistration', 'csourceProperty1': 'aValue', 'csourceProperty2': 'anotherValue', 'endpoint': 'http://my.csource.org:1026', 'information': [{'entities': [{'type': 'Building'}]}]}, 'urn:ngsi-ld:ContextSourceRegistration:9447932192878593': {'type': 'ContextSourceRegistration', 'endpoint': 'http://my.csource.org:1026', 'information': [{'entities': [{'type': 'Building'}], 'propertyNames': ['name', 'subCategory'], 'relationshipNames': ['locatedAt']}]}}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
-     'id': 'urn:ngsi-ld:ContextSourceRegistration:8672743031273700,urn:ngsi-ld:ContextSourceRegistration:2664087280447813',
+     'id': 'urn:ngsi-ld:ContextSourceRegistration:2664087280447813',
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
+     'id': 'urn:ngsi-ld:ContextSourceRegistration:9447932192878593',
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:2664087280447813",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:2664087280447813",
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
  Item root['urn:ngsi-ld:ContextSourceRegistration:7413925106598125'] removed from dictionary.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
-   {
-     'id': 'urn:ngsi-ld:ContextSourceRegistration:7413925106598125',
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:7413925106598125",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:7413925106598125",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9652610375243954",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9652610375243954",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:1500992997449683",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:1500992997449683",
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
        "id": "urn:ngsi-ld:Subscription:7060527025836258",
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
        "Location": "/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:7060527025836258",
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
['urn:ngsi-ld:ContextSourceRegistration:0197205316748342']
```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:3146054688130938",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:3146054688130938",
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
  Timeout: request was not received.
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:1669479467027809",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:1669479467027809",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6513553374489618",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6513553374489618",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4782266156932541",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4782266156932541",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:0699907242604979",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:0699907242604979",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6270665461523127",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6270665461523127",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:1529300839764616",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:1529300839764616",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_10_01 Receive cSourceNotification For Matching Context Source Registrations On Observation Interval
- **Requirement (doc):** Check if a context source registration subscription defines temporalQ member with timeproperty observedAt, the temporal query is matched against the observationInterval of matching context source registrations
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:7274654332811659",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:7274654332811659",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_11_01 CreatedAt
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3118740443845679",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:3118740443845679",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_11_02 ModifiedAt
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9230999972947479",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:9230999972947479",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:0990757559662837",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:0990757559662837",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_13_01 Receive cSourceNotification For Matching Context Source Registrations On Any watchedAttribute
- **Requirement (doc):** Check if a context source registrations subscription does not define watchedAttributes member, a CsourceNotification will be triggered from context source registrations with information member matching all attributes of the described entities
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:9006590661606450",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:9006590661606450",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:7186937171207166",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:7186937171207166",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:3015172851276929",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:3015172851276929",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:8880547714446006",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:8880547714446006",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 047_16_02 MatchSecondContextSourceRegistration
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:2320951279524796",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:2320951279524796",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:5898149420366766",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceRegistrations/urn:ngsi-ld:ContextSourceRegistration:5898149420366766",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions//ngsi-ld/v1/csourceSubscriptions/urn:fc274a86-b79f-416a-bc42-ce18db2a184f",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions//ngsi-ld/v1/csourceSubscriptions/urn:fc274a86-b79f-416a-bc42-ce18db2a184f",
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

### 038_05_01 Create Context Source Registration Subscription With expiresAt Member
- **Requirement (doc):** Check that one can create a context source registration subscription with an expiresAt member and when it is due the status of the subscription changes to "expired"
- **Spec clauses / tags:** 5_11_2, csrsub-create
- **What is wrong (expected vs actual):**

  ```
  No keyword with name 'Get Current Date' found. Did you try using keyword 'RequestsLibrary.GET' and forgot to use enough whitespace between keyword and arguments?
  ```
- _(no Request/Response block logged for this test)_

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
        "id": "urn:ngsi-ld:Subscription:6984752860422211",
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
        "Location": "/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6984752860422211",
        "content-length": "0"
    },
    "status_code": 201,
    "reason": "Created",
    "body": null
}
```

### 042_02_01 Delete Context Source Registration Subscription With Invalid Uri
- **Requirement (doc):** Check that one cannot delete a context source registration subscription with an invalid URI
- **Spec clauses / tags:** 5_11_6, csrsub-delete
- **What is wrong (expected vs actual):**

  ```
  HTTPError: 400 Client Error: Bad Request for url: http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/invalidUri
  ```
- _(no Request/Response block logged for this test)_

### 042_03_01 Delete Unknown Context Source Registration Subscription With Invalid Uri
- **Requirement (doc):** Check that one cannot delete an unknown context source registration subscription
- **Spec clauses / tags:** 5_11_6, csrsub-delete
- **What is wrong (expected vs actual):**

  ```
  HTTPError: 404 Client Error: Not Found for url: http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:unknowSubscription
  ```
- _(no Request/Response block logged for this test)_

### 041_01_01 Query Context Source Registration Subscriptions
- **Requirement (doc):** Check that one can query context source registration subscriptions
- **Spec clauses / tags:** 5_11_5, csrsub-query
- **What is wrong (expected vs actual):**

  ```
  Item root[2] added to iterable.
Item root[3] added to iterable.
Value of root[0] changed from {'id': 'urn:ngsi-ld:Subscription:3326053617877007', 'type': 'Subscription', 'entities': [{'type': 'Building'}], 'notification': {'format': 'keyValues', 'endpoint': {'uri': 'http://localhost:1111/notify', 'accept': 'application/json'}}, 'status': 'active'} to {'id': 'urn:fc274a86-b79f-416a-bc42-ce18db2a184f', 'type': 'Subscription', 'entities': [{'type': 'Building'}], 'notification': {'endpoint': {'accept': 'application/json', 'uri': 'http://localhost:1111/notify'}, 'format': 'keyValues'}}.
Value of root[1] changed from {'id': 'urn:ngsi-ld:Subscription:4655986718578698', 'type': 'Subscription', 'watchedAttributes': ['name', 'subCategory'], 'entities': [{'type': 'Building'}], 'notification': {'format': 'keyValues', 'endpoint': {'uri': 'http://localhost:1111/notify', 'accept': 'application/json'}}, 'status': 'active'} to {'id': 'urn:ngsi-ld:Subscription:6984752860422211', 'type': 'Subscription', 'entities': [{'type': 'Building'}], 'notification': {'endpoint': {'accept': 'application/json', 'uri': 'http://localhost:1111/notify'}, 'format': 'keyValues'}, 'q': 'invalidQuery'}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
-     'id': 'urn:ngsi-ld:Subscription:3326053617877007',
+     'id': 'urn:fc274a86-b79f-416a-bc42-ce18db2a184f',
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
-     'id': 'urn:ngsi-ld:Subscription:4655986718578698',
+     'id': 'urn:ngsi-ld:Subscription:6984752860422211',
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
+     'id': 'urn:ngsi-ld:Subscription:3326053617877007',
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
+     'id': 'urn:ngsi-ld:Subscription:4655986718578698',
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4655986718578698",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:4655986718578698",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:2942607304284084",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:2942607304284084",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6485110984856212",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:6485110984856212",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:8002232613042912",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:8002232613042912",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5039811698076133",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:5039811698076133",
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
   'id': 'urn:ngsi-ld:Subscription:9358059347825210',
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:9358059347825210",
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
    "url": "http://localhost:9090/ngsi-ld/v1/csourceSubscriptions/urn:ngsi-ld:Subscription:9358059347825210",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```


## Provision-EntityAttributes  (2 failing)

### 010_07_01 Append Scope To An Entity With Overwrite Disabled
- **Requirement (doc):** Check that scope is appended if overwrite is disabled
- **Spec clauses / tags:** 4_18, 5_6_3, ea-append, since_v1.5.1
- **What is wrong (expected vs actual):**

  ```
  Type of root['scope'] changed from list to str and value changed from ['/Madrid/Gardens/ParqueNorte', '/CompanyA/OrganizationB/UnitC'] to "/CompanyA/OrganizationB/UnitC".
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 {
   'id': 'urn:ngsi-ld:Vehicle:8664822007193974',
   'type': 'Building',
-   'scope': [
-     '/Madrid/Gardens/ParqueNorte',
-     '/CompanyA/OrganizationB/UnitC',
-   ],
+   'scope': '/CompanyA/OrganizationB/UnitC',
 }

```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Vehicle:8664822007193974",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Vehicle:8664822007193974",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 011_05_02 Update Scope To An Entity Not Having A Scope
- **Requirement (doc):** Check that scope is not added if entity does not already have a scope
- **Spec clauses / tags:** 4_18, 5_6_2, ea-append, since_v1.5.1
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 207 != 204
  ```
- _(test also issued 3 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Vehicle:0823048038508805",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Vehicle:0823048038508805",
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
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Vehicle:1322059255305978",
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
    "url": "http://localhost:9090/ngsi-ld/v1/temporal/entities/urn:ngsi-ld:Vehicle:1322059255305978",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```


## Subscription  (34 failing)

### 028_06 Create A Subscription With A datasetId
- **Requirement (doc):** Check that one can create a subscription with a datasetId
- **Spec clauses / tags:** 4_5_5, 5_8_1, since_v1.8.1, sub-create
- **What is wrong (expected vs actual):**

  ```
  Item root['jsonldContext'] added to dictionary.
Item root['notification']['timesFailed'] added to dictionary.
Item root['notification']['timesSent'] added to dictionary.
Item root['notificationTrigger'] removed from dictionary.
Type of root['datasetId'] changed from list to str and value changed from ['urn:ngsi-ld:Dataset:french-name'] to "urn:ngsi-ld:Dataset:french-name".
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 {
   'id': 'urn:ngsi-ld:Subscription:3784739972581132',
   'type': 'Subscription',
   'entities': [
     {
       'type': 'Building',
     },
   ],
-   'notificationTrigger': [
-     'attributeCreated',
-     'attributeUpdated',
-   ],
   'notification': {
     'format': 'normalized',
     'endpoint': {
       'uri': 'http://localhost:1111/notify',
       'accept': 'application/ld+json',
     },
+     'timesFailed': 0,
+     'timesSent': 0,
   },
-   'datasetId': [
-     'urn:ngsi-ld:Dataset:french-name',
-   ],
+   'datasetId': 'urn:ngsi-ld:Dataset:french-name',
   'status': 'active',
   '@context': [
     'https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld',
   ],
+   'jsonldContext': 'http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf',
 }

```
- _(test also issued 1 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "GET",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:3784739972581132",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "application/ld+json",
        "Connection": "keep-alive",
        "Content-Type": "application/json",
        "Link": "<https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\""
    },
    "body": null
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:3784739972581132",
    "headers": {
        "content-length": "671",
        "Content-Type": "application/ld+json"
    },
    "status_code": 200,
    "reason": "OK",
    "body": {
        "id": "urn:ngsi-ld:Subscription:3784739972581132",
        "type": "Subscription",
        "datasetId": "urn:ngsi-ld:Dataset:french-name",
        "jsonldContext": "http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf",
        "entities": [
            {
                "type": "Building"
            }
        ],
        "notification": {
            "endpoint": {
                "accept": "application/ld+json",
                "uri": "http://localhost:1111/notify"
            },
            "format": "normalized",
            "timesFailed": 0,
            "timesSent": 0
        },
        "status": "active",
        "@context": [
            "https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld"
        ]
    }
}
```

### 031_01_01 Query Subscriptions
- **Requirement (doc):** Check that one can query a list of subscriptions
- **Spec clauses / tags:** 5_8_4, sub-query
- **What is wrong (expected vs actual):**

  ```
  Value of root[1] changed from {'id': 'urn:ngsi-ld:Subscription:9721448678381004', 'type': 'Subscription', 'watchedAttributes': ['name', 'subCategory'], 'entities': [{'type': 'Building'}], 'notification': {'format': 'keyValues', 'endpoint': {'uri': 'http://localhost:1111/notify', 'accept': 'application/json'}}, 'status': 'active', 'notificationTrigger': ['attributeCreated', 'attributeUpdated']} to {'id': 'urn:ngsi-ld:Subscription:9721448678381004', 'type': 'Subscription', 'jsonldContext': 'http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf', 'entities': [{'type': 'Building'}], 'notification': {'endpoint': {'accept': 'application/json', 'uri': 'http://localhost:1111/notify'}, 'format': 'keyValues', 'timesFailed': 0, 'timesSent': 0}, 'watchedAttributes': ['name', 'subCategory'], 'status': 'active'}.
Value of root[0] changed from {'id': 'urn:ngsi-ld:Subscription:6576414065289333', 'type': 'Subscription', 'timeInterval': 5, 'entities': [{'type': 'Building'}], 'notification': {'format': 'keyValues', 'endpoint': {'uri': 'http://localhost:1111/notify', 'accept': 'application/json'}}, 'status': 'active', 'notificationTrigger': ['attributeCreated', 'attributeUpdated']} to {'id': 'urn:ngsi-ld:Subscription:6576414065289333', 'type': 'Subscription', 'jsonldContext': 'http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf', 'entities': [{'type': 'Building'}], 'notification': {'endpoint': {'accept': 'application/json', 'uri': 'http://localhost:1111/notify'}, 'format': 'keyValues', 'timesFailed': 0, 'timesSent': 0}, 'timeInterval': 5, 'status': 'active'}.
Value of root[2] changed from {'id': 'urn:ngsi-ld:Subscription:3616412826396738', 'type': 'Subscription', 'entities': [{'type': 'Building'}], 'notification': {'format': 'keyValues', 'endpoint': {'uri': 'http://localhost:1111/notify', 'accept': 'application/json'}}, 'isActive': False, 'status': 'paused', 'notificationTrigger': ['attributeCreated', 'attributeUpdated']} to {'id': 'urn:ngsi-ld:Subscription:3616412826396738', 'type': 'Subscription', 'jsonldContext': 'http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf', 'entities': [{'type': 'Building'}], 'isActive': False, 'notification': {'endpoint': {'accept': 'application/json', 'uri': 'http://localhost:1111/notify'}, 'format': 'keyValues', 'timesFailed': 0, 'timesSent': 0}, 'status': 'paused'}.
  ```
- **Expected vs actual body (`-` = expected reference, `+` = actual response):**

```diff
 [
   {
     'id': 'urn:ngsi-ld:Subscription:6576414065289333',
     'type': 'Subscription',
     'timeInterval': 5,
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
+       'timesFailed': 0,
+       'timesSent': 0,
     },
     'status': 'active',
-     'notificationTrigger': [
-       'attributeCreated',
-       'attributeUpdated',
-     ],
+     'jsonldContext': 'http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf',
   },
   {
     'id': 'urn:ngsi-ld:Subscription:9721448678381004',
     'type': 'Subscription',
     'watchedAttributes': [
       'name',
       'subCategory',
     ],
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
+       'timesFailed': 0,
+       'timesSent': 0,
     },
     'status': 'active',
-     'notificationTrigger': [
-       'attributeCreated',
-       'attributeUpdated',
-     ],
+     'jsonldContext': 'http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf',
   },
   {
     'id': 'urn:ngsi-ld:Subscription:3616412826396738',
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
+       'timesFailed': 0,
+       'timesSent': 0,
     },
     'isActive': False,
     'status': 'paused',
-     'notificationTrigger': [
-       'attributeCreated',
-       'attributeUpdated',
-     ],
+     'jsonldContext': 'http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf',
   },
 ]

```
- **Request under test:**

```json
{
    "method": "GET",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/",
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
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/",
    "headers": {
        "content-length": "1510",
        "Content-Type": "application/json",
        "Link": "<https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\""
    },
    "status_code": 200,
    "reason": "OK",
    "body": [
        {
            "id": "urn:ngsi-ld:Subscription:6576414065289333",
            "type": "Subscription",
            "jsonldContext": "http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf",
            "entities": [
                {
                    "type": "Building"
                }
            ],
            "notification": {
                "endpoint": {
                    "accept": "application/json",
                    "uri": "http://localhost:1111/notify"
                },
                "format": "keyValues",
                "timesFailed": 0,
                "timesSent": 0
            },
            "timeInterval": 5,
            "status": "active"
        },
        {
            "id": "urn:ngsi-ld:Subscription:9721448678381004",
            "type": "Subscription",
            "jsonldContext": "http://localhost:9090/ngsi-ld/v1/jsonldContexts/urn:2446be865c1dd0625cec49bbcd25aedf",
            "entities": [
                {
                    "type": "Building"
                }
            ],
            "notification": {
                "endpoint": {
                    "accept": "application/json",
                    "uri": "http://localhost:1111/notify"
                },
                "format": "keyValues",
                "timesFailed": 0,
                "timesSent": 0
            },
            "watchedAttributes": [
                "name",
                "subCategory"
            ],
            "status": "active"
        },
        {
            "id": "urn:ngsi-ld
```

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
        "id": "urn:ngsi-ld:Subscription:2686094900279482",
        "type": "Subscription",
        "timeInterval": 10,
        "entities": [
            {
                "type": "Building",
                "id": "urn:ngsi-ld:Building:0976045268501342"
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
        "Location": "/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:2686094900279482",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:5630427777914390/attrs/",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:5630427777914390/attrs/",
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
        "id": "urn:ngsi-ld:Building:0926898958747058",
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
        "Location": "/ngsi-ld/v1/entities/urn:ngsi-ld:Building:0926898958747058",
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
+   'id': 'urn:ngsi-ld:Building:9913711491745577',
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:9913711491745577/attrs/",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:9913711491745577/attrs/",
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
  Length of '{'id': 'urn:ngsi-ld:Building:None', 'type': 'Building', 'name': 'Eiffel Tower', 'subCategory': 'tourism', 'deletedAt': '2026-06-24T17:54:01.154000Z', 'location': {'type': 'Point', 'coordinates': [13.3986, 52.5547]}}' should be 3 but is 6.
  ```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:9794048591923686",
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
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:9794048591923686",
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
  HTTP status code comparison failed with (expected, actual) ->: 204 != 500
  ```
- _(test also issued 4 setup request(s) before this one)_
- **Request under test:**

```json
{
    "method": "DELETE",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:0565476597370855",
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
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:0565476597370855",
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
b'{\n  "id" : "notification:-6569025765244532016",\n  "type" : "Notification",\n  "subscriptionId" : "urn:ngsi-ld:Subscription:3906231682044178",\n  "notifiedAt" : "2026-06-24T17:54:03.074000Z",\n  "data" : [ {\n    "id" : "urn:ngsi-ld:Building:None",\n    "type" : "Building",\n    "airQualityLevel" : "urn:ngsi-ld:null",\n    "almostFull" : false,\n    "name" : "Eiffel Tower",\n    "subCategory" : "tourism"\n  } ]\n}'.
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
+     'createdAt': '2026-06-24T17:55:36.268000Z',
     'name': {
       'type': 'Property',
       'value': 'Tour Eiffel',
-       'createdAt': '2025-05-19T14:50:31.117947Z',
+       'createdAt': '2026-06-24T17:55:36.268000Z',
-       'modifiedAt': '2025-05-19T14:50:31.117947Z',
+       'modifiedAt': '2026-06-24T17:55:36.268000Z',
     },
-     'modifiedAt': '2025-05-19T14:50:31.117947Z',
+     'modifiedAt': '2026-06-24T17:55:36.268000Z',
     'locatedAt': {
       'type': 'Relationship',
-       'createdAt': '2025-05-19T14:50:30.958947Z',
+       'createdAt': '2026-06-24T17:55:36.222000Z',
       'object': 'urn:ngsi-ld:City:Paris',
-       'modifiedAt': '2025-05-19T14:50:30.958947Z',
+       'modifiedAt': '2026-06-24T17:55:36.222000Z',
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
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:6037006000455606",
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
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:6037006000455606",
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
+     'deletedAt': '2026-06-24T17:55:45.419000Z',
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
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:9777489182313746",
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
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:9777489182313746",
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
+     'deletedAt': '2026-06-24T17:55:46.009000Z',
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
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:7952612743598205",
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
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:7952612743598205",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:9387170614258302",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:9387170614258302",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:9491779240216259",
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
    "url": "http://localhost:9090/ngsi-ld/v1/entities/urn:ngsi-ld:Building:9491779240216259",
    "headers": {},
    "status_code": 204,
    "reason": "No Content",
    "body": null
}
```

### 029_05_02 Update Subscription With Term To Uri Expansion Without Context
- **Requirement (doc):** Check that one can update a subcription: Term to URI expansion of Attribute names shall be observed
- **Spec clauses / tags:** 5_8_2, sub-update
- **What is wrong (expected vs actual):**

  ```
  HTTP status code comparison failed with (expected, actual) ->: 204 != 500
  ```
- **Request under test:**

```json
{
    "method": "PATCH",
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:2019395475860925",
    "headers": {
        "User-Agent": "python-requests/2.34.2",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "*/*",
        "Connection": "keep-alive",
        "Content-Type": "application/json",
        "Link": "<https://forge.etsi.org/rep/cim/ngsi-ld-test-suite/-/raw/develop/resources/jsonld-contexts/ngsi-ld-test-suite-compound.jsonld>; rel=\"http://www.w3.org/ns/json-ld#context\"; type=\"application/ld+json\"",
        "Content-Length": "183"
    },
    "body": {
        "type": "Subscription",
        "entities": [
            {
                "type": "Vehicle"
            }
        ],
        "notification": {
            "format": "keyValues",
            "endpoint": {
                "uri": "http://localhost:1111/notify",
                "accept": "application/json"
            }
        }
    }
}
```
- **Actual response:**

```json
{
    "url": "http://localhost:9090/ngsi-ld/v1/subscriptions/urn:ngsi-ld:Subscription:2019395475860925",
    "headers": {
        "content-length": "196",
        "Content-Type": "application/json"
    },
    "status_code": 500,
    "reason": "Internal Server Error",
    "body": {
        "type": "https://uri.etsi.org/ngsi-ld/errors/InternalError",
        "title": "Internal error",
        "detail": "Cannot invoke \"java.util.Set.remove(Object)\" because \"activeSubsForRemote\" is null",
        "status": 500
    }
}
```


---
**Total failing tests: 77**



