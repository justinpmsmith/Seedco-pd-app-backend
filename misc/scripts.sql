-- Create tables
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
    FOREIGN KEY (category_name) REFERENCES categories(category_name) ON DELETE CASCADE
);

-- Insert Categories
INSERT INTO categories (category_name) VALUES ('Tomatoes') ON CONFLICT (category_name) DO NOTHING;
INSERT INTO categories (category_name) VALUES ('Peppers') ON CONFLICT (category_name) DO NOTHING;
INSERT INTO categories (category_name) VALUES ('Cucumbers') ON CONFLICT (category_name) DO NOTHING;

-- ============================================
-- TOMATOES - Variety: Roma VF
-- ============================================

-- Trial 1: Roma VF - Harare, Zimbabwe
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-09-01 08:00:00', '2024-12-15 17:00:00', 'Tomatoes', 'Roma VF', 'Harare', 'Zimbabwe',
    5, 5, 4, 5, 5, 'Oval', 'Well-balanced vegetative and reproductive growth',
    5, 5, 85.5, 5, 5, 5, 5, 4, 'Good uniformity with consistent fruit size throughout season',
    '{"early_blight": {"resistance": 5, "notes": "Minor spotting, did not progress"}, "fusarium_wilt": {"resistance": 5, "notes": "Clean foliage maintained without intervention"}}'::jsonb
);

-- Trial 2: Roma VF - Lusaka, Zambia
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-08-15 07:30:00', '2024-11-30 16:30:00', 'Tomatoes', 'Roma VF', 'Lusaka', 'Zambia',
    5, 4, 3, 5, 5, 'Oval', 'Standard growth pattern for variety type',
    4, 5, 82.0, 5, 4, 5, 4, 4, 'Responded well to pruning regime',
    '{"early_blight": {"resistance": 4, "notes": "Symptoms appeared late season only"}, "bacterial_spot": {"resistance": 5, "notes": "No symptoms observed throughout trial"}}'::jsonb
);

-- ============================================
-- TOMATOES - Variety: Cherry Belle
-- ============================================

-- Trial 1: Cherry Belle - Nairobi, Kenya
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-07-10 08:00:00', '2024-10-25 17:00:00', 'Tomatoes', 'Cherry Belle', 'Nairobi', 'Kenya',
    6, 6, 5, 5, 6, 'Round', 'Vigorous growth despite cooler temperatures',
    6, 6, 18.5, 6, 6, 6, 6, 5, 'Excellent uniformity with high marketable yield',
    '{"powdery_mildew": {"resistance": 5, "notes": "Minimal infection despite high disease pressure"}, "septoria_leaf_spot": {"resistance": 6, "notes": "Best performer in disease-prone block"}}'::jsonb
);

-- Trial 2: Cherry Belle - Arusha, Tanzania
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-06-20 07:30:00', '2024-10-05 16:30:00', 'Tomatoes', 'Cherry Belle', 'Arusha', 'Tanzania',
    5, 6, 4, 5, 6, 'Round', 'Early canopy establishment',
    6, 5, 19.2, 5, 5, 5, 5, 5, 'Growth consistent with previous season trials',
    '{"powdery_mildew": {"resistance": 4, "notes": "Manageable with standard spray program"}, "late_blight": {"resistance": 5, "notes": "No symptoms observed throughout trial"}}'::jsonb
);

-- Trial 3: Cherry Belle - Maputo, Mozambique
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-08-05 08:00:00', '2024-11-20 17:00:00', 'Tomatoes', 'Cherry Belle', 'Maputo', 'Mozambique',
    6, 5, 4, 6, 5, 'Round', 'Good leaf coverage protecting fruit from sun scald',
    5, 6, 17.8, 6, 5, 5, 6, 5, 'Consistent fruit size with minimal culls',
    '{"bacterial_wilt": {"resistance": 4, "notes": "Isolated patches, no major impact on yield"}, "early_blight": {"resistance": 5, "notes": "Minor spotting, did not progress"}}'::jsonb
);

-- ============================================
-- TOMATOES - Variety: Beefmaster
-- ============================================

-- Trial 1: Beefmaster - Cape Town, South Africa
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-09-10 07:30:00', '2024-12-30 16:30:00', 'Tomatoes', 'Beefmaster', 'Cape Town', 'South Africa',
    5, 4, 5, 4, 5, 'Flat-round', 'Strong root system observed at 4 weeks',
    4, 5, 245.0, 5, 5, 5, 4, 4, 'Large fruit with good firmness for market',
    '{"fusarium_wilt": {"resistance": 5, "notes": "Excellent field tolerance"}, "verticillium_wilt": {"resistance": 5, "notes": "No symptoms observed throughout trial"}}'::jsonb
);

-- Trial 2: Beefmaster - Harare, Zimbabwe
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-08-25 08:00:00', '2024-12-10 17:00:00', 'Tomatoes', 'Beefmaster', 'Harare', 'Zimbabwe',
    4, 4, 4, 4, 4, 'Flat-round', 'Responded well to pruning regime',
    4, 4, 238.5, 4, 4, 4, 4, 4, 'Standard growth pattern for variety type',
    '{"early_blight": {"resistance": 4, "notes": "Manageable with standard spray program"}, "septoria_leaf_spot": {"resistance": 4, "notes": "Symptoms appeared late season only"}}'::jsonb
);

-- ============================================
-- PEPPERS - Variety: California Wonder
-- ============================================

-- Trial 1: California Wonder - Lusaka, Zambia
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-08-01 08:00:00', '2024-11-15 17:00:00', 'Peppers', 'California Wonder', 'Lusaka', 'Zambia',
    5, 5, 4, 5, 5, 'Blocky', 'Well-balanced vegetative and reproductive growth',
    5, 5, 185.0, 5, 5, 6, 6, 6, 'Thick walls with excellent shelf life',
    '{"bacterial_spot": {"resistance": 4, "notes": "Minor spotting, did not progress"}, "phytophthora_blight": {"resistance": 5, "notes": "No symptoms observed throughout trial"}}'::jsonb
);

-- Trial 2: California Wonder - Nairobi, Kenya
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-07-15 07:30:00', '2024-10-30 16:30:00', 'Peppers', 'California Wonder', 'Nairobi', 'Kenya',
    5, 4, 5, 4, 5, 'Blocky', 'Compact growth habit, ideal for greenhouse production',
    5, 5, 192.5, 5, 6, 6, 6, 6, 'Uniform fruit size throughout harvest period',
    '{"bacterial_spot": {"resistance": 5, "notes": "Clean foliage maintained without intervention"}, "anthracnose": {"resistance": 5, "notes": "Excellent field tolerance"}}'::jsonb
);

-- ============================================
-- PEPPERS - Variety: Jalapeño M
-- ============================================

-- Trial 1: Jalapeño M - Arusha, Tanzania
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-06-10 08:00:00', '2024-09-25 17:00:00', 'Peppers', 'Jalapeño M', 'Arusha', 'Tanzania',
    6, 6, 4, 6, 6, 'Conical', 'Vigorous growth with strong branching',
    6, 6, 35.0, 6, 5, 6, 6, 6, 'High yield with excellent fruit quality',
    '{"bacterial_spot": {"resistance": 5, "notes": "Minimal infection despite high disease pressure"}, "powdery_mildew": {"resistance": 6, "notes": "Best performer in disease-prone block"}}'::jsonb
);

-- Trial 2: Jalapeño M - Maputo, Mozambique
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-07-20 07:30:00', '2024-11-05 16:30:00', 'Peppers', 'Jalapeño M', 'Maputo', 'Mozambique',
    5, 5, 3, 6, 5, 'Conical', 'Early canopy establishment',
    5, 5, 32.5, 5, 5, 6, 6, 6, 'Growth consistent with previous season trials',
    '{"anthracnose": {"resistance": 4, "notes": "Symptoms appeared late season only"}, "bacterial_spot": {"resistance": 5, "notes": "Manageable with standard spray program"}}'::jsonb
);

-- Trial 3: Jalapeño M - Cape Town, South Africa
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-08-05 08:00:00', '2024-11-20 17:00:00', 'Peppers', 'Jalapeño M', 'Cape Town', 'South Africa',
    6, 5, 5, 5, 6, 'Conical', 'Strong root system observed at 4 weeks',
    6, 6, 38.2, 6, 6, 6, 6, 6, 'Excellent uniformity with minimal culls',
    '{"phytophthora_blight": {"resistance": 5, "notes": "No symptoms observed throughout trial"}, "bacterial_wilt": {"resistance": 5, "notes": "Clean foliage maintained without intervention"}}'::jsonb
);

-- ============================================
-- PEPPERS - Variety: Sweet Banana
-- ============================================

-- Trial 1: Sweet Banana - Harare, Zimbabwe
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-07-01 07:30:00', '2024-10-15 16:30:00', 'Peppers', 'Sweet Banana', 'Harare', 'Zimbabwe',
    5, 5, 4, 5, 5, 'Elongated', 'Good leaf coverage protecting fruit from sun scald',
    5, 5, 65.0, 4, 5, 5, 5, 5, 'Consistent production throughout season',
    '{"bacterial_spot": {"resistance": 4, "notes": "Isolated patches, no major impact on yield"}, "anthracnose": {"resistance": 5, "notes": "Minor spotting, did not progress"}}'::jsonb
);

-- Trial 2: Sweet Banana - Lusaka, Zambia
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-08-10 08:00:00', '2024-11-25 17:00:00', 'Peppers', 'Sweet Banana', 'Lusaka', 'Zambia',
    4, 4, 4, 5, 4, 'Elongated', 'Standard growth pattern for variety type',
    4, 5, 62.5, 4, 4, 5, 5, 5, 'Responded well to pruning regime',
    '{"powdery_mildew": {"resistance": 4, "notes": "Manageable with standard spray program"}, "bacterial_spot": {"resistance": 4, "notes": "Symptoms appeared late season only"}}'::jsonb
);

-- ============================================
-- CUCUMBERS - Variety: Marketmore 76
-- ============================================

-- Trial 1: Marketmore 76 - Nairobi, Kenya
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-06-15 08:00:00', '2024-09-10 17:00:00', 'Cucumbers', 'Marketmore 76', 'Nairobi', 'Kenya',
    6, 6, 4, 5, 6, 'Cylindrical', 'Vigorous growth with excellent vine coverage',
    6, 6, 280.0, 6, 5, 6, 6, 6, 'High early yield with consistent fruit size',
    '{"powdery_mildew": {"resistance": 5, "notes": "Minimal infection despite high disease pressure"}, "downy_mildew": {"resistance": 6, "notes": "Best performer in disease-prone block"}}'::jsonb
);

-- Trial 2: Marketmore 76 - Arusha, Tanzania
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-07-05 07:30:00', '2024-09-30 16:30:00', 'Cucumbers', 'Marketmore 76', 'Arusha', 'Tanzania',
    5, 5, 4, 5, 5, 'Cylindrical', 'Well-balanced vegetative and reproductive growth',
    5, 6, 275.0, 5, 5, 6, 6, 6, 'Excellent uniformity with minimal culls',
    '{"powdery_mildew": {"resistance": 5, "notes": "No symptoms observed throughout trial"}, "anthracnose": {"resistance": 5, "notes": "Clean foliage maintained without intervention"}}'::jsonb
);

-- ============================================
-- CUCUMBERS - Variety: Straight Eight
-- ============================================

-- Trial 1: Straight Eight - Maputo, Mozambique
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-08-01 08:00:00', '2024-10-25 17:00:00', 'Cucumbers', 'Straight Eight', 'Maputo', 'Mozambique',
    5, 5, 3, 6, 5, 'Cylindrical', 'Good leaf coverage protecting fruit from sun scald',
    5, 5, 220.0, 5, 5, 6, 6, 6, 'Uniform fruit with good market size',
    '{"angular_leaf_spot": {"resistance": 4, "notes": "Isolated patches, no major impact on yield"}, "powdery_mildew": {"resistance": 5, "notes": "Minor spotting, did not progress"}}'::jsonb
);

-- Trial 2: Straight Eight - Cape Town, South Africa
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-09-10 07:30:00', '2024-12-05 16:30:00', 'Cucumbers', 'Straight Eight', 'Cape Town', 'South Africa',
    5, 4, 5, 4, 5, 'Cylindrical', 'Early canopy establishment',
    5, 5, 215.0, 5, 5, 6, 5, 6, 'Growth consistent with previous season trials',
    '{"downy_mildew": {"resistance": 4, "notes": "Manageable with standard spray program"}, "powdery_mildew": {"resistance": 4, "notes": "Symptoms appeared late season only"}}'::jsonb
);

-- Trial 3: Straight Eight - Harare, Zimbabwe
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-07-20 08:00:00', '2024-10-15 17:00:00', 'Cucumbers', 'Straight Eight', 'Harare', 'Zimbabwe',
    4, 5, 4, 5, 5, 'Cylindrical', 'Standard growth pattern for variety type',
    5, 5, 218.5, 5, 5, 6, 6, 5, 'Responded well to pruning regime',
    '{"bacterial_wilt": {"resistance": 4, "notes": "Symptoms appeared late season only"}, "anthracnose": {"resistance": 5, "notes": "Isolated patches, no major impact on yield"}}'::jsonb
);

-- ============================================
-- CUCUMBERS - Variety: Poinsett 76
-- ============================================

-- Trial 1: Poinsett 76 - Lusaka, Zambia
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-06-25 08:00:00', '2024-09-20 17:00:00', 'Cucumbers', 'Poinsett 76', 'Lusaka', 'Zambia',
    6, 6, 4, 6, 6, 'Cylindrical', 'Strong root system observed at 4 weeks',
    6, 6, 195.0, 6, 6, 6, 6, 6, 'Excellent uniformity with high marketable yield',
    '{"powdery_mildew": {"resistance": 6, "notes": "Excellent field tolerance"}, "downy_mildew": {"resistance": 6, "notes": "Best performer in disease-prone block"}}'::jsonb
);

-- Trial 2: Poinsett 76 - Nairobi, Kenya
INSERT INTO trials (
    start_date, end_date, category_name, variety, location, region,
    plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
    fruit_setting, fruit_shape, plant_notes,
    fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, fruit_calyx_quality,
    fruit_blotchy_ripening, fruit_macro_cracking, fruit_micro_cracking, fruit_notes,
    diseases
) VALUES (
    '2024-07-10 07:30:00', '2024-10-05 16:30:00', 'Cucumbers', 'Poinsett 76', 'Nairobi', 'Kenya',
    5, 6, 4, 5, 6, 'Cylindrical', 'Vigorous growth despite cooler temperatures',
    6, 5, 192.5, 5, 5, 6, 6, 6, 'High yield maintained throughout season',
    '{"angular_leaf_spot": {"resistance": 5, "notes": "No symptoms observed throughout trial"}, "powdery_mildew": {"resistance": 5, "notes": "Minimal infection despite high disease pressure"}}'::jsonb
);