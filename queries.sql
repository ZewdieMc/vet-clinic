/*Queries that provide answers to the questions from all projects.*/

--list all animals having name that ends with mon.
SELECT * FROM animals WHERE name LIKE '%mon';

--list name of animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth  BETWEEN '2016-01-01' and '2019-12-31';

--List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts < 3;

--List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

--List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

--Find all animals that are neutered
SELECT * FROM animals WHERE neutered=TRUE;

--Find all animals not named Gabumon
SELECT * FROM animals WHERE name !='Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- begin transaction
BEGIN;
--pdate the animals table by setting the species column to unspecified
UPDATE animals SET species='unspecified';
--RoLLback the transaction
ROLLBACK;

--BEGIN TRANSACTION
BEGIN;
--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';

--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species='pokemon' WHERE species IS NULL;

--VERIFY CHANGES WERE MADE
SELECT * FROM animals;

--COMMIT TRANSACTION
COMMIT;

--Verify that changes persist after commit.
SELECT * FROM animals;

-- DELETE ALL RECORDS IN THE ANIMALS TABLE
DELETE FROM animals;

--ROLLBACK
ROLLBACK;

--BEGIN TRANSACTION
BEGIN;
--Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

--Create a savepoint
SAVEPOINT delete_young;

--Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg*-1;

--ROLLBACK TO THE SAVEPOINT
ROLLBACK TO delete_young;

--Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg < 0;

--COMMIT TRANSACTION
COMMIT;

--How many animals are there?
SELECT COUNT(*) FROM animals;

--How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts=0;

--What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- who escaped the most, neutered or not neutered?
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered;

--What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg) AS MAX_WEIGHT, MIN(weight_kg) AS MIN_WEIGHT FROM animals GROUP BY species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;

--What animals belong to Melody Pond?
SELECT NAME FROM ANIMALS JOIN OWNERS ON ANIMALS.OWNER_ID=OWNERS.ID WHERE OWNERS.FULL_NAME='Melody Pond';

--