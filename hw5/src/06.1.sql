SELECT DISTINCT StudentId
FROM Students
        NATURAL JOIN Marks
        NATURAL JOIN Lecturers
        NATURAL JOIN Plan
WHERE LecturerName = :LecturerName;