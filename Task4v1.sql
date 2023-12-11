--Не понял, является ли один и тот же месяц, но в разные годы, одинаковым, поэтому не могу
--не воспользоваться возможностью написать обе реализации :)
--Также использовал два разных подхода для решения задачи, у каждого свои достоинства и недостатки
WITH vacancy_count_by_month AS (
  SELECT
    date_trunc('month', creation_time) AS month,
    COUNT(*) AS vacancy_count
  FROM vacancies
  GROUP BY month
), max_vacancy_month AS (
  SELECT
    month
  FROM vacancy_count_by_month
  WHERE
    vacancy_count = (SELECT MAX(vacancy_count) FROM vacancy_count_by_month)
), cv_count_by_month AS (
  SELECT
    date_trunc('month', creation_time) AS month,
    COUNT(*) AS cv_count
  FROM cvs
  GROUP BY month
), max_cv_month AS (
  SELECT
    month
  FROM cv_count_by_month
  WHERE
    cv_count = (SELECT MAX(cv_count) FROM cv_count_by_month)
)
SELECT
  max_vacancy_month.month AS month_with_most_vacancies,
  max_cv_month.month AS month_with_most_cvs
FROM max_vacancy_month
CROSS JOIN max_cv_month
ORDER BY month_with_most_vacancies;
