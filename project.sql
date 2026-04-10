CREATE DATABASE student_portal;
USE student_portal;

#Student Table
CREATE TABLE students(
id INT AUTO_INCREMENT PRIMARY KEY , 
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL , 
password VARCHAR(255) NOT NULL , 
role ENUM('student','admin')DEFAULT 'student' , 
created_at TIMESTAMP DEFAULT
CURRENT_TIMESTAMP
);

#Subject table
CREATE TABLE subjects ( 
id INT AUTO_INCREMENT PRIMARY KEY , 
subject_name VARCHAR(100) NOT NULL
);

#Marks table
CREATE TABLE marks(
id INT AUTO_INCREMENT PRIMARY KEY ,
student_id INT , 
subject_id INT , 
marks INT CHECK(marks >=0 AND marks <=100),

FOREIGN KEY(student_id)REFERENCES
students(id) ON DELETE CASCADE , 
FOREIGN KEY (subject_id) REFERENCES
subjects(id) ON DELETE CASCADE
);

#Attendance table
CREATE TABLE attendance (
id INT AUTO_INCREMENT PRIMARY KEY , 
student_id INT ,
subject_id int ,
attended_classes INT DEFAULT 0 , 
total_classes INT DEFAULT 0 , 

FOREIGN KEY (student_id) REFERENCES
students(id) ON DELETE CASCADE ,
FOREIGN KEY (subject_id) REFERENCES
subjects(id) ON DELETE CASCADE
);

#Fees Table
CREATE TABLE fees ( 
id INT AUTO_INCREMENT PRIMARY KEY , 
student_id INT , 
total_fee INT NOT NULL , 
paid_fee INT DEFAULT 0 , 
due_date DATE ,

FOREIGN KEY (student_id) REFERENCES
students(id) ON DELETE CASCADE
);

#Notification Table
CREATE TABLE notifications(
id INT AUTO_INCREMENT PRIMARY KEY , 
student_id INT , 
message TEXT , 
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,

FOREIGN KEY (student_id) REFERENCES
students(id) ON DELETE CASCADE
);

INSERT INTO students (name , email , password)
SELECT 
CONCAT('Student' , num) , 
CONCAT('student' , num , '@gmail.com') ,
'1234'
FROM(
SELECT a.N + b.N * 10 + c.N *100 + 1 AS num
FROM 
(SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 ) a,
(SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 ) b,
(SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 ) c
)numbers
LIMIT 500;

INSERT INTO subjects (subject_name) VALUES
('Math') , ('Physics') , ('Chemistry') , ('Computer') , ('English');

INSERT INTO marks (student_id , subject_id , marks)
SELECT
	s.id,
    sub.id,
    FLOOR(40 + RAND())
FROM students s
JOIN subjects sub;

INSERT INTO attendance (student_id , subject_id , attended_classes , total_classes)
SELECT 
	s.id,
    sub.id,
    FLOOR(20 + RAND()*30),
    50
FROM students s
JOIN subjects sub;


SELECT COUNT(*)FROM students;