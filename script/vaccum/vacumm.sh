#!/bin/bash
psql -c "VACUUM ANALYZE VERBOSE change_logs"
psql -c "VACUUM ANALYZE VERBOSE order_records"
