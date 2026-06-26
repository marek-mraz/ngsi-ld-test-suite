#!/bin/bash
cd /workspace/ngsi-ld-test-suite
./run_suite.sh CommonBehaviours CommonBehaviours 600
./run_suite.sh Consumption-Entity ContextInformation/Consumption/Entity 1200
./run_suite.sh Consumption-TemporalEntity ContextInformation/Consumption/TemporalEntity 1200
echo VERIFY_DONE
