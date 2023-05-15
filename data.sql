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

-- INSERT DATA TO VETS TABLE
INSERT INTO vets (NAME, AGE, DATE_OF_GRADUATION)
VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-4'),
('Jack Harkness', 38, '2008-06-08');

--Insert data to specialists
INSERT INTO SPECIALIZATIONS (SPECIES_ID, VETS_ID)
VALUES
((SELECT ID AS SPECIES_ID FROM SPECIES WHERE SPECIES.NAME='Pokemon'),
 (SELECT ID AS VETS_ID FROM VETS WHERE VETS.NAME='William Tatcher')
),
((SELECT ID AS SPECIES_ID FROM SPECIES WHERE SPECIES.NAME='Digimon'),
 (SELECT ID AS VETS_ID FROM VETS WHERE VETS.NAME='Stephanie Mendez')
),
((SELECT ID AS SPECIES_ID FROM SPECIES WHERE SPECIES.NAME='Pokemon'),
 (SELECT ID AS VETS_ID FROM VETS WHERE VETS.NAME='Stephanie Mendez')
),
((SELECT ID AS SPECIES_ID FROM SPECIES WHERE SPECIES.NAME='Digimon'),
 (SELECT ID AS VETS_ID FROM VETS WHERE VETS.NAME='Jack Harkness')
);


--INSERT DATA INTO VISITS TABLE
INSERT INTO VISITS
VALUES
((SELECT ID FROM ANIMALS WHERE NAME='Agumon'),(SELECT ID FROM VETS WHERE NAME='William Tatcher'),('2020-05-24')),
((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),
((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14'),
((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04'),
((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07'),
((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';