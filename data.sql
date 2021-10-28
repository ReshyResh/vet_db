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
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg,owner_id) VALUES ('TEST', '1998-10-13', '3', '1', '17','5 ');


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

/* Add vets information */
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

/* Add specializations */
INSERT INTO specializations (vet_id, species_id) SELECT vets.id, species.id FROM vets JOIN species ON species.name = 'Pokemon' AND vets.name = 'William Tatcher';
INSERT INTO specializations (vet_id, species_id) SELECT vets.id, species.id FROM vets JOIN species ON species.name IN ('Pokemon','Digimon') AND vets.name = 'Stephanie Mendez';
INSERT INTO specializations (vet_id, species_id) SELECT vets.id, species.id FROM vets JOIN species ON species.name = 'Digimon' AND vets.name = 'Jack Harkness';

/* Add visits */
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'William Tatcher'),(SELECT animals.id FROM animals WHERE animals.name = 'Agumon'), '2020-05-24');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Stephanie Mendez'),(SELECT animals.id FROM animals WHERE animals.name = 'Agumon'), '2020-07-22');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Jack Harkness'),(SELECT animals.id FROM animals WHERE animals.name = 'Gabumon'), '2021-02-02');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Maisy Smith'),(SELECT animals.id FROM animals WHERE animals.name = 'Pikachu'), '2020-01-05');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Maisy Smith'),(SELECT animals.id FROM animals WHERE animals.name = 'Pikachu'), '2020-03-08');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Maisy Smith'),(SELECT animals.id FROM animals WHERE animals.name = 'Pikachu'), '2020-05-14');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Stephanie Mendez'),(SELECT animals.id FROM animals WHERE animals.name = 'Devimon'), '2021-05-04');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Jack Harkness'),(SELECT animals.id FROM animals WHERE animals.name = 'Charmander'), '2021-02-24');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Maisy Smith'),(SELECT animals.id FROM animals WHERE animals.name = 'Plantmon'), '2019-12-21');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'William Tatcher'),(SELECT animals.id FROM animals WHERE animals.name = 'Plantmon'), '2019-08-10');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Maisy Smith'),(SELECT animals.id FROM animals WHERE animals.name = 'Plantmon'), '2021-04-07');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Stephanie Mendez'),(SELECT animals.id FROM animals WHERE animals.name = 'Squirtle'), '2019-09-29');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Jack Harkness'),(SELECT animals.id FROM animals WHERE animals.name = 'Angemon'), '2020-10-03');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Jack Harkness'),(SELECT animals.id FROM animals WHERE animals.name = 'Angemon'), '2020-11-04');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Maisy Smith'),(SELECT animals.id FROM animals WHERE animals.name = 'Boarmon'), '2019-01-24');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Maisy Smith'),(SELECT animals.id FROM animals WHERE animals.name = 'Boarmon'), '2019-05-15');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Maisy Smith'),(SELECT animals.id FROM animals WHERE animals.name = 'Boarmon'), '2020-02-27');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Maisy Smith'),(SELECT animals.id FROM animals WHERE animals.name = 'Boarmon'), '2019-08-03');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'Stephanie Mendez'),(SELECT animals.id FROM animals WHERE animals.name = 'Blossom'), '2020-06-24');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES ((SELECT vets.id FROM vets WHERE vets.name = 'William Tatcher'),(SELECT animals.id FROM animals WHERE animals.name = 'Squirtle'), '2021-01-11');
