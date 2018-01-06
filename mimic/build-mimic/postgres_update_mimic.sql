-- This inserts emergency information as real stay
-- this is related to #16
-- apparently, when emergency, urgent, and all kind of admissions having a edregtime should be considered as a emergency
-- the datetime can be sometimes contain error or gaps 
-- this is due to different systems
DELETE FROM transfers WHERE row_id < 0;
INSERT INTO transfers (row_id, hadm_id, subject_id, curr_careunit, intime, outtime)
SELECT -1 * row_id -- demoniac trick to moove forward
     , hadm_id
     , subject_id
     , 'EMERGENCY' as curr_careunit
     , edregtime as intime
     , edouttime as outtime
  FROM admissions
 WHERE edregtime IS NOT NULL;
