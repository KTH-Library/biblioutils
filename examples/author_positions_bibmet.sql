USE BIBCOUNT;

DROP TABLE IF EXISTS KTH_author_position;
CREATE TABLE KTH_author_position
(
 UT varchar(15),
 first_author integer,
 last_author integer,
 corresponding_author integer,
 No_authors integer
);

WITH kthpubs AS
(
 SELECT DISTINCT UT FROM BIBMET.dbo.BestResAddr WHERE Unified_org_id = 8
),
flags AS
(
 SELECT
  kthpubs.UT,
  a.No_authors,
  CASE WHEN a.Seq_no = 1 AND braa.Unified_org_id = 8 THEN 1 ELSE 0 END AS fauth,
  CASE WHEN a.Seq_no = a.No_authors AND braa.Unified_org_id = 8 THEN 1 ELSE 0 END AS lauth,
  CASE WHEN a.Reprint = 'Y' AND braa.Unified_org_id = 8 THEN 1 ELSE 0 END AS cauth
 FROM kthpubs
 INNER JOIN BIBMET.dbo.BestResAddrAuthorid braa ON (braa.UT = kthpubs.UT)
 INNER JOIN BIBMET.dbo.Author a ON (a.Author_id = braa.Author_id)
)
INSERT INTO KTH_author_position (UT, first_author, last_author, corresponding_author, No_authors)
SELECT UT,  max(fauth) AS first_author, max(lauth) AS last_author, max(cauth) AS corresponding_author, No_authors
FROM flags
GROUP BY UT, No_authors;

