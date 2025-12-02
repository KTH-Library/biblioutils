USE BIBCOUNT;

DROP TABLE IF EXISTS indics_macro;

SELECT c.Content_id, c.Content_type, c.Citation_topic, m.*
INTO indics_macro
FROM BIBMON.dbo.masterfile m
INNER JOIN BIBMET.dbo.Citation_topic c ON (c.UID = 'WOS:' + m.WebofScience_ID)
WHERE c.Content_type = 'macro'
  AND m.analysis_id = 0
  AND m.level = 0
  AND m.WebofScience_ID IS NOT NULL
  AND m.Publication_Type_WoS IN ('Article', 'Review')
  AND m.Publication_Year BETWEEN 2015 AND 2023

DROP TABLE IF EXISTS indics_meso;

SELECT c.Content_id, c.Content_type, c.Citation_topic, m.*
INTO indics_meso
FROM BIBMON.dbo.masterfile m
INNER JOIN BIBMET.dbo.Citation_topic c ON (c.UID = 'WOS:' + m.WebofScience_ID)
WHERE c.Content_type = 'meso'
  AND m.analysis_id = 0
  AND m.level = 0
  AND m.WebofScience_ID IS NOT NULL
  AND m.Publication_Type_WoS IN ('Article', 'Review')
  AND m.Publication_Year BETWEEN 2015 AND 2023

