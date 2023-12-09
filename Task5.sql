SELECT
  vacancies.id AS vacancy_id,
  vacancies.position_name AS title
FROM vacancies
INNER JOIN vacancy_responses ON vacancies.id = vacancy_responses.vacancy_id
WHERE
  date_part('day', vacancy_responses.response_time - vacancies.creation_time) < 7
GROUP BY
  vacancies.id,
  vacancies.position_name
HAVING
  COUNT(vacancy_responses.id) > 5
ORDER BY vacancy_id ASC;