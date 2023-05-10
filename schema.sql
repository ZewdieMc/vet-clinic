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

ALTER TABLE animals ADD species VARCHAR(50);

--Create a table named owners with the following columns
CREATE TABLE owners (ID INT GENERATED ALWAYS AS IDENTITY, FULL_NAME VARCHAR(100), AGE INT NOT NULL, PRIMARY KEY(ID));

--Create a table named species
CREATE TABLE species (ID INT GENERATED ALWAYS AS IDENTITY, NAME VARCHAR(100), PRIMARY KEY(ID));

--Remove species column from animals table
ALTER TABLE ANIMALS DROP species;

--In animals table, add column species_id which is a foreign key referencing species table
ALTER TABLE ANIMALS ADD species_id INT, ADD CONSTRAINT  FK_SPECIES FOREIGN KEY(species_id) REFERENCES species(ID);

--In animals table, add column owner_id which is a foreign key referencing owners table
ALTER TABLE ANIMALS ADD owner_id INT, ADD CONSTRAINT animal_fk FOREIGN KEY(owner_id) REFERENCES owners(ID);

--Create a table named vets
CREATE TABLE VETS (ID INT GENERATED ALWAYS AS IDENTITY, NAME VARCHAR(100), AGE INT, DATE_OF_GRADUATION DATE);