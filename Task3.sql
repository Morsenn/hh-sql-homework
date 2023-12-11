WITH net_compensations AS (
  SELECT
    area_id,
    CASE WHEN compensation_gross
         THEN (compensation_from * 87) / 100
         ELSE compensation_from
    END
    AS net_compensation_from,
    CASE WHEN compensation_gross
         THEN (compensation_to * 87) / 100
         ELSE compensation_to
    END
    AS net_compensation_to
  FROM vacancies
)
SELECT
  area_id,
  AVG(net_compensation_from) AS average_compensation_from,
  AVG(net_compensation_to) AS average_compensation_to,
  AVG((net_compensation_from + net_compensation_to) / 2) AS average_of_average
FROM net_compensations
GROUP BY area_id
ORDER BY area_id ASC;
