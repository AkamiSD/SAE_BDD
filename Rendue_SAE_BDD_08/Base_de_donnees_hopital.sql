CRÉER TABLE Médecin (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Nom TEXTE NON NULL,
  Position TEXTE NON NULL,
  SSN ENTIER NON NULL
);

Département CRÉER TABLE (
  DepartmentID INTEGER PRIMARY KEY NOT NULL,
  Nom TEXTE NON NULL,
  Tête ENTIER NON NULL
    CONTRAINTE fk_Physician_EmployeeID RÉFÉRENCES Médecin(EmployeeID)
);

CREATE TABLE Affilié_Avec (
  Médecin ENTIER NON NULL
    CONTRAINTE fk_Physician_EmployeeID RÉFÉRENCES Physician(EmployeeID),
  Département ENTIER NON NULL
    CONSTRAINT fk_Department_DepartmentID RÉFÉRENCES Département(DepartmentID),
  PrimaryAffiliation BOOLEAN NOT NULL,
  CLÉ PRIMAIRE (médecin, département)
);

Procédure CRÉER TABLE (
  Code INTEGER PRIMARY KEY NOT NULL,
  Nom TEXTE NON NULL,
  Coût RÉEL NON NULL
);

CRÉER TABLE Formé_In (
  Médecin ENTIER NON NULL
    CONTRAINTE fk_Physician_EmployeeID RÉFÉRENCES Physician(EmployeeID),
  Traitement ENTIER NON NUL
    CONTRAINTE fk_Procedure_Code REFERENCES Procédure(Code),
  CertificationDate DATETIME NON NULL,
  CertificationExpires DATETIME NOT NULL,
  CLÉ PRIMAIRE (médecin, traitement)
);

CRÉER TABLE Patient (
  SSN INTEGER PRIMARY KEY NOT NULL,
  Nom TEXTE NON NULL,
  Adresse TEXTE NON NULL,
  Téléphone TEXTE NON NULL,
  InsuranceID INTEGER NOT NULL,
  PCP ENTIER NON NULL
    CONTRAINTE fk_Physician_EmployeeID RÉFÉRENCES Médecin(EmployeeID)
);

CRÉER TABLE Infirmière (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Nom TEXTE NON NULL,
  Position TEXTE NON NULL,
  Enregistré BOOLEAN NOT NULL,
  SSN ENTIER NON NULL
);

CRÉER TABLE Rendez-vous (
  AppointmentID INTEGER PRIMARY KEY NOT NULL,
  Patient ENTIER NON NULL
    CONTRAINTE fk_Patient_SSN RÉFÉRENCES Patient(SSN),
  Infirmière préparatrice INTEGER
    CONTRAINTE fk_Nurse_EmployeeID RÉFÉRENCES Infirmière(EmployeeID),
  Médecin ENTIER NON NULL
    CONTRAINTE fk_Physician_EmployeeID RÉFÉRENCES Physician(EmployeeID),
  DATETIME de début NON NULL,
  Fin DATETIME NON NULL,
  ExaminationRoom TEXTE NON NULL
);

CRÉER TABLE Médicaments (
  Code INTEGER PRIMARY KEY NOT NULL,
  Nom TEXTE NON NULL,
  Marque TEXTE NON NULL,
  Description TEXTE NON NULL
);

CRÉER TABLE Prescrit (
  Médecin ENTIER NON NULL
    CONTRAINTE fk_Physician_EmployeeID RÉFÉRENCES Physician(EmployeeID),
  Patient ENTIER NON NULL
    CONTRAINTE fk_Patient_SSN RÉFÉRENCES Patient(SSN),
  Médicament ENTIER NON NULL
    CONTRAINTE fk_Medication_Code RÉFÉRENCES Médicament(Code),
  Date DATETIME NON NULLE,
  Rendez-vous INTEGER
    CONTRAINTE fk_Appointment_AppointmentID RÉFÉRENCES Rendez-vous(AppointmentID),
  Dose TEXTE NON NULL,
  CLÉ PRIMAIRE (médecin, patient, médicament, date)
);

Bloc CRÉER TABLE (
  Plancher ENTIER NON NULL,
  Code ENTIER NON NULL,
  CLÉ PRIMAIRE (Étage, Code)
);

CRÉER TABLE Salle (
  Nombre INTEGER PRIMARY KEY NOT NULL,
  Tapez TEXTE NON NULL,
  BlockFloor ENTIER NON NULL,
  BlockCode ENTIER NON NULL,
  Indisponible BOOLEAN NOT NULL,
  CLÉ ÉTRANGÈRE (BlockFloor, BlockCode) RÉFÉRENCES Bloc
);

CRÉER TABLE On_Call (
  Infirmière ENTIER NON NULL
    CONTRAINTE fk_Nurse_EmployeeID RÉFÉRENCES Infirmière(EmployeeID),
  BlockFloor ENTIER NON NULL,
  BlockCode ENTIER NON NULL,
  DATETIME de début NON NULL,
  Fin DATETIME NON NULL,
  CLÉ PRIMAIRE (Infirmière, BlockFloor, BlockCode, Début, Fin),
  CLÉ ÉTRANGÈRE (BlockFloor, BlockCode) RÉFÉRENCES Bloc
);

CRÉER TABLE Séjour (
  StayID INTEGER PRIMARY KEY NOT NULL,
  Patient ENTIER NON NULL
    CONTRAINTE fk_Patient_SSN RÉFÉRENCES Patient(SSN),
  Pièce ENTIER NON NULL
    CONSTRAINT fk_Room_Number RÉFÉRENCES Room(Number),
  DATETIME de début NON NULL,
  Fin DATETIME NON NULL
);

CRÉER TABLE Subit (
  Patient ENTIER NON NULL
    CONTRAINTE fk_Patient_SSN RÉFÉRENCES Patient(SSN),
  Procédure ENTIER NON NULL
    CONTRAINTE fk_Procedure_Code REFERENCES Procédure(Code),
  Rester ENTIER NON NULL
    CONTRAINTE fk_Stay_StayID RÉFÉRENCES Stay(StayID),
  Date DATETIME NON NULLE,
  Médecin ENTIER NON NULL
    CONTRAINTE fk_Physician_EmployeeID RÉFÉRENCES Physician(EmployeeID),
  Infirmière assistante INTEGER
    CONTRAINTE fk_Nurse_EmployeeID RÉFÉRENCES Infirmière(EmployeeID),
  CLÉ PRIMAIRE (Patient, Procédure, Séjour, Date)
);





INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Médecin traitant',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Chirurgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Chirurgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Psychiatre traitant',999999999);

INSERT INTO Department VALUES(1,'Médecine générale',4);
INSERT INTO Department VALUES(2,'Chirurgie',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

INSERT INTO Procedure VALUES(1,'Rhinopodoplastie inversée',1500.0);
INSERT INTO Procedure VALUES(2,'Recombobulation pylorique obtuse',3750.0);
INSERT INTO Procedure VALUES(3,'Démiophtalmectomie pliée',4500.0);
INSERT INTO Procedure VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Procedure VALUES(5,'Dermogastrotomie masquée',4899.0);
INSERT INTO Procedure VALUES(6,'Pancréomyoplastie réversible',5600.0);
INSERT INTO Procedure VALUES(7,'Follicular Demiectomy',25.0);

INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

INSERT INTO Nurse VALUES(101,'Carla Espinosa','Head Nurse',1,111111110);
INSERT INTO Nurse VALUES(102,'Laverne Roberts','Nurse',1,222222220);
INSERT INTO Nurse VALUES(103,'Paul Flowers','Infirmière',0,333333330);

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO Prescrit VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO Prescrit VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO Prescrit VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');

INSÉRER DANS LE BLOC VALEURS(1,1);
INSÉRER DANS LE BLOC VALEURS(1,2);
INSÉRER DANS LE BLOC VALEURS(1,3);
INSÉRER DANS LE BLOC VALEURS(2,1);
INSÉRER DANS LE BLOC VALEURS(2,2);
INSÉRER DANS LE BLOC VALEURS(2,3);
INSÉRER DANS LE BLOC VALEURS(3,1);
INSÉRER DANS LE BLOC VALEURS(3,2);
INSÉRER DANS LE BLOC VALEURS(3,3);
INSÉRER DANS LE BLOC VALEURS(4,1);
INSÉRER DANS LE BLOC VALEURS(4,2);
INSÉRER DANS LE BLOC VALEURS(4,3);

INSERT INTO Room VALUES(101,'Single',1,1,0);
INSERT INTO Room VALUES(102,'Single',1,1,0);
INSERT INTO Room VALUES(103,'Single',1,1,0);
INSERT INTO Room VALUES(111,'Single',1,2,0);
INSERT INTO Room VALUES(112,'Single',1,2,1);
INSERT INTO Room VALUES(113,'Single',1,2,0);
INSERT INTO Room VALUES(121,'Single',1,3,0);
INSERT INTO Room VALUES(122,'Single',1,3,0);
INSERT INTO Room VALUES(123,'Single',1,3,0);
INSERT INTO Room VALUES(201,'Single',2,1,1);
INSERT INTO Room VALUES(202,'Single',2,1,0);
INSERT INTO Room VALUES(203,'Single',2,1,0);
INSERT INTO Room VALUES(211,'Single',2,2,0);
INSERT INTO Room VALUES(212,'Single',2,2,0);
INSERT INTO Room VALUES(213,'Single',2,2,1);
INSERT INTO Room VALUES(221,'Single',2,3,0);
INSERT INTO Room VALUES(222,'Single',2,3,0);
INSERT INTO Room VALUES(223,'Single',2,3,0);
INSERT INTO Room VALUES(301,'Single',3,1,0);
INSERT INTO Room VALUES(302,'Single',3,1,1);
INSERT INTO Room VALUES(303,'Single',3,1,0);
INSERT INTO Room VALUES(311,'Single',3,2,0);
INSERT INTO Room VALUES(312,'Single',3,2,0);
INSERT INTO Room VALUES(313,'Single',3,2,0);
INSERT INTO Room VALUES(321,'Single',3,3,1);
INSERT INTO Room VALUES(322,'Single',3,3,0);
INSERT INTO Room VALUES(323,'Single',3,3,0);
INSERT INTO Room VALUES(401,'Single',4,1,0);
INSERT INTO Room VALUES(402,'Single',4,1,1);
INSERT INTO Room VALUES(403,'Single',4,1,0);
INSERT INTO Room VALUES(411,'Single',4,2,0);
INSERT INTO Room VALUES(412,'Single',4,2,0);
INSERT INTO Room VALUES(413,'Single',4,2,0);
INSERT INTO Room VALUES(421,'Single',4,3,1);
INSERT INTO Room VALUES(422,'Single',4,3,0);
INSERT INTO Room VALUES(423,'Single',4,3,0);

INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO subit VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO subit VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO subit VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO subit VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO subit VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO subit VALUES(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');