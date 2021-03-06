/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-12';

SELECT name FROM animals WHERE neutered = '1' AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT name FROM animals WHERE neutered = '1';

SELECT name FROM animals WHERE name != 'Gabumon';

SELECT name FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. 
Then roll back the change and verify that species columns went back to the state before tranasction. */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

/* Inside a transaction:
   -Update the animals table by setting the species column to digimon for all animals that have a name ending in mon */ 
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT name, species FROM animals;
/* -Update the animals table by setting the species column to pokemon for all animals that don't have species already set. */
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT name, species FROM animals;
/* Commit the transaction */
COMMIT;

/* Inside a transaction delete all records in the animals table, then roll back the transaction. */
BEGIN;
DELETE FROM animals;
ROLLBACK;

/* Inside a transaction:
     Delete all animals born after Jan 1st, 2022. */
     BEGIN;
     DELETE FROM animals WHERE date_of_birth > '2022-01-01';
/*   Create a savepoint for the transaction. */
     SAVEPOINT sp1;
/*   Update all animals' weight to be their weight multiplied by -1. */
     UPDATE animals SET weight_kg = weight_kg * -1;
/*   Rollback to the savepoint */
     ROLLBACK TO sp1;
/*   Update all animals' weights that are negative to be their weight multiplied by -1. */
     UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
/*   Commit the transaction */
     COMMIT;
/*   Verify */
     SELECT * FROM animals;


/* Write queries to answer the following questions:
     How many animals are there? */
     SELECT COUNT(*) FROM animals;
/*   How many animals have never tried to escape? */
     SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
/*   What is the average weight of animals? */
     SELECT AVG(weight_kg) FROM animals;
/*   Who escapes the most, neutered or not neutered animals? */
     SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
/*   What is the minimum and maximum weight of each type of animal? */
     SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
/*   What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
     SELECT species, AVG(escape_attempts) AS Average FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species; 

/* What animals belong to Melody Pond? */
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name FROM animals JOIN species ON animals.species_id = 1;
/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT owners.full_name AS OwnerName, animals.name AS AnimalName FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;
/* How many animals are there per species? */
SELECT COUNT(*), species.name FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
/* List all Digimon owned by Jennifer Orwell. */
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = (SELECT id FROM species WHERE name = 'Digimon');
OR 
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = 2;
/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
/* Who owns the most animals? */
SELECT owners.full_name, COUNT(animals.name) FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.name) DESC LIMIT 1;

SELECT COUNT(animals.name), owners.full_name 
FROM animals 
JOIN owners 
ON animals.owner_id = owners.id 
GROUP BY owners.full_name
HAVING COUNT(animals.name) = (
     SELECT MAX(myf.count) FROM (SELECT COUNT(animals.name), owners.full_name 
     FROM animals 
     JOIN owners 
     ON animals.owner_id = owners.id 
     GROUP BY owners.full_name) AS myf
);

/* Who was the last animal seen by William Tatcher? */
SELECT animals.name, visits.date_of_visit
FROM animals
JOIN visits ON animals.id = visits.animal_id
WHERE visits.vet_id = (
    SELECT id
    FROM vets
    WHERE name = 'William Tatcher'
)
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/* How many different animals did Stephanie Mendez see? */
SELECT COUNT(animals.name)
FROM animals
JOIN visits ON animals.id = visits.animal_id
WHERE visits.vet_id = (
    SELECT id
    FROM vets
    WHERE name = 'Stephanie Mendez'
 )

 /* List all vets and their specialties, including vets with no specialties. */
 SELECT vets.name AS VetName, species.name AS SpeciesName 
 FROM specializations 
 JOIN vets ON vets.id = specializations.vet_id 
 JOIN species ON species.id = specializations.species_id;

 /* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
 SELECT animals.name 
 FROM animals 
 JOIN visits ON visits.animal_id = animals.id 
 WHERE date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' 
 AND visits.vet_id = (
      SELECT id 
      FROM vets 
      WHERE name = 'Stephanie Mendez'
);

/* What animal has the most visits to vets? */
SELECT COUNT(animals.name), animals.name 
FROM animals 
JOIN visits 
ON visits.animal_id = animals.id 
GROUP BY animals.name
HAVING COUNT(animals.name) = (
     SELECT MAX(myf.count) FROM (SELECT COUNT(animals.name), animals.name
     FROM animals 
     JOIN visits 
     ON visits.animal_id = animals.id 
     GROUP BY animals.name) AS myf
);

/* Who was Maisy Smith's first visit? */
SELECT animals.name, visits.date_of_visit
FROM animals
JOIN visits ON animals.id = visits.animal_id
WHERE visits.vet_id = (
    SELECT id
    FROM vets
    WHERE name = 'Maisy Smith'
)
ORDER BY visits.date_of_visit ASC
LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT * FROM animals 
JOIN visits 
ON animals.id = visits.animal_id 
ORDER BY visits.date_of_visit DESC 
LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(*) 
FROM visits 
JOIN vets ON vets.id = visits.vet_id 
JOIN animals ON animals.id = visits.animal_id 
JOIN specializations ON vets.id = specializations.vet_id 
WHERE animals.species_id != specializations.species_id;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT COUNT(animals.species_id),species.name
FROM visits 
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE visits.vet_id = (
     SELECT id FROM vets WHERE name = 'Maisy Smith'
)
GROUP BY species.name;





