DROP TABLE profile;

CREATE TABLE profile (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    student_id VARCHAR(50) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    programme VARCHAR(100) NOT NULL,
    year_of_study INT NOT NULL,
    hobby VARCHAR(200),
    address VARCHAR(300),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);


