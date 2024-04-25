-- Create the sepia table
CREATE TABLE sepia (
    id SERIAL PRIMARY KEY,
    weight FLOAT,
    length FLOAT,
    sex CHAR(1)
);

-- Insert some demo data
INSERT INTO sepia (weight, length, sex) VALUES (45.0, 16.1, 'M');
INSERT INTO sepia (weight, length, sex) VALUES (32.0, 12.9, 'F');
INSERT INTO sepia (weight, length, sex) VALUES (38.5, 14.3, 'M');
INSERT INTO sepia (weight, length, sex) VALUES (28.7, 11.6, 'F');
INSERT INTO sepia (weight, length, sex) VALUES (42.0, 15.1, 'M');
