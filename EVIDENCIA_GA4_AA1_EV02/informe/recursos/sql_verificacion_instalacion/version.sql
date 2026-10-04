set echo on linesize 160 pagesize 50
column banner_full format a80
select banner_full from v$version;
column instance_name format a10
column host_name format a14
column version_full format a12
select instance_name, host_name, version_full, status, database_status from v$instance;
column name format a8
select name, open_mode, log_mode, cdb from v$database;
column pdb_name format a10
select con_id, name as pdb_name, open_mode from v$pdbs;
exit
