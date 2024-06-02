DROP database IF EXISTS GeekFactoryDB;
CREATE database GeekFactoryDB;

USE GeekFactoryDB;

DROP TABLE IF EXISTS UserAccount;
CREATE TABLE UserAccount
(
    email varchar(50) PRIMARY KEY NOT NULL,
    passwordUser varchar(64) NOT NULL,
    nome varchar(50) NOT NULL,
    cognome varchar(50) NOT NULL,
    indirizzo varchar(50) NOT NULL,
    telefono varchar(15) NOT NULL,
    numero char(16) NOT NULL,
    intestatario varchar(50) NOT NULL,
    CVV char(3) NOT NULL,
    ruolo varchar(16) NOT NULL DEFAULT 'registeredUser'
);

DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente
(
    email varchar(50) PRIMARY KEY NOT NULL,
    FOREIGN KEY(email) REFERENCES UserAccount(email) ON UPDATE cascade ON DELETE cascade
);

DROP TABLE IF EXISTS Venditore;
CREATE TABLE Venditore
(
    email varchar(50) PRIMARY KEY NOT NULL,
    feedback int DEFAULT NULL,
    FOREIGN KEY(email) REFERENCES UserAccount(email) ON UPDATE cascade ON DELETE cascade
);

DROP TABLE IF EXISTS Tipologia;
CREATE TABLE Tipologia
(
    nome ENUM('Arredamento Casa','Action Figures','Gadget') PRIMARY KEY NOT NULL
);

DROP TABLE IF EXISTS Prodotto;
CREATE TABLE Prodotto
(
    codice int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome varchar(50) NOT NULL,
    descrizione text NOT NULL,
    deleted BOOL NOT NULL DEFAULT false,
    prezzo double(10,2) NOT NULL,
    model varchar(200) NOT NULL,
    speseSpedizione double(5,2) DEFAULT 0,
    emailVenditore varchar(50) NOT NULL,
    tag ENUM('Manga/Anime', 'Film/Serie TV', 'Videogiochi', 'Originali') NOT NULL,
    nomeTipologia ENUM('Arredamento Casa','Action Figures','Gadget') NOT NULL,
    dataAnnuncio date NOT NULL,
    FOREIGN KEY(emailVenditore) REFERENCES Venditore(email) ON UPDATE cascade ON DELETE cascade,
    FOREIGN KEY(nomeTipologia) REFERENCES Tipologia(nome) ON UPDATE cascade ON DELETE cascade
)ENGINE=InnoDB AUTO_INCREMENT=1000;

DROP TABLE IF EXISTS Ordine;
CREATE TABLE Ordine
(
    codiceOrdine int NOT NULL AUTO_INCREMENT,
    codiceProdotto int NOT NULL,
    emailCliente varchar(50) NOT NULL,
    prezzoTotale double(10,2) NOT NULL,
    quantity int NOT NULL,
    dataAcquisto date NOT NULL,
    PRIMARY KEY(codiceOrdine,codiceProdotto),
    FOREIGN KEY(codiceProdotto) REFERENCES Prodotto(codice) ON UPDATE cascade ON DELETE cascade,
    FOREIGN KEY(emailCliente) REFERENCES Cliente(email) ON UPDATE cascade ON DELETE cascade
)ENGINE=InnoDB AUTO_INCREMENT=100;

DROP TABLE IF EXISTS Recensione;
CREATE TABLE Recensione
(
    codiceRecensione int NOT NULL AUTO_INCREMENT,
    codiceProdotto int NOT NULL,
    emailCliente varchar(50) NOT NULL,
    votazione tinyint unsigned NOT NULL,
    testo text,
    dataRecensione date NOT NULL,
    PRIMARY KEY(codiceRecensione,codiceProdotto),
    FOREIGN KEY(codiceProdotto) REFERENCES Prodotto(codice) ON UPDATE cascade ON DELETE cascade,
    FOREIGN KEY(emailCliente) REFERENCES Cliente(email) ON UPDATE cascade ON DELETE cascade
);

DROP TABLE IF EXISTS Preferiti;
CREATE TABLE Preferiti
(
    codiceProdotto int NOT NULL,
    emailCliente varchar(50) NOT NULL,
    PRIMARY KEY(codiceProdotto,emailCliente),
    FOREIGN KEY(codiceProdotto) REFERENCES Prodotto(codice) ON UPDATE cascade ON DELETE cascade,
    FOREIGN KEY(emailCliente) REFERENCES Cliente(email) ON UPDATE cascade ON DELETE cascade
);

USE GeekFactoryDB;

/* begin data population */

/* accountuser data */
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV, ruolo)
VALUES ('geekfactory@gmail.com', SHA2('12345678', 256), 'Geek', 'Factory', 'Unisa, Dipartimento Informatica', '3476549862', '5436724598431234', 'GeekFactory', '476', 'admin');
INSERT INTO UserAccount (email, passwordUser, nome, cognome, indirizzo, telefono, numero, intestatario, CVV)
VALUES ('mariorossi@gmail.com', SHA2('12345678', 256), 'Mario', 'Rossi', 'Caserta, Via Lazio 14', '3476549862', '5436724598431234', 'Mario Rossi', '476'); 
-- altri inserimenti omessi per brevità

/* end data population */