SELECT GroupName, AVG(CAST(AvgMark AS REAL)) AS AvgAvgMark
FROM Groups
		LEFT JOIN (SELECT GroupId, AVG(CAST(Mark AS REAL)) AS AvgMark
				   FROM Students
							NATURAL JOIN Marks
				   GROUP BY StudentId, GroupId) X ON Groups.GroupId = X.GroupId
GROUP BY Groups.GroupId, Groups.GroupName;