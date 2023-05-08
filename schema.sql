/* Database schema to keep the structure of entire database. */

--CREATE animals TABLE
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(4, 2),
    PRIMARY KEY(id)
);
