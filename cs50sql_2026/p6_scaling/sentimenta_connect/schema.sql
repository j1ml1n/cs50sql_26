CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `username` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL, -- hashed in real life application
    PRIMARY KEY (`id`)
);


CREATE TABLE `education` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `type` ENUM(`Primary`, `Secondary`, `Higher Education`),
    `location` VARCHAR(255) NOT NULL,
    `founding_year` DATE NOT NULL,
    PRIMARY KEY (`id`)
);


CREATE TABLE `companies` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `industry` ENUM(`Technology`, `Education`, `Business`),
    `location` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);


CREATE TABLE `people_connections` (
    `id` INT AUTO_INCREMENT,
    `user_idA` INT,
    `user_idB` INT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_idA`) REFERENCES `users`(`id`),
    FOREIGN KEY (`user_idB`) REFERENCES `users`(`id`)
);


CREATE TABLE `schools_connections` (
    `id` INT AUTO_INCREMENT,
    `user_id` INT,
    `education_id` INT,
    `startDate` DATE, -- 'yyyy-mm-dd'
    `endDate` DATE, -- 'yyyy-mm-dd'
    `typeDegree` VARCHAR(255) NOT NULL,
    `statusDegree` ENUM(`earned`, `persued`),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`education_id`) REFERENCES `education`(`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);


CREATE TABLE `companies_connections` (
    `id` INT AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `companie_id` INT NOT NULL,
    `startDate` DATE, -- 'yyyy-mm-dd'
    `endDate` DATE, -- 'yyyy-mm-dd'
    `title` TEXT NOT NULL, -- title or role in company
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`companie_id`) REFERENCES `companies`(`id`)
);
