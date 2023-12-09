CREATE TABLE areas (
  id SERIAL PRIMARY KEY,
  area_name VARCHAR(50) NOT NULL
);

CREATE TABLE candidates (
  id SERIAL PRIMARY KEY,
  registration_time TIMESTAMP NOT NULL DEFAULT now(),
  is_searching_for_job BOOL NOT NULL DEFAULT true,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50),
  phone_number VARCHAR(18)
);

CREATE TABLE employers (
  id SERIAL PRIMARY KEY,
  employer_name VARCHAR(100) NOT NULL,
  registration_time TIMESTAMP NOT NULL DEFAULT now(),
  area_id INTEGER NOT NULL REFERENCES areas (id),
  description TEXT
);

CREATE TABLE specializations (
  id SERIAL PRIMARY KEY,
  professional_area VARCHAR(50) NOT NULL,
  specialization_name VARCHAR(50) NOT NULL
);

CREATE TABLE cvs (
  id SERIAL PRIMARY KEY,
  candidate_id INTEGER NOT NULL REFERENCES candidates (id),
  area_id INTEGER NOT NULL REFERENCES areas (id),
  creation_time TIMESTAMP NOT NULL DEFAULT now(),
  candidate_cv TEXT NOT NULL,
  specialization_id INTEGER REFERENCES specializations(id)
);

CREATE TABLE vacancies (
  id SERIAL PRIMARY KEY,
  employer_id INTEGER NOT NULL REFERENCES employers (id),
  creation_time TIMESTAMP NOT NULL DEFAULT now(),
  specialization_id INTEGER NOT NULL REFERENCES specializations (id),
  position_name VARCHAR(50) NOT NULL,
  description TEXT,
  compensation_from INTEGER,
  compensation_to INTEGER,
  compensation_gross BOOL,
  area_id INTEGER NOT NULL REFERENCES areas (id)
);

CREATE TABLE vacancy_responses (
  id SERIAL PRIMARY KEY,
  vacancy_id INTEGER NOT NULL REFERENCES vacancies (id),
  candidate_id INTEGER NOT NULL REFERENCES candidates (id),
  response_time TIMESTAMP NOT NULL DEFAULT now(),
  cv_id INTEGER REFERENCES cvs (id),
  response_status INTEGER NOT NULL
);