DROP TABLE IF EXISTS auteur;
CREATE TABLE auteur (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL
) ENGINE=InnoDB;
SHOW TABLES;
-- etape 7 
CREATE TABLE ouvrage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(200) NOT NULL,
    disponible BOOLEAN NOT NULL DEFAULT TRUE,
    auteur_id INT NOT NULL,
    CONSTRAINT fk_ouvrage_auteur
    FOREIGN KEY (auteur_id)
    REFERENCES auteur(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

SHOW TABLES;
-- etape 8
CREATE TABLE abonné (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
) ENGINE=InnoDB;
-- etape 9
CREATE TABLE emprunt (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ouvrage_id INT NOT NULL,
    abonne_id INT NOT NULL,
    date_debut DATE NOT NULL DEFAULT (CURRENT_DATE()),
    date_fin DATE,
    CONSTRAINT fk_emprunt_ouvrage
        FOREIGN KEY (ouvrage_id)
        REFERENCES ouvrage(id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_emprunt_abonne
        FOREIGN KEY (abonne_id)
        REFERENCES abonné(id)
        ON DELETE CASCADE,
    CONSTRAINT ck_date_emprunt
        CHECK (date_fin IS NULL OR date_fin >= date_debut)
) ENGINE=InnoDB;
SHOW TABLES;

ALTER TABLE ouvrage ADD INDEX (disponible);
ALTER TABLE emprunt ADD INDEX (date_fin);


INSERT INTO emprunt (ouvrage_id, abonne_id, date_debut, date_fin)
VALUES (1, 999, '2024-01-01', '2024-01-15');

INSERT INTO emprunt (ouvrage_id, abonne_id, date_debut, date_fin)
VALUES (1, 1, '2024-01-10', '2024-01-01');


-- Tests des contraintes 
/*
INSERT INTO auteur (nom) VALUES ('Auteur Test');
SET @auteur_id = LAST_INSERT_ID();
INSERT INTO ouvrage (titre, auteur_id) VALUES ('Livre Test', @auteur_id);

SELECT 'Avant suppression - Livre existe:' as Test, COUNT(*) as Nombre
FROM ouvrage WHERE titre = 'Livre Test';

DELETE FROM auteur WHERE id = @auteur_id;

SELECT 'Après suppression - Livre existe:' as Test, COUNT(*) as Nombre  
FROM ouvrage WHERE titre = 'Livre Test';
*/