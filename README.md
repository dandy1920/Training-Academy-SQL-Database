# Training Academy - SQL Database Project

![SQL](https://img.shields.io/badge/Language-SQL%20%2F%20MySQL-blue)
![Workbench](https://img.shields.io/badge/Tool-MySQL%20Workbench-orange)
![Domain](https://img.shields.io/badge/Domain-Database%20Management-green)

---

##  Project Overview
This project presents a comprehensive relational database system designed for a Training Academy using **MySQL Workbench**. It covers end-to-end database implementation including schema design, DDL/DML operations, complex JOINs, aggregate functions, and attendance tracking analytics with business reporting queries[cite: 20].

---

## Repository Structure

| File Name | Description |
| :--- | :--- |
| `TrainingAcademy_FullExport.sql` | Full MySQL dump containing database schema and initial data records. |
| `TrainingAcademy_Workshop1_2.txt` | Workshop script covering DDL, DML, and foundational queries[cite: 18, 21]. |
| `Training_Academy_Queries.sql` | Core SQL assignment queries, filters, joins, and bonus percentage calculations[cite: 20]. |
| `Database_Schema.png` | Entity-Relationship (ERD) database schema diagram. |
| `screenshots/` | Folder containing step-by-step query execution outputs and Result Grids. |

---

## Technical Notes & DML Operations

During data maintenance and transition from test records to official records in the `Attendance` table, bulk DML operations (`DELETE` and `INSERT`) were utilized.

### Handling Safe Update Mode (Error 1175)
Because MySQL Workbench restricts bulk `DELETE` operations without a reference key in the `WHERE` clause to prevent accidental data loss, Safe Update Mode was handled programmatically using the following snippet:

```sql
-- Disable Safe Updates temporarily
SET SQL_SAFE_UPDATES = 0;

-- Refresh Attendance Table records
DELETE FROM Attendance;
INSERT INTO Attendance (AttendanceID, SessionID, StudentID, Status) VALUES (...);

-- Re-enable Safe Updates
SET SQL_SAFE_UPDATES = 1;

📊 Database Architecture & SchemaThe database consists of interconnected tables managing students, instructors, courses, enrollments, sessions, and attendance tracking[cite: 16, 21].[cite: 16]🚀 Key Queries & Visualizations1. List All StudentsRetrieves all student records from the database.   SQLSELECT * FROM Students;
   2. Courses with Fee Greater Than 100Filters courses based on specific pricing criteria.   SQLSELECT * FROM Courses
WHERE Fee > 100;
   3. Student Course EnrollmentsConnects students with their respective enrolled courses using multiple JOIN statements.   SQLSELECT Students.FullName AS Student,
       Courses.CourseName AS Course
FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID;
   4. Sessions for SQL CoursesFilters session schedules specifically matching SQL topics using pattern matching (LIKE).   SQLSELECT Sessions.*, Courses.CourseName
FROM Sessions
JOIN Courses ON Sessions.CourseID = Courses.CourseID
WHERE Courses.CourseName LIKE '%SQL%';
   5. Student Attendance StatusTracks individual student attendance records per session.   SQLSELECT Students.FullName, Attendance.Status
FROM Attendance
JOIN Students ON Attendance.StudentID = Students.StudentID;
   6. Present Sessions Count per StudentAggregates total present records for each student using GROUP BY and COUNT.   SQLSELECT Students.FullName,
       COUNT(*) AS PresentSessions
FROM Attendance
JOIN Students ON Attendance.StudentID = Students.StudentID
WHERE Attendance.Status = 'Present'
GROUP BY Students.FullName;
   7. Attendance Percentage (Bonus Query)Calculates total sessions, present sessions, and attendance performance percentage using conditional CASE statements and CAST precision.   SQLSELECT Students.FullName,
       COUNT(*) AS TotalSessions,
       SUM(CASE WHEN Attendance.Status = 'Present' THEN 1 ELSE 0 END) AS PresentSessions,
       CAST(SUM(CASE WHEN Attendance.Status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS AttendancePercentage
FROM Attendance
JOIN Students ON Attendance.StudentID = Students.StudentID
GROUP BY Students.FullName;
[cite: 17]💻 Tools & EnvironmentDatabase Management System: MySQL Server / MySQL Workbench   Language: SQL (DDL, DML, DQL)[cite: 19]Environment: Localhost Development Environment[cite: 21]👤 AuthorHudhaifah Muslih Ali   GitHub: @dandy1920   Email: damageguard@email.com
