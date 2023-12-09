--Не понял, является ли один и тот же месяц, но в разные годы, одинаковым, поэтому не могу
--не воспользоваться возможностью написать обе реализации :)
--Также использовал два разных подхода для решения задачи, у каждого свои достоинства и недостатки
WITH month_with_most_vacancy_count AS (
  SELECT
    date_part('month', creation_time) AS month
  FROM vacancies
  GROUP BY month
  ORDER BY COUNT(*) DESC
  LIMIT 1
), month_with_most_cv_count AS (
  SELECT
    date_part('month', creation_time) AS month
  FROM cvs
  GROUP BY month
  ORDER BY COUNT(*) DESC
  LIMIT 1
)
SELECT
  month_with_most_vacancy_count.month AS month_with_most_vacancy_count,
  month_with_most_cv_count.month AS month_with_most_cv_count
FROM month_with_most_cv_count
CROSS JOIN month_with_most_vacancy_count;