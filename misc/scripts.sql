CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Trials table
CREATE TABLE trials (
    id SERIAL PRIMARY KEY,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    category INT NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    variety VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    region VARCHAR(100),

    -- Plant attributes
    plant_vigour INT,
    plant_earliness INT,
    plant_cold_tolerence INT,
    plant_heat_tolerence INT,
    fruit_setting INT,
    fruit_shape VARCHAR(50),
    plant_notes TEXT,

    -- Fruit attributes
    fruit_quantity INT,
    fruit_uniformity INT,
    fruit_weight FLOAT,
    fruit_firmness INT,
    fruit_calyx_quality INT,
    fruit_blotchy_ripening INT,
    fruit_macro_cracking INT,
    fruit_micro_cracking INT,
    fruit_notes TEXT,

    -- Diseases (stored as JSON string for flexibility)
    diseases JSONB
);

-- Insert categories if not exists
INSERT INTO categories (category_namename) VALUES ('Tomatoes') ON CONFLICT (category_namename) DO NOTHING;
INSERT INTO categories (category_namename) VALUES ('Peppers') ON CONFLICT (category_namename) DO NOTHING;
INSERT INTO categories (category_namename) VALUES ('Cucumbers') ON CONFLICT (category_namename) DO NOTHING;

-- Trial 1
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2025-09-15 08:00:00', '2025-10-15 16:00:00', 'Tomatoes', 'Beefsteak', 'Greenhouse 2', 'Northern Cape',
    7, 6, 5, 7, 8, 'Oval', 'Strong stems',
    100, 7, 20.0, 8, 8, 1, 0, 2, 'Good overall', 
    '{
        "blight": {"severity": 2, "notes": "some spotting"},
        "fusarium_wilt": {"severity": 1, "notes": "minor"}
    }'::jsonb
);

-- Trial 2
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2025-08-10 09:00:00', '2025-09-30 17:00:00', 'Peppers', 'Bell Red', 'Field 3', 'Eastern Cape',
    6, 7, 7, 6, 7, 'Blocky', 'Healthy',
    80, 8, 18.5, 7, 9, 0, 1, 0, 'Yield slightly lower than expected',
    '{
        "bacterial_spot": {"severity": 3, "notes": "moderate spotting"},
        "anthracnose": {"severity": 0, "notes": "none observed"}
    }'::jsonb
);

-- Trial 3
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2025-07-01 07:30:00', '2025-08-15 15:30:00', 'Cucumbers', 'Marketmore', 'Greenhouse 1', 'Western Cape',
    8, 8, 6, 7, 9, 'Cylindrical', 'Strong growth',
    150, 9, 12.0, 8, 8, 0, 0, 1, 'Excellent quality',
    '{
        "powdery_mildew": {"severity": 1, "notes": "slight powdery patches"},
        "downy_mildew": {"severity": 0, "notes": "none"}
    }'::jsonb
);

-- Trial 4
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2025-06-15 08:15:00', '2025-07-20 16:45:00', 'Tomatoes', 'Cherry Gold', 'Field 1', 'Limpopo',
    9, 9, 7, 8, 8, 'Round', 'Vigorous',
    200, 9, 10.5, 9, 9, 1, 0, 0, 'High yield, excellent uniformity',
    '{
        "blight": {"severity": 4, "notes": "significant spotting"},
        "powdery_mildew": {"severity": 2, "notes": "some affected leaves"}
    }'::jsonb
);
