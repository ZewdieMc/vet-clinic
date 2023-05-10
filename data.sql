/* Populate database with sample data. */

--insert animals into animals table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES
    ('Agumon', '2020-02-03', 0, TRUE, 10.23),
    ('Gabumon', '2018-11-15', 2, TRUE, 8),
    ('Pikachu', '2021-01-07', 1, FALSE, 15.04),
    ('Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Charmander', '2020-02-8', 0, FALSE, -11),
    ('Plantmon', '2021-11-15', 2, TRUE, -5.7),
    ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
    ('Angemon', '2005-06-12', 1, TRUE, -45),
    ('Boarmon', '2005-06-07', 7, TRUE, 20.4),
    ('Blossom', '1998-10-13', 3, TRUE, 17),
    ('Ditto', '2022-05-14', 4, TRUE, 22);

    --insert data into the owners table
INSERT INTO OWNERS (full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

--Insert data into species table
INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');

--Add values to foreign keys in the animals table.
UPDATE ANIMALS
SET SPECIES_ID=CASE
WHEN(NAME LIKE '%mon')
THEN (SELECT ID FROM species WHERE name='Digimon')
ELSE (SELECT ID FROM species WHERE name='Pokemon')
END;

--Modify animals to include owner information (owner_id)
UPDATE ANIMALS
SET OWNER_ID=CASE
WHEN(NAME='Agumon') THEN (SELECT ID FROM owners WHERE FULL_NAME='Sam Smith')
WHEN(NAME IN('Gabumon','Pikachu')) THEN (SELECT ID FROM owners WHERE FULL_NAME='Jennifer Orwell')
WHEN(NAME IN('Devimon','Plantmon')) THEN (SELECT ID FROM owners WHERE FULL_NAME='Bob')
WHEN(NAME IN('Charmander', 'Squirtle','Blossom')) THEN (SELECT ID FROM owners WHERE FULL_NAME='Melody Pond')
WHEN(NAME IN('Angemon', 'Boarmon')) THEN (SELECT ID FROM owners WHERE FULL_NAME='Dean Winchester')
ELSE NULL
END;