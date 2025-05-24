CREATE TABLE Bloc ( Nombre INTEGER PRIMARY KEY NOT NULL , 
Tapez TEXT NOT NULL , 
BlockFloor INTEGER NOT NULL , 
BlockCode INTEGER NOT NULL , 
Indisponible BOOLEAN NOT NULL , 
FOREIGN KEY (BlockFloor, BlockCode) REFERENCES Bloc ); 
CREATE TABLE On_Call ( Infirmière INTEGER NOT NULL CONSTRAINT fk_Nurse_EmployeeID REFERENCES Infirmière(EmployeeID), 
BlockFloor INTEGER NOT NULL , 
BlockCode INTEGER NOT NULL , 
Début TIMESTAMP NOT NULL , 
Fin TIMESTAMP NOT NULL , 
PRIMARY KEY (Infirmière, BlockFloor, BlockCode, Début, Fin), FOREIGN KEY (BlockFloor, BlockCode) REFERENCES Bloc ); 
CREATE TABLE Séjour ( StayID INTEGER PRIMARY KEY NOT NULL , 
Patient INTEGER NOT NULL CONSTRAINT fk_Patient_SSN REFERENCES Patient(SSN), 
Pièce INTEGER NOT NULL CONSTRAINT fk_Room_Number REFERENCES Room(Number), 
Début TIMESTAMP NOT NULL , Fin TIMESTAMP NOT NULL ); 
CREATE TABLE Subit ( Patient INTEGER NOT NULL CONSTRAINT fk_Patient_SSN REFERENCES Patient(SSN), 
Procédure INTEGER NOT NULL CONSTRAINT fk_Procedure_Code REFERENCES Procédure(Code), 
Rester INTEGER NOT NULL CONSTRAINT fk_Stay_StayID REFERENCES Stay(StayID), 
Date TIMESTAMP NOT NULL , 
Médecin INTEGER NOT NULL CONSTRAINT fk_Physician_EmployeeID REFERENCES Physician(EmployeeID), 
Infirmière_assistante INTEGER CONSTRAINT fk_Nurse_EmployeeID REFERENCES Infirmière(EmployeeID), PRIMARY KEY (Patient, Procédure, Rester, Date ) );
CREATE ROLE medecin LOGIN PASSWORD 'medecin_password';
CREATE ROLE admin LOGIN PASSWORD 'admin_password';
CREATE ROLE visiteur LOGIN PASSWORD 'visiteur_password';
CREATE USER medecin_user AVEC LE ROLE medecin ;
CREATE USER utilisateur_admin AVEC ROLE admin ;
CREATE USER visiteur_user WITH ROLE visiteur;
CRÉER UN RÔLE analyste ;
CRÉER UN RÔLE personnel_soignant ;
CRÉER RÔLE gestionnaire ;
GRANT SELECT ON Séjour TO analyste;
GRANT SELECT, INSERT, UPDATE ON Subit TO personnel_soignant ;
ACCORDER TOUS LES PRIVILÈGES SUR Bloc AU gestionnaire ;
ALTER ROLE medecin_user SET ROLE medecin, analyste;
ALTER ROLE utilisateur_admin SET ROLE admin, gestionnaire ;
ALTER ROLE visiteur_user SET ROLE visiteur;
GRANT analyste TO personnel_soignant;
GRANT gestionnaire À analyste;
GRANT SELECT ON Bloc TO analyste;
GRANT SELECT, INSERT, UPDATE ON On_Call TO personnel_soignant ;
ACCORDER TOUS LES PRIVILÈGES SUR Séjour AU gestionnaire ;