/* Data inserted into the animals table */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', '0', '1', '10.23');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2020-01-07', '1', '0', '15.04');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', '5', '1', '11');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', '0', '0', '-11');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2020-11-15', '2', '1', '-5.7');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', '3', '0', '-12.13');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', '1', '1', '-45');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', '7', '1', '20.4');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', '3', '1', '17');

/* Data inserted into the owners table */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', '34');
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', '19');
INSERT INTO owners (full_name, age) VALUES ('Bob', '45');
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', '77');
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', '14');
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', '38');

/* Data inserted into the species table */
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/* Modify your inserted animals so it includes the species_id value:

    2 If the name ends in "mon" it will be Digimon
    All other animals are Pokemon */
    UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
    UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

/* Modify your inserted animals to include owner information (owner_id) */
BEGIN;
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon','Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon','Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander','Squirtle','Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon','Boarmon'); 
