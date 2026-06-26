#!/bin/bash
# Truncate all NGSI-LD data tables across every schema (tenant-safe). ponytail: one DO block.
sudo docker exec scorpio-dev-postgres psql -U ngb -d ngb -q -c "
DO \$\$ DECLARE r RECORD; BEGIN
  FOR r IN SELECT schemaname, tablename FROM pg_tables
    WHERE tablename IN ('entity','temporalentity','temporalentityattrinstance','entitymap',
                        'csource','csourceinformation','subscriptions','registry_subscriptions') LOOP
    EXECUTE 'TRUNCATE TABLE '||quote_ident(r.schemaname)||'.'||quote_ident(r.tablename)||' CASCADE';
  END LOOP;
END \$\$;" 2>&1 | grep -v '^$'
