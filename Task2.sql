INSERT INTO areas(
  id,
  area_name
)
SELECT
  generate_series(1, 100) AS id,
  md5(random()::text) AS area_name;


INSERT INTO candidates(
  id,
  email,
  first_name,
  is_searching_for_job,
  last_name,
  phone_number,
  registration_time
)
SELECT
  generate_series(1, 50000) AS id,
  md5(random()::text) AS email,
  md5(random()::text) AS first_name,
  true AS is_searching_for_job,
  md5(random()::text) AS last_name,
  '78005553535' AS phone_number,
  to_timestamp((random() * 701997810 + 1000000000)::DOUBLE PRECISION) AS registration_time;


INSERT INTO specializations(
  id,
  professional_area,
  specialization_name
)
SELECT
  generate_series(1, 1000) AS id,
  md5(random()::text) AS professional_area,
  md5(random()::text) AS specialization_name;


WITH test_data AS (
  SELECT
    generate_series(1, 100000) AS id,
    (random() * 99 + 1)::INTEGER AS area_id,
    md5(random()::text) AS candidate_cv,
    (random() * 49999 + 1)::INTEGER AS candidate_id,
    make_interval(secs => (random() * 1000000)::INTEGER) AS delta_creation_time,
    (random() * 999 + 1)::INTEGER AS specialization_id
)
INSERT INTO cvs(
  id,
  area_id,
  candidate_cv,
  candidate_id,
  creation_time,
  specialization_id
)
SELECT
  test_data.id AS id,
  test_data.area_id AS area_id,
  test_data.candidate_cv AS candidate_cv,
  test_data.candidate_id AS candidate_id,
  candidates.registration_time + test_data.delta_creation_time AS creation_time,
  test_data.specialization_id AS specialization_id
FROM test_data
LEFT JOIN candidates ON test_data.candidate_id = candidates.id;


INSERT INTO employers(
  id,
  area_id,
  description,
  employer_name,
  registration_time
)
SELECT
  generate_series(1, 1000) AS id,
  (random() * 99 + 1)::INTEGER AS area_id,
  md5(random()::TEXT) AS description,
  md5(random()::TEXT) AS employer_name,
  to_timestamp((random() * 701997810 + 1000000000)::DOUBLE PRECISION) AS registration_time;


WITH test_data AS (
  SELECT
    generate_series(1, 10000) AS id,
    (random() * 99 + 1)::INTEGER AS area_id,
    round((random() * 100000)::INTEGER, -3) AS compensation_from,
    true AS compensation_gross,
    make_interval(secs => (random() * 1000000)::INTEGER) AS delta_creation_time,
    md5(random()::TEXT) AS description,
    (random() * 999 + 1)::INTEGER AS employer_id,
    md5(random()::TEXT) AS position_name,
    (random() * 999 + 1)::INTEGER AS specialization_id
)
INSERT INTO vacancies(
  id,
  area_id,
  compensation_from,
  compensation_gross,
  compensation_to,
  creation_time,
  description,
  employer_id,
  position_name,
  specialization_id
)
SELECT
  test_data.id AS id,
  test_data.area_id AS area_id,
  test_data.compensation_from AS compensation_from,
  test_data.compensation_gross AS compensation_gross,
  test_data.compensation_from + 10000 AS compensation_to,
  employers.registration_time + test_data.delta_creation_time AS creation_time,
  test_data.description AS description,
  test_data.employer_id AS employer_id,
  test_data.position_name AS position_name,
  test_data.specialization_id AS specialization_id
FROM test_data
LEFT JOIN employers ON test_data.employer_id = employers.id;


WITH test_data AS (
  SELECT
    generate_series(1, 100000) AS id,
    (random() * 49999 + 1)::INTEGER AS candidate_id,
    (random() * 5)::INTEGER AS response_status,
    make_interval(secs => (random() * 1000000)::INTEGER) AS delta_response_time,
    (9999 * random() + 1)::INTEGER AS vacancy_id
), test_cv AS (
  SELECT
    candidate_id AS candidate_id,
    MIN(id) AS cv_id
  FROM cvs
  GROUP BY candidate_id
  ORDER BY candidate_id ASC
)
INSERT INTO vacancy_responses(
  id,
  candidate_id,
  cv_id,
  response_status,
  response_time,
  vacancy_id
)
SELECT
  test_data.id AS id,
  test_data.candidate_id AS candidate_id,
  test_cv.cv_id AS cv_id,
  test_data.response_status AS response_status,
  GREATEST(
    candidates.registration_time,
    vacancies.creation_time
  ) + test_data.delta_response_time AS response_time,
  test_data.vacancy_id AS vacancy_id
FROM test_data
LEFT JOIN candidates ON test_data.candidate_id = candidates.id
LEFT JOIN vacancies ON test_data.vacancy_id = vacancies.id
LEFT JOIN test_cv ON test_data.candidate_id = test_cv.candidate_id;