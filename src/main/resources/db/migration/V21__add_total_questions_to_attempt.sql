
ALTER TABLE attempt ADD COLUMN total_questions INT DEFAULT 0;

UPDATE attempt a 
SET total_questions = (
    SELECT COUNT(*) 
    FROM attempt_question aq 
    WHERE aq.attempt_id = a.attempt_id
)
WHERE a.status IN ('SUBMITTED', 'GRADED');

UPDATE attempt a 
JOIN quiz q ON a.quiz_id = q.quiz_id
SET a.total_questions = q.total_questions
WHERE a.total_questions = 0;
