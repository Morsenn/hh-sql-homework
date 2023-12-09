SELECT
  area_id AS area_id,
  AVG(compensation_from) AS average_compensation_from,
  AVG(compensation_to) AS average_compensation_to,
  AVG((compensation_from + compensation_to) / 2) AS average_of_average
FROM vacancies
GROUP BY area_id
ORDER BY area_id ASC;