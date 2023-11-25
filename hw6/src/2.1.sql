SELECT StudentId, StudentName, GroupName
FROM Students, Groups
WHERE Students.GroupId = Groups.GroupId;