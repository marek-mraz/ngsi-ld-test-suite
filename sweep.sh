#!/bin/bash
cd /workspace/ngsi-ld-test-suite
declare -A P=(
 [CommonBehaviours]="CommonBehaviours"
 [Consumption-Discovery]="ContextInformation/Consumption/Discovery"
 [Consumption-Entity]="ContextInformation/Consumption/Entity"
 [Consumption-TemporalEntity]="ContextInformation/Consumption/TemporalEntity"
 [Provision-BatchEntities]="ContextInformation/Provision/BatchEntities"
 [Provision-Entities]="ContextInformation/Provision/Entities"
 [Provision-EntityAttributes]="ContextInformation/Provision/EntityAttributes"
 [Provision-TemporalEntity]="ContextInformation/Provision/TemporalEntity"
 [Provision-TemporalEntityAttributes]="ContextInformation/Provision/TemporalEntityAttributes"
 [Subscription]="ContextInformation/Subscription"
 [ContextSource]="ContextSource"
 [DistributedOperations]="DistributedOperations"
)
for k in CommonBehaviours Consumption-Discovery Consumption-Entity Consumption-TemporalEntity Provision-BatchEntities Provision-Entities Provision-EntityAttributes Provision-TemporalEntity Provision-TemporalEntityAttributes Subscription ContextSource DistributedOperations; do
  ./run_suite.sh "$k" "${P[$k]}" 1500
done
echo "SWEEP_DONE"
