CREATE OR REPLACE DIRECTORY mdBackup2 AS 'C:\Backup\oraBackup';

GRANT           READ,
                WRITE
ON DIRECTORY    mdBackup2
TO              scott
;