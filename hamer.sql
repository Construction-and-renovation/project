CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    login VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE "Service" (
    service_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    unit VARCHAR(50) NOT NULL
);

CREATE TABLE "Contact" (
    contact_id SERIAL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    working_hours VARCHAR(100) NULL
);

CREATE TABLE "Vacancy" (
    vacancy_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    salary DECIMAL(10, 2) NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    posted_date DATE NOT NULL
);

CREATE TABLE "Client" (
    client_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    email VARCHAR(100) NULL,
    CONSTRAINT fk_client_user FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE
);

CREATE TABLE "Employee" (
    employee_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    specialty VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    CONSTRAINT fk_employee_user FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE
);

CREATE TABLE "Project" (
    project_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT fk_project_client FOREIGN KEY (client_id) REFERENCES "Client"(client_id) ON DELETE CASCADE
);

CREATE TABLE "Order" (
    order_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    service_id INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL,
    order_date DATE NOT NULL,
    CONSTRAINT fk_order_client FOREIGN KEY (client_id) REFERENCES "Client"(client_id) ON DELETE RESTRICT,
    CONSTRAINT fk_order_service FOREIGN KEY (service_id) REFERENCES "Service"(service_id) ON DELETE RESTRICT
);

CREATE TABLE "Review" (
    review_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    service_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NULL,
    review_date DATE NOT NULL,
    CONSTRAINT fk_review_client FOREIGN KEY (client_id) REFERENCES "Client"(client_id) ON DELETE CASCADE,
    CONSTRAINT fk_review_service FOREIGN KEY (service_id) REFERENCES "Service"(service_id) ON DELETE CASCADE
);