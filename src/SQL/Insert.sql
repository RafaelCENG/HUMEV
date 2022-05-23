SET SQL_SAFE_UPDATES = 0;
DELETE FROM company;
DELETE FROM users;
DELETE FROM manager;
DELETE FROM evaluator;
DELETE FROM antikeim;
DELETE FROM employee;
DELETE FROM degree;
DELETE FROM has_degree;
DELETE FROM job;
DELETE FROM project;
DELETE FROM languages;
DELETE FROM requestevaluation;
DELETE FROM TempResult;
DELETE FROM needs;
DELETE FROM manager_rep;


ALTER TABLE evaluationresult AUTO_INCREMENT=1;
ALTER TABLE TempResult AUTO_INCREMENT=1;
ALTER TABLE job AUTO_INCREMENT=1;

INSERT INTO company VALUES
('AB1234','PATRAS','CEIDLTD',8438284,'Kolokotroni',12,'Patra','Greece'),
('AC1213','ATHINAS','OPAP',69234382,'Ag.Nikolaou',11,'Athina','Greece'),
('SASD12','LAMIAS','FOODL',6984234,'Korinthou',1,'Lamia','Greece'),
('B12352','PATRAS','CLOTHES',69312284,'Riga',4,'Patra','Greece'),
('DA1233','PATRAS','MYSQL',69835284,'Kolokotroni',3,'Patra','Greece'),
('023453344', 'C Patras', 'EXPENDITURE Ltd', 26102521, 'Maizonos', 123, 'Patra', 'Greece'), 
('023451232', 'A Patras', 'Typology Ltd', 26102352, 'Korinthou', 56, 'Patra', 'Greece'),
('123432211', 'A Geraka', 'SoftSol A.E.', 21032133, 'Ahepa', 44, 'Athina', 'Greece'), 
('18765549', 'C Peiraia', 'Unigram', 21034572, 'Karaiskaki', 10, 'Peiraias', 'Greece'),
('561234561', 'GS 35321 L', 'InCodeWeTrust', 12445612, 'Oxford', 12, 'London', 'United Kingdom'), 
('23122345', 'SF 1234 BG', 'SocialSc', 3200151, 'General Sklevi', 35, 'Sofia', 'Bulgaria');

INSERT INTO users VALUES
('Strike','strike123','Giannis','Nicolaou','rnicolaouceng@gmail.com','Employee'),
('Fidiascy','fidias123','Fidias','Gedeon','fidgedeon@gmail.com','Manager'),
('Legend','legend123','Antonis','legendaros','lengedeon@gmail.com','Manager'),
('Rafael','rafael123','Rafail','Nicolaou','helloworld@yahoo.com','Employee'),
('cleogeo', 'upL34r', 'Cleomenis', 'Georgiadis', 'cleom17@gmail.com','Employee'),
('zazahir23', 'zoolhger', 'Ahmet', 'Mobasher-Hirs', 'ahmetTech@yahoo.com','Employee'),
('lionarF', 'erg2378', 'Freddy', 'Lionar', 'Lionarfre@ezra.co.uk','Employee'),
('liagourma', 'sionpass', 'Maria', 'Liagkoumi', 'mliagkr@gmail.com','Employee'),
('mnikol', 'm@n0lis', 'Manolis', 'Nikopoloulos',  'nikolp@gmail.com','Employee'),
('abrown', 'w1lcoxon', 'Andrew', 'McBrown',  'andrewbr@yahoo.com','Employee'),
('Str', 'strike123', 'Raf', 'Nik',  'str@yahoo.com','Administrator'),
/* add EVALUATORS */
('Ody','ody123','Odyseas','Demetriou','odisseascyprus@gmail.com','Evaluator'),
('msmith', 'we3wd', 'Mike', 'Smith',  'smithm@unigram.com','Evaluator'),
('varcon82', 'gotop@s$', 'Nick', 'Varcon','varcni@incode.com','Evaluator'),
('bettyg', 'jUn38@', 'Betty', 'Georgiou',  'georb@softsol.gr','Evaluator'),
('papad', 'pdfr45t', 'Kostas', 'Papadatos', 'georb@softsol.gr','Evaluator'),
('n_tri', 'grt12wX', 'Nikol', 'Triantou', 'triantou@typology.gr','Evaluator'),
('Giankost', 'jUn38@', 'Giannis', 'Kostoglou',  'kostog@typology.gr','Evaluator'),
('pavkie', 'julie79', 'Pavel', 'Skiev',  'pskiev@social-sc.bg','Evaluator');

INSERT INTO manager VALUES
('Fidiascy',12,'023453344'),
('Legend',10,'18765549');

INSERT INTO evaluator VALUES
('Ody',4,'AB1234'),
('msmith', 4, '18765549'),
('varcon82', 2 , '561234561'),
('bettyg', 6, '123432211'),
('papad', 5, '123432211'),
('n_tri', 8, '023451232'),
('Giankost', 8, '023451232'),
('pavkie', 10, '23122345');



INSERT INTO antikeim VALUES
('Computer Science', 'Root element, no more general antikeim', NULL),
('Databases', 'Level one element, child of Computer Science', 'Computer Science'),
('AI', 'Level one element, child of Computer Science', 'Computer Science'),
('Algorithms', 'Level one element, child of Computer Science', 'Computer Science'),
('Networking', 'Level one element, child of Computer Science', 'Computer Science'),
('Graphics', 'Level one element, child of Computer Science', 'Computer Science'),
('2D', 'Level two element, child of Graphics', 'Graphics'),
('3D', 'Level two element, child of Graphics', 'Graphics'),
('Animation', 'Level two element, child of Graphics', 'Graphics'),
('Programming', 'Level one element, child of Computer Science', 'Computer Science'),
('Web Programming', 'Level two element, child of Programming', 'Programming'),
('Mobile Apps', 'Level two element, child of Programming', 'Programming'),
('Relational DBs', 'Level two element, child of Databases', 'Databases'),
('Object-Oriented DBs', 'Level two element, child of Databases', 'Databases'),
('NoSQL DBs', 'Level two element, child of Databases', 'Databases'),
('Robotics', 'Level two element, child of AI', 'AI'),
('NLP', 'Level two element, child of AI', 'AI'),
('Information Retieval', 'Level three element, child of NLP', 'NLP'),
('Language analysis', ' Level three element, child of NLP', 'NLP'),
('Data structures', 'Level two element, child of Algorithms', 'Algorithms'),
('Complexity and Efficiency', 'Level two element, child of Algorithms', 'Algorithms'),
('Network setup and maintainance', 'Level two element, child of Networking', 'Networking'),
('Device connectivity', 'Level two element, child of Networking', 'Networking');

INSERT INTO employee VALUES
('Strike','good employee','sistatikestext','A cert','Peace Award','023453344','this is an interview'),
('cleogeo', 'Cleomenis is a secodary education graduate who has long work experience in web programming technologies (has worked for than 25 years in the field). He has been also certified as a CISCO security expert (CCIE Security) and an IT project manager (PMI Project Management Professional and Project Management Professional).', 'RecLetters.pdf', 'certifALL.pdf','Null','AB1234',null),
('zazahir23', 'Mr Mobasher is a highly skilled web programmer who also has experience in 2d and 3d graphics generation as well as animation rendering. Moreover he has long experience with design, development and administration of large scale DBs, mostly relational.', 'Mobasher_rec.pdf', 'Mobasher-certif.pdf','Null','AB1234',NULL),
('lionarF', 'Freddy is an experienced web programmer but has also worked on mobile apps development the last 5 years. He is a freelancer and can work from a distance. He can also manage 2d graphics and has long experience with DB scripting (My SQL, MariaDB, MS SQL Server and Oracle.', 'LionFr_letters.pdf', 'LionFR_cert.pdf','Best Employee Award','AB1234',NULL),
('liagourma', 'Mrs Liagkoumi has a long experience in NLP and more specifically Information Retrieval and has also long research background on both areas. In addition she has worked on large coprus datasets and data visualization algorithms.', 'lettersLiagk.pdf', 'trainingLiagk.pdf','Null','AB1234',NULL),
('mnikol', 'Mr Nikolopoulos holds a Computer Science diploma and an MSc and has long work experience in AI applications as well as Robotics. He has also managed large R&D projects in these domains and has teaching and research experience as well. Please refer to his referral letters for more details.','referralLetNikol.pdf','degreesAndCertNikol.pdf','Null','AB1234',NULL),
('abrown', 'Andrew has a strong theoretical background in Algorithms and Data Stuctures and has worked for more than a decade in a software house that specializes in high performance data management. He is well skilled in high complexity schemes and heavy load memory management.', 'lettersscannedMcBr.pdf', 'degrees-cert.pdf','Null','AB1234',NULL);

INSERT INTO languages VALUES
('Strike','EN,GR'),
('cleogeo', 'EN,SP,GR'),
('zazahir23', 'GR,EN'),
('lionarF', 'EN,FR'),
('liagourma', 'GR,EN'),
('mnikol', 'GR,FR'),
('abrown', 'EN,FR,SP');


INSERT INTO project VALUES
(NULL,'Strike',1,'google was created...','www.google.com'),
(NULL,'Strike',2,'google was created...','www.google.com'),
(NULL,'abrown', 1, 'Minimal examples of data structures and algorithms in Python', 'https://github.com/a_brown/algorithms'),
(NULL,'abrown', 2, 'Interactive Online Platform that Visualizes Algorithms from Code', 'https://github.com/a_brown/algorithm-visualizer'),
(NULL,'abrown', 3, 'Repository which contains links and resources on different topics of Computer Science', 'https://github.com/a_brown/AlgoWiki'),
(NULL,'mnikol', 1, 'Essential Cheat Sheets for deep learning and machine learning researchers', 'https://github.com/nikolo0p/cheatsheets-ai'),
(NULL,'mnikol', 2, 'Python sample codes for robotics algorithms.', 'https://github.com/nikolo0p/PythonRobotics'),
(NULL,'zazahir23',1,'Go Graphics - 2D rendering in Go with a simple API.','https://github.com/mob@s/gg'),
(NULL,'zazahir23',2,'Draco is a library for compressing and decompressing 3D geometric meshes and point clouds.','https://github.com/mob@s/draco'),
(NULL,'zazahir23',3,'Data Discovery and Lineage for Big Data Ecosystem.','https://github.com/linkedin/WhereHows'),
(NULL,'lionarF', 1, 'HTML5 Mobile App UI templates created using Intel App Framework.', 'https://github.com/lionarGF/appframework-templates'),
(NULL,'lionarF', 2, 'Mobile Version of Travel sample App using Couchbase Lite 2.0.', 'https://github.com/lionarFG/mobile-travel-sample'),
(NULL,'lionarF', 3, 'Appium Demo App with clearly defined Page Object Pattern for React Native Mobile App.','https://github.com/lionarFG/Appium-Page-Object-Model-Demo'),
(NULL,'liagourma', 1, 'WebGL2 powered geospatial visualization layers.', 'https://github.com/liagk0R/deck.gl'),
(NULL,'liagourma', 2, 'Messy datasets? Missing values?','https://github.com/liagk0R/missingno'),
(NULL,'liagourma', 3,'Repository to track the progress in Natural Language Processing (NLP)','https://github.com/liagk0R/NLP-progress'),
(NULL,'liagourma', 4,'Supporting Rapid Prototyping with a Toolkit (incl. Datasets and Neural Network Layers)', 'https://github.com/liagk0R/PyTorch-NLP');


INSERT INTO degree VALUES
('CEID PHD','PATRA UNI','PHD'),
('Lysium certificate', '2nd Lysium of Aigaleo', 'LYKEIO'),
('Computer and Infromatics Eng.', ' Patras University', 'UNIV'),
('Electrical and Computer Eng.', 'Metsovio Polytexneio', 'UNIV'),
('Computer Science Dipl.', 'Lancster University', 'UNIV'),
('Computer Vision and Modelling', 'Princeton University', 'MASTER'),
('Artificial Intelligence', ' Cambrigde University', 'MASTER'),
('Big Data and Analytics', ' Imperial College London', 'MASTER'),
('Advanced Rendering Techniques', 'Delft University of Technology', 'MASTER'),
('Computer Science and Engineering', 'Delft University of Technology', 'UNIV'),
('Data Science Bachelor','Eindhoven University of Technology', 'UNIV'),
('PDEng Data Science', 'Eindhoven University of Technology', 'PHD'),
('NLP related high efficiency algorithms', 'Patras University', 'PHD'),
('Big Data Structures and Algorithms', 'Technical University of Denmark', 'MASTER');

INSERT INTO has_degree VALUES
('cleogeo','Lysium certificate', '2nd Lysium of Aigaleo', 1999, 19.2),
('zazahir23', 'Computer Science and Engineering', 'Delft University of Technology',2000, 8.2),
('zazahir23', 'PDEng Data Science', 'Eindhoven University of Technology',2006, 9),
('lionarF', 'Electrical and Computer Eng.', 'Metsovio Polytexneio', 1998, 7.6),
('lionarF', 'Computer Vision and Modelling', 'Princeton University', 2001, 8.5),
('liagourma', 'Computer and Infromatics Eng.', ' Patras University', 2003, 8.6),
('liagourma', 'Artificial Intelligence', ' Cambrigde University', 2008, 8),
('liagourma', 'NLP related high efficiency algorithms', 'Patras University', 2013, 9),
('mnikol', 'Computer Science Dipl.', 'Lancster University', 2001, 8.4),
('mnikol', 'Computer Vision and Modelling', 'Princeton University', 2006, 7.4),
('abrown','Data Science Bachelor','Eindhoven University of Technology',2004, 9.2),
('abrown','Big Data and Analytics', ' Imperial College London', 2006, 8),
('abrown','Big Data Structures and Algorithms', 'Technical University of Denmark', 2008, 8.2);


INSERT INTO job VALUES
(NULL,'2019-01-01', 1800, 'data analyst', 'Patra, Greece', 'n_tri', '2018-07-13', '2018-12-20'),
(NULL,'2019-02-01', 1450, 'web programmer', 'Patra, Greece', 'n_tri', '2018-07-13', '2019-01-10'),
(NULL,'2019-02-01', 2100, 'mobile app developer', 'Patra, Greece', 'n_tri', '2018-10-24', '2018-01-12'),
(NULL,'2018-12-25', 2700, 'NLP expert', 'Peiraias, Greece', 'msmith', '2018-10-10', '2018-11-10'),
(NULL,'2019-03-01', 2100, 'Graphics designer', 'Peiraias, Greece', 'msmith', '2018-10-10', '2019-02-01'),
(NULL,'201-03-01', 2300, 'Visualization expert', 'Peiraias, Greece','Giankost', '2018-10-20', '2019-01-10'),
(NULL,'2019-05-01', 1850, 'web and mobile app programmer', 'Athina, Greece','papad', '2018-11-20', '2019-04-12'),
(NULL,'2019-05-01', 1600, 'graphics expert', 'Athina, Greece','bettyg', '2018-11-20', '2019-04-12'),
(NULL,'2019-05-01', 1850, 'DB expert', 'Athina, Greece','papad', '2018-11-20', '2019-04-12'),
(NULL,'2019-04-01', 2100, 'AI expert', 'Sofia, Bulgaria', 'pavkie', '2018-11-21', '2019-03-10'),
(NULL,'2019-02-01', 2600, 'Algorithmic efficiency expert', 'Sofia, Bulgaria', 'pavkie', '2018-11-01', '2019-01-16'),
(NULL,'2019-03-01', 2800, 'web and media programmer', 'Oxford, London', 'varcon82', '2018-11-01', '2019-01-03');


INSERT INTO needs (needs_jobid, needs_title) Values
(1, 'Databases'),
(1,'Algorithms'),
(2,'Programming'),
(2,'Web Programming'),
(3, 'Mobile Apps'),
(3, 'Animation'),
(4, 'AI'),
(4, 'NLP'),
(5, 'Graphics'),
(6, 'Graphics'),
(6, 'Algorithms'),
(6, 'Programming'),
(7, 'Web Programming'),
(7, 'Mobile Apps'),
(8, '2D'),
(8, '3D'),
(9, 'Databases'),
(9, 'NoSQL DBs'),
(10, 'AI'),
(11, 'Complexity and Efficiency'),
(11, 'Algorithms'),
(12, 'Web Programming'),
(12, 'Mobile Apps'),
(12, 'Animation');

INSERT INTO requestevaluation VALUES
('Strike',5),
('cleogeo', 2),
('cleogeo',7),
('zazahir23', 2),
('zazahir23',3),
('zazahir23',6),
('zazahir23',7),
('zazahir23',12),
('lionarF', 2),
('lionarF',3),
('lionarF',5),
('lionarF',6),
('lionarF',7),
('lionarF',9),
('lionarF',12),
('liagourma', 4),
('liagourma',6),
('liagourma',10),
('mnikol', 4), 
('mnikol',11),
('abrown', 1),
('abrown', 9),
('abrown', 11);

INSERT INTO TempResult VALUES
(NULL,'Strike',5,'msmith',NULL,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,null,null,2,0,NULL),
(NULL,'cleogeo',5,'msmith',NULL,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,null,1,1,0,NULL),
(NULL,'cleogeo',5,'msmith',NULL,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,null,1,1,1,NULL);

INSERT INTO manager_rep VALUES
('Strike',default,default,default);
