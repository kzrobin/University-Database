-- Kz Robin


create database university;
use university;
-- Table: classroom
CREATE TABLE classroom (
    building VARCHAR(50),
    room_number INT,
    capacity INT,
    PRIMARY KEY (building, room_number)
);

-- Table: department
CREATE TABLE department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget DECIMAL(10, 2)
);

-- Table: course
CREATE TABLE course (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    dept_name VARCHAR(50),
    credits INT,
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) on update CASCADE on delete CASCADE
);

-- Table: instructor
CREATE TABLE instructor (
    ID INT PRIMARY KEY,
    name VARCHAR(100),
    dept_name VARCHAR(50),
    salary DECIMAL(10, 2),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) on update CASCADE on delete CASCADE
); 


-- Table: time slot
CREATE TABLE time_slot (
    time_slot_id char(10) PRIMARY KEY,
    day VARCHAR(10),
    start_time TIME,
    end_time TIME
);


-- Table: section
CREATE TABLE section (
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(20),
    year INT,
    building VARCHAR(50),
    room_number INT,
    time_slot_id char(10),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course(course_id) on update CASCADE on delete CASCADE,
    FOREIGN KEY (building, room_number) REFERENCES classroom(building, room_number) on update CASCADE on delete CASCADE,
    FOREIGN KEY (time_slot_id) REFERENCES time_slot(time_slot_id) on update CASCADE on delete CASCADE
);

-- Table: teaches
CREATE TABLE teaches (
    ID INT,
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(20),
    year INT,
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES instructor(ID) on update CASCADE on delete CASCADE,
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year) on update CASCADE on delete CASCADE
);

-- Table: student
CREATE TABLE student (
    ID INT PRIMARY KEY,
    name VARCHAR(100),
    dept_name VARCHAR(50),
    tot_cred INT,
    FOREIGN KEY (dept_name) REFERENCES department(dept_name) on update CASCADE on delete CASCADE
);

-- Table: takes
CREATE TABLE takes (
    ID INT,
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(20),
    year INT,
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES student(ID) on update CASCADE on delete CASCADE,
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year) on update CASCADE on delete CASCADE
);

-- Table: advisor
CREATE TABLE advisor (
    s_ID INT,
    i_ID INT,
    PRIMARY KEY (s_ID),
    FOREIGN KEY (s_ID) REFERENCES student(ID) on update CASCADE on delete CASCADE,
    FOREIGN KEY (i_ID) REFERENCES instructor(ID) on update CASCADE on delete CASCADE
);



-- Table: prereq
CREATE TABLE prereq (
    course_id VARCHAR(10),
    prereq_id VARCHAR(10),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id) on update CASCADE on delete CASCADE,
    FOREIGN KEY (prereq_id) REFERENCES course(course_id) on update CASCADE on delete CASCADE
);

-- Example data for the department table
INSERT INTO department (dept_name, building, budget)
VALUES
('Biology', 'Watson', 90000.00),
('Comp. Sci.', 'Taylor', 100000.00),
('Elec. Eng.', 'Taylor', 85000.00),
('Finance', 'Painter', 120000.00),
('History', 'Painter', 50000.00),
('Music', 'Packard', 80000.00),
('Physics', 'Watson', 70000.00);

-- select * from department;


-- Adding data to the classroom table
INSERT INTO classroom (building, room_number, capacity)
VALUES
('Packard', 101, 500),
('Painter', 514, 10),
('Taylor', 3128, 70),
('Watson', 100, 30),
('Watson', 120, 50);

select * from classroom;

-- Continuing data for the instructor table
INSERT INTO instructor (ID, name, dept_name, salary)
VALUES
(10101, 'Srinivasan', 'Comp. Sci.', 65000.00),
(12121, 'Wu', 'Finance', 90000.00),
(15151, 'Mozart', 'Music', 40000.00),
(22222, 'Einstein', 'Physics', 95000.00),
(32343, 'El Said', 'History', 60000.00),
(33456, 'Gold', 'Physics', 87000.00),
(45565, 'Katz', 'Comp. Sci.', 75000.00),
(58583, 'Califieri', 'History', 62000.00),
(76543, 'Singh', 'Finance', 80000.00),
(76766, 'Crick', 'Biology', 72000.00),
(83821, 'Brandt', 'Comp. Sci.', 92000.00),
(98345, 'Kim', 'Elec. Eng.', 80000.00);


select * from instructor;

-- Example data for the course table
INSERT INTO course (course_id, title, dept_name, credits)
VALUES
('BIO-101', 'Intro. to Biology', 'Biology', 4),
('BIO-301', 'Genetics', 'Biology', 4),
('BIO-399', 'Computational Biology', 'Biology', 3),
('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4),
('CS-190', 'Game Design', 'Comp. Sci.', 4),
('CS-315', 'Robotics', 'Comp. Sci.', 3),
('CS-319', 'Image Processing', 'Comp. Sci.', 3),
('CS-347', 'Database System Concepts', 'Comp. Sci.', 3),
('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3),
('FIN-201', 'Investment Banking', 'Finance', 3),
('HIS-351', 'World History', 'History', 3),
('MU-199', 'Music Video Production', 'Music', 3),
('PHY-101', 'Physical Principles', 'Physics', 4);


-- select * from course;


-- Adding data to the prereq table
INSERT INTO prereq (course_id, prereq_id)
VALUES
('BIO-301', 'BIO-101'),
('BIO-399', 'BIO-101'),
('CS-190', 'CS-101'),
('CS-315', 'CS-101'),
('CS-319', 'CS-101'),
('CS-347', 'CS-101'),
('EE-181', 'PHY-101');

-- select * from prereq;

-- Adding data to the time_slot table
INSERT INTO time_slot (time_slot_id, day, start_time, end_time)
VALUES
('A', 'Monday', '08:00:00', '09:00:00'),
('B', 'Tuesday', '09:30:00', '10:30:00'),
('C', 'Wednesday', '11:00:00', '12:00:00'),
('D', 'Thursday', '13:00:00', '14:00:00'),
('E', 'Friday', '14:30:00', '15:30:00'),
('F', 'Monday', '16:00:00', '17:00:00'),
('G', 'Tuesday', '17:30:00', '18:30:00'),
('H', 'Wednesday', '19:00:00', '20:00:00'),
('I', 'Thursday', '20:30:00', '21:30:00'),
('J', 'Friday', '22:00:00', '23:00:00');

-- select * from time_slot;

-- Adding data to the section table
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id)
VALUES
('BIO-101', '1', 'Summer', 2017, 'Painter', 514, 'B'),
('BIO-301', '1', 'Summer', 2018, 'Painter', 514, 'A'),
('CS-101', '1', 'Fall', 2017, 'Packard', 101, 'H'),
('CS-101', '1', 'Spring', 2018, 'Packard', 101, 'F'),
('CS-190', '1', 'Spring', 2017, 'Taylor', 3128, 'E'),
('CS-190', '2', 'Spring', 2017, 'Taylor', 3128, 'A'),
('CS-315', '1', 'Spring', 2018, 'Watson', 120, 'D'),
('CS-319', '1', 'Spring', 2018, 'Watson', 100, 'B'),
('CS-319', '2', 'Spring', 2018, 'Taylor', 3128, 'C'),
('CS-347', '1', 'Fall', 2017, 'Taylor', 3128, 'A'),
('EE-181', '1', 'Spring', 2017, 'Taylor', 3128, 'C'),
('FIN-201', '1', 'Spring', 2018, 'Packard', 101, 'B'),
('HIS-351', '1', 'Spring', 2018, 'Painter', 514, 'C'),
('MU-199', '1', 'Spring', 2018, 'Packard', 101, 'D'),
('PHY-101', '1', 'Fall', 2017, 'Watson', 100, 'A');

-- select * from section;

-- Adding data to the teaches table
INSERT INTO teaches (ID, course_id, sec_id, semester, year)
VALUES
(10101, 'CS-101', '1', 'Fall', 2017),
(10101, 'CS-315', '1', 'Spring', 2018),
(10101, 'CS-347', '1', 'Fall', 2017),
(12121, 'FIN-201', '1', 'Spring', 2018),
(15151, 'MU-199', '1', 'Spring', 2018),
(22222, 'PHY-101', '1', 'Fall', 2017),
(32343, 'HIS-351', '1', 'Spring', 2018),
(45565, 'CS-101', '1', 'Spring', 2018),
(45565, 'CS-319', '1', 'Spring', 2018),
(76766, 'BIO-101', '1', 'Summer', 2017),
(76766, 'BIO-301', '1', 'Summer', 2018),
(83821, 'CS-190', '1', 'Spring', 2017),
(83821, 'CS-190', '2', 'Spring', 2017),
(83821, 'CS-319', '2', 'Spring', 2018),
(98345, 'EE-181', '1', 'Spring', 2017);

-- select * from teaches;

SELECT * FROM instructor CROSS JOIN teaches;




