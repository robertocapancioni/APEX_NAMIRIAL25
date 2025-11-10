create table d04_progetti
(
progetto_id number generated always as identity primary key,
codice_progetto varchar2(50) not null unique,
nome_progetto varchar2(200) not null,
data_inizio date,
data_fine date,
stato varchar2(30),
cliente varchar2(200),
creato_ts timestamp default systimestamp not null,
creato_da varchar2(100)
);

create table d04_attivita
(
attivita_id number generated always as identity primary key,
progetto_id number not null,
codice_attivita varchar2(50),
nome_attivita varchar2(200) not null,
descrizione varchar2(4000),
ore_pianificate number(9,2),
data_inizio date,
data_fine date,
stato varchar2(30),
creato_ts timestamp default systimestamp not null,
creato_da varchar2(100),
constraint d04_attivita_fk_progetto
foreign key (progetto_id)
references d04_progetti (progetto_id)
);

create table d04_collaboratori
(
collaboratore_id number generated always as identity primary key,
matricola varchar2(50) not null unique,
nome varchar2(100) not null,
cognome varchar2(100) not null,
email varchar2(200),
attivo_flag char(1) default 's' not null,
data_assunzione date,
creato_ts timestamp default systimestamp not null
);

create table d04_assegnazioni_attivita
(
assegnamento_id number generated always as identity primary key,
attivita_id number not null,
collaboratore_id number not null,
assegnato_da date,
assegnato_a date,
percentuale_allocazione number(5,2) not null ,
ruolo varchar2(100),
constraint d04_assegnazioni_fk_attivita
foreign key (attivita_id)
references d04_attivita (attivita_id),
constraint d04_assegnazioni_fk_collaboratore
foreign key (collaboratore_id)
references d04_collaboratori (collaboratore_id),
constraint d04_assegnazioni_uk
unique (attivita_id, collaboratore_id, assegnato_da)
);

create table d04_rendicontazioni_ore
(
rendiconto_id number generated always as identity primary key,
collaboratore_id number not null,
attivita_id number not null,
data_rendiconto date not null,
ore number(5,2) not null,
fatturabile_flag char(1) default 's' not null,
descrizione_lavoro varchar2(4000),
stato varchar2(30) ,
constraint d04_rendicontazioni_fk_collab
foreign key (collaboratore_id)
references d04_collaboratori (collaboratore_id),
constraint d04_rendicontazioni_fk_attivita
foreign key (attivita_id)
references d04_attivita (attivita_id),
constraint d04_rendicontazioni_ck_ore
check (ore > 0 and ore <= 24)
);

create index d04_idx_attivita_progetto
on d04_attivita (progetto_id);

create index d04_idx_assegnazioni_attivita
on d04_assegnazioni_attivita (attivita_id);

create index d04_idx_assegnazioni_collaboratore
on d04_assegnazioni_attivita (collaboratore_id);

create index d04_idx_rendicontazioni_collab_data
on d04_rendicontazioni_ore (collaboratore_id, data_rendiconto);

create index d04_idx_rendicontazioni_attivita_data
on d04_rendicontazioni_ore (attivita_id, data_rendiconto);
