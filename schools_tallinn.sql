DROP TABLE IF EXISTS category;

CREATE TEMPORARY TABLE category AS (
	SELECT
		sum(case when seisund = 'MITTE_SOORITATUD' then 1 else 0 end) as mitte_sooritatud_total,
		sum(case when seisund = 'SOORITATUD' then 1 else 0 end) as sooritatud_total,
		sum(CASE WHEN seisund in ('SOORITATUD','MITTE_SOORITATUD') THEN 1 ELSE 0 END) AS total_attempts,
		viimane_autokool,
		kategooria,
		byroo
	from 
		exams
	group by viimane_autokool,kategooria,byroo
);

Select kategooria, 
       CASE
	   	When total_attempts = 0 THEN 0
       	ELSE (sooritatud_total * 100.0 / total_attempts)
		END AS success,
	   viimane_autokool,
	   byroo
from category
where kategooria = 'B' and byroo = 'Tallinn' and total_attempts > 20
order by total_attempts desc;
