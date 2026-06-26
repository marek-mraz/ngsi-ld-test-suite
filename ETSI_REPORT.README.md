# Running the ETSI test report

Tooling to run the ETSI NGSI-LD suites against the local Scorpio broker (`:9090`)
and produce a **failures-only** report.

## Prerequisites
- Scorpio running on `http://localhost:9090` (start/restart with `../restart_scorpio.sh`).
- Postgres + Kafka deps up (`scorpio-dev-postgres`, `scorpio-dev-kafka`).
- Robot venv present at `.venv/` (already set up).
- `resources/variables.py` points `url` / `temporal_api_url` at `http://localhost:9090/ngsi-ld/v1`.

## Run everything + build the report
```bash
cd /workspace/ngsi-ld-test-suite
./etsi_report.sh
```
This runs all 12 suites (each one wipes the DB first via `clean_db.sh`), then writes
**`etsi-failures.md`**. Takes ~30–40 min (the two federation suites are slow).

Optional per-suite timeout in seconds (default 1200):
```bash
./etsi_report.sh "" 600
```

## Just rebuild the report from the last run (no re-run)
```bash
./etsi_report.sh report
```

## The report: `etsi-failures.md`
Starts with the **total error count** and a per-suite Pass/Fail table, then one entry per
failing test:
- **Requirement** — the test doc + spec clauses (tags, e.g. `6_3_10`).
- **What is wrong** — the assertion message (expected vs actual).
- **Request under test** — method, URL, headers, body that was sent.
- **Actual response** — status + body the broker returned.

## Suites run vs. left out
Of the 13 suites in the CI matrix, `etsi_report.sh` runs **12**:

| Suite | Run? | Why |
|---|---|---|
| CommonBehaviours | ✅ run | |
| Consumption-Discovery | ✅ run | |
| Consumption-Entity | ✅ run | |
| Consumption-TemporalEntity | ✅ run | |
| Provision-BatchEntities | ✅ run | |
| Provision-Entities | ✅ run | |
| Provision-EntityAttributes | ✅ run | |
| Provision-TemporalEntity | ✅ run | |
| Provision-TemporalEntityAttributes | ✅ run | |
| Subscription | ✅ run | timing-flaky ±2; MQTT tests need a broker not present here |
| ContextSource | ⚠️ run, mostly fails | needs peer brokers (single-broker env) |
| DistributedOperations | ⚠️ run, mostly fails | needs peer brokers (single-broker env) |
| **jsonldContext** | ❌ **left out** | hangs ~30 min on an unreachable external `@context` server (test `053_05_01`) |

To run `jsonldContext` anyway (only if that external context server is reachable):
```bash
./run_suite.sh jsonldContext jsonldContext 1200
```

## Notes
- Federation suites (`ContextSource`, `DistributedOperations`) are run but mostly fail here
  because this is a single-broker env; they need peer brokers.
- Run a single suite directly with `./run_suite.sh <name> <relpath> [timeout]`.
