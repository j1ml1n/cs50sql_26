-- students index
CREATE INDEX "students_id"
ON students("id");

-- enrollment index
CREATE INDEX "enrollments_student_id"
ON enrollments("student_id");
CREATE INDEX "enrollments_course_id"
ON enrollments("course_id");

-- courses index
CREATE INDEX"courses_title_semester"
ON courses("title", "semester");
CREATE INDEX"courses_department_number_semester"
ON courses("department", "number", "semester");

-- satisfies index
CREATE INDEX "satisfies_course_id"
ON satisfies("course_id");
CREATE INDEX "satisfies_requiremetnt_id"
ON satisfies("requirement_id");
