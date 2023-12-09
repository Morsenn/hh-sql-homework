--Соискатели будут искать вакансии в определённом городе и возможно по определённой специальности
CREATE INDEX specializations_by_area_index ON vacancies (area_id, specialization_id);

--Работодатель захочет посмотреть отклики по определённой вакансии
--Также можно добавить в этот индекс статус отклика, но на одну вакансию по идее будет
--не так много откликов, поэтому я не стал добавлять
CREATE INDEX vacancy_responses_index ON vacancy_responses (vacancy_id);

--Соискатели будут смотреть список всех своих резюме
CREATE INDEX canditates_cv_index ON cvs (candidate_id);