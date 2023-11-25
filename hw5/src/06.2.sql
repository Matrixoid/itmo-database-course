SELECT StudentId
FROM Students 
EXCEPT
SELECT StudentId
FROM Students
        NATURAL JOIN Plan
        NATURAL JOIN Marks
        NATURAL JOIN Lecturers
WHERE LecturerName = :LecturerName;