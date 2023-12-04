-- Тут мы просто хотим уметь быстро делать IN, поэтому хеш.
CREATE INDEX plan_group_id_lecturer_id ON Plan USING HASH (GroupId, LecturerId);