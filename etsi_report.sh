#!/bin/bash
# ponytail: run every ETSI suite locally, then emit a failures-only report.
#   ./etsi_report.sh            -> run all suites + build report
#   ./etsi_report.sh report     -> skip running, just (re)build report from existing results-*/
# Output: etsi-failures.md  (request, what's wrong, expected vs actual, requirements)
cd /workspace/ngsi-ld-test-suite

# name -> path (matches the CI matrix in ci-cd-github.yml). Full set per user request.
# jsonldContext can hang on an external context server (~30 min); run_suite's timeout caps it.
SUITES=(
  "CommonBehaviours:CommonBehaviours"
  "Consumption-Discovery:ContextInformation/Consumption/Discovery"
  "Consumption-Entity:ContextInformation/Consumption/Entity"
  "Consumption-TemporalEntity:ContextInformation/Consumption/TemporalEntity"
  "Provision-BatchEntities:ContextInformation/Provision/BatchEntities"
  "Provision-Entities:ContextInformation/Provision/Entities"
  "Provision-EntityAttributes:ContextInformation/Provision/EntityAttributes"
  "Provision-TemporalEntity:ContextInformation/Provision/TemporalEntity"
  "Provision-TemporalEntityAttributes:ContextInformation/Provision/TemporalEntityAttributes"
  "Subscription:ContextInformation/Subscription"
  "ContextSource:ContextSource"
  # "DistributedOperations:DistributedOperations"
  # "jsonldContext:jsonldContext"
)

if [ "$1" != "report" ]; then
  for s in "${SUITES[@]}"; do
    name="${s%%:*}"; path="${s##*:}"
    echo ">>> running $name"
    ./run_suite.sh "$name" "$path" "${2:-1200}"
  done
fi

python3 report_failures.py 'results-*/output.xml' etsi-failures.md
echo "Report: /workspace/ngsi-ld-test-suite/etsi-failures.md"
