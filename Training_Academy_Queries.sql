SELECT Students.FullName, COUNT(*) AS TotalSessions,
    SUM(CASE WHEN Attendance.Status = 'Present' THEN 1 ELSE 0 END) AS PresentSessions,
    CAST(SUM(CASE WHEN Attendance.Status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS AttendancePercentage
FROM Attendance
JOIN Students ON Attendance.StudentID = Students.StudentID
GROUP BY Students.FullName;