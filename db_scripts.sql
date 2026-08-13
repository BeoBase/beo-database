-- Notes:
-- Spring Boot backend is the source of truth.
-- Database should not define default values.

-- Drop tables if they exist (in correct FK order)
DROP TABLE IF EXISTS users;

-- Users Table
CREATE TABLE users (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(255) NOT NULL,
    password_hashed VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    is_active BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,

    CONSTRAINT users_role_check
        CHECK (role IN (
            'ROLE_ADMIN',
            'ROLE_SUPPORT',
            'ROLE_USER',
            'ROLE_DEMO'
        ))
);
CREATE UNIQUE INDEX users_email_unique
    ON users (LOWER(email));