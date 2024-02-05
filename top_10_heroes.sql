select distinct(eksami_sooritaja), seisund,count(seisund) as total_failed, kategooria
from exams
where seisund = 'MITTE_SOORITATUD'
group by eksami_sooritaja,seisund,kategooria
order by total_failed desc
limit 10