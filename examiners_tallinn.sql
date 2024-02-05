SELECT eksamineerija,
       sooritatud_count,
	   mitte_sooritatud_count,
	   total_attempts,
	   sooritatud_count / CAST(sooritatud_count + mitte_sooritatud_count AS float) * 100 as RATIO
FROM (
    SELECT eksamineerija,
           SUM(CASE WHEN seisund = 'SOORITATUD' THEN 1 ELSE 0 END) as sooritatud_count,
           SUM(CASE WHEN seisund = 'MITTE_SOORITATUD' THEN 1 ELSE 0 END) as mitte_sooritatud_count,	
           byroo,
		   SUM(CASE WHEN seisund IN ('SOORITATUD', 'MITTE_SOORITATUD') THEN 1 ELSE 0 END) as total_attempts,
		   kategooria
    FROM exams
    WHERE byroo = 'Tallinn' AND seisund NOT IN ('KATKESTATUD', 'EI_ILMUNUD_KOHALE') and kategooria = 'B' 
    GROUP BY eksamineerija, byroo,kategooria
) AS subquery
WHERE sooritatud_count > 20
ORDER by ratio desc