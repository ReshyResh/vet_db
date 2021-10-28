/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id              INT,
  name            VARCHAR(100),
  date_of_birth   DATE,
  escape_attempts INT,
  neutered        BIT,
  weight_kg 	  DECIMAL
);

/* Add table */
ALTER TABLE animals ADD species VARCHAR(100);

/* Create a table named owners with the following columns: id, full_name, age  */

CREATE TABLE owners(
  id              INT GENERATED ALWAYS AS IDENTITY,
  full_name       VARCHAR(100),
  age             INT,
  PRIMARY KEY (id)
);

/* Create a table named species with the following columns:  id, name */
CREATE TABLE species(
  id              INT GENERATED ALWAYS AS IDENTITY,
  name            VARCHAR(100),
  PRIMARY KEY (id)
);

/* Modify animals table:

    Make sure that id is set as autoincremented PRIMARY KEY */
    BEGIN;
    ALTER TABLE animals DROP COLUMN id;
    ALTER TABLE animals ADD id INT GENERATED ALWAYS AS IDENTITY;
    COMMIT;
    /* Remove column species */
    ALTER TABLE animals DROP COLUMN species;
    /* Add column species_id which is a foreign key referencing species table */
    ALTER TABLE animals ADD species_id INT;
    ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
    /* Add column owner_id which is a foreign key referencing the owners table */
    ALTER TABLE animals ADD owner_id INT;
    ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

/* Create a table named vets */
CREATE TABLE vets(
  id                  INT GENERATED ALWAYS AS IDENTITY,
  name                VARCHAR(100),
  age                 INT,
  date_of_graduation DATE,
  PRIMARY KEY (id)
);

/* Create join table for vets to species many to many relationship */
CREATE TABLE specializations (
	vet_id INT REFERENCES vets(id),
	species_id INT REFERENCES species(id)
);

/* Create join table for animals-vets many to many relationship */
CREATE TABLE visits (
	vet_id INT REFERENCES vets (id),
	animal_id INT REFERENCES animals (id),
	date_of_visit DATE
);