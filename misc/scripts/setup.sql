-- Full project setup script for fresh installs.
-- Run this on a new database to create all tables with the current schema.
-- Does not include any seed data.

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE trials (
    id SERIAL PRIMARY KEY,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    category_name VARCHAR(100) NOT NULL,
    variety VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    region VARCHAR(100),
    plant_vigour INT,
    plant_earliness INT,
    plant_cold_tolerence INT,
    plant_heat_tolerence INT,
    fruit_setting INT,
    fruit_shape VARCHAR(50),
    plant_notes TEXT,
    fruit_quantity INT,
    fruit_uniformity INT,
    fruit_weight FLOAT,
    fruit_firmness INT,
    fruit_calyx_quality INT,
    fruit_blotchy_ripening INT,
    fruit_macro_cracking INT,
    fruit_micro_cracking INT,
    fruit_notes TEXT,
    diseases JSONB,
    growth_phases JSONB,
    FOREIGN KEY (category_name) REFERENCES categories(category_name) ON DELETE CASCADE
);
