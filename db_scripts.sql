-- Notes:
-- Spring Boot backend is the source of truth. It will handle nanoId and initiate data.
-- Database should not define default values > BE will take care.

-- Base schema
CREATE SCHEMA IF NOT EXISTS beo_base;

-- Drop tables if they exist (in correct FK order)
DROP TABLE IF EXISTS beo_base.apps;
DROP TABLE IF EXISTS beo_base.users;

-- Apps table
CREATE TABLE beo_base.apps
(
    id         VARCHAR(10) PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    tags       TEXT[]      NOT NULL,
    route      TEXT        NOT NULL,
    route_type VARCHAR(10) NOT NULL,

    CONSTRAINT apps_route_type_check
        CHECK (route_type IN ('INTERNAL', 'EXTERNAL'))
);

-- Users Table
CREATE TABLE beo_base.users
(
    id              VARCHAR(10) PRIMARY KEY,
    name            VARCHAR(50),
    email           VARCHAR(255) NOT NULL,
    password_hashed VARCHAR(255) NOT NULL,
    role            VARCHAR(20)  NOT NULL,
    is_active       BOOLEAN      NOT NULL,
    created_at      TIMESTAMPTZ  NOT NULL,

    CONSTRAINT users_role_check
        CHECK (role IN (
                        'ROLE_ADMIN',
                        'ROLE_SUPPORT',
                        'ROLE_USER',
                        'ROLE_DEMO'
            ))
);
CREATE UNIQUE INDEX users_email_unique
    ON beo_base.users (LOWER(email));