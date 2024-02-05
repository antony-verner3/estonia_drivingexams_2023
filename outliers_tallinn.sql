SELECT viimane_autokool, COUNT(DISTINCT eksami_sooritaja) AS total_eksami_sooritaja
FROM (
    SELECT viimane_autokool, eksami_sooritaja, COUNT(*) AS mitte_sooritatud_count
    FROM exams
    WHERE byroo = 'Tallinn' AND  seisund = 'MITTE_SOORITATUD' and kategooria = 'B'
    GROUP BY viimane_autokool, eksami_sooritaja
    HAVING COUNT(*) >= 4
) AS subquery
GROUP BY viimane_autokool
ORDER BY total_eksami_sooritaja desc ;