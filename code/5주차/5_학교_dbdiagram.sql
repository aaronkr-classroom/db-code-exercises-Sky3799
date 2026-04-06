-- dbdiagram.io를 위해 수정하기

Table Professor {
	professor_id int [pk]
	professor_name varchar
	department varchar
	salary numeric
	salary_level numeric
	hire_date date
}

Table Student {
	student_id int [pk]
	student_name varchar
	major varchar
}

Table Course {
	course_id int
	section_id int
	professor_id int
	course_name varchar
	indexes {
		(course_id, section_id) [pk]
	}
}

Table Enrollment {
	student_id int
	course_id int
	grade varchar
	points numeric
	enrolled_at DATE
	indexes {
		(student_id, course_id) 
	}
}

Ref: Enrollment.student_id > Student.student_id
Rdf: Course.professor_id > Professor.professor_id