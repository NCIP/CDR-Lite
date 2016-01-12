/* delete from query; 
   delete from dr_specimen; 
   delete from dr_case; */
delete from st_tissue_type_tissue_locs;

delete from st_tissue_type;

delete from st_tissue_loc;



select * from st_tissue_type;

select * from st_tissue_loc;

select tissue_type_id, tissue_location_id from st_tissue_type_tissue_locs;

insert into st_tissue_type (id, version, code, name) values (1, 0, 'ADIPOSE', 'Adipose tissue');

insert into st_tissue_loc (id, version, code, name) values (1, 0, 'LEGLEFT', 'Leg, Left');
insert into st_tissue_loc (id, version, code, name) values (2, 0, 'LEGRIGHT', 'Leg, Right');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (1, 1);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (1, 2);

insert into st_tissue_type (id, version, code, name) values (2, 0, 'ADRENAL', 'Adrenal glands');

insert into st_tissue_loc (id, version, code, name) values (3, 0, 'LEFT', 'Left');
insert into st_tissue_loc (id, version, code, name) values (4, 0, 'RIGHT', 'Right');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (2, 3);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (2, 4);

insert into st_tissue_type (id, version, code, name) values (3, 0, 'AORTA', 'Aorta');

insert into st_tissue_loc (id, version, code, name) values (5, 0,  'AORTARCH', 'Aortic Arch');
insert into st_tissue_loc (id, version, code, name) values (6, 0,  'AORTASCEND', 'Ascending aorta');
insert into st_tissue_loc (id, version, code, name) values (7, 0,  'ASCENDREG', 'Ascending region');
insert into st_tissue_loc (id, version, code, name) values (8, 0,  'DESCENDREG', 'Descending thoracic region, aorta');
insert into st_tissue_loc (id, version, code, name) values (9, 0,  'THORACICASC', 'Thoracic regions (non-atherosclerotic)');
insert into st_tissue_loc (id, version, code, name) values (10, 0, 'THORACIC', 'Thoracic, other than ascending region');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (3, 5);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (3, 6);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (3, 7);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (3, 8);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (3, 9);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (3, 10);

insert into st_tissue_type (id, version, code, name) values (4, 0, 'TIBIALARTERY', 'Artery - tibial');

insert into st_tissue_loc (id, version, code, name) values (11, 0, 'BELKNEERIGHT', 'Below Knee - Right');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (4, 11);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (4, 1);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (4, 2);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (4, 3);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (4, 4);

insert into st_tissue_type (id, version, code, name) values (5, 0, 'ATRIALAPP', 'Atrial appendage');

insert into st_tissue_loc (id, version, code, name) values (12, 0, 'ANTLEFTVENT', 'Anterior left ventricle');
insert into st_tissue_loc (id, version, code, name) values (13, 0, 'RIGHTTIP', 'Right atrial appendage, tip');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (5, 12);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (5, 13);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (5, 4);

insert into st_tissue_type (id, version, code, name) values (6, 0, 'BLOOD', 'Blood, whole');

insert into st_tissue_loc (id, version, code, name) values (14, 0, 'SUBCLAVIAN', 'Vein, subclavian');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (6, 14);

insert into st_tissue_type (id, version, code, name) values (7, 0, 'BRAINCEREB', 'Brain - cerebellum');

insert into st_tissue_loc (id, version, code, name) values (15, 0, 'RIGHTCEREB', 'Right cerebellum');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (7, 15);

insert into st_tissue_type (id, version, code, name) values (8, 0, 'BRAINCORTEX', 'Brain - cortex');

insert into st_tissue_loc (id, version, code, name) values (16, 0, 'CEREBFRONTPOLE', 'Cerebral frontal pole - right');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (8, 16);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (8, 4);

insert into st_tissue_type (id, version, code, name) values (9, 0, 'CERVIXENDO', 'Cervix - endocervix');

insert into st_tissue_loc (id, version, code, name) values (17, 0, 'ANTERIOR', 'Anterior');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (9, 17);

insert into st_tissue_type (id, version, code, name) values (10, 0, 'COLON', 'Colon');

insert into st_tissue_loc (id, version, code, name) values (18, 0, 'MUCOSA', 'Mucosa');
insert into st_tissue_loc (id, version, code, name) values (19, 0, 'TRANSVERSE', 'Transverse');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (10, 18);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (10, 19);

insert into st_tissue_type (id, version, code, name) values (11, 0, 'CORONART', 'Coronary Artery');

insert into st_tissue_loc (id, version, code, name) values (20, 0, 'NONCALC', 'Non-calcified region');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (11, 20);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (11, 3); /* Left */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (11, 4); /* Right */

insert into st_tissue_type (id, version, code, name) values (12, 0, 'ESOPHMUCOSA', 'Esophagus - mucosa');

insert into st_tissue_loc (id, version, code, name) values (22, 0, 'NONNONREG', 'Non-nodular region');
insert into st_tissue_loc (id, version, code, name) values (23, 0, 'SQUAMOUSGEJUNC', 'Squamous region, above gastroesophageal junction');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (12, 18);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (12, 22); 
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (12, 23); 

insert into st_tissue_type (id, version, code, name) values (13, 0, 'ESOPHMUSCL', 'Esophagus - muscularis');

insert into st_tissue_loc (id, version, code, name) values (24, 0, 'MUSCULARIS', 'Muscularis');
insert into st_tissue_loc (id, version, code, name) values (25, 0, 'MUSCLESOPHAG', 'Muscularis of lowest portion of esophagus');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (13, 24);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (13, 25); 
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (13, 23); 

insert into st_tissue_type (id, version, code, name) values (14, 0, 'FALLOPIAN', 'Fallopian tube');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (14, 3); /* Left */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (14, 4); /* Right */

insert into st_tissue_type (id, version, code, name) values (15, 0, 'GEJUNCTION', 'Gastroesophageal junction');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (15, 24);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (15, 25); 
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (15, 23); 

insert into st_tissue_type (id, version, code, name) values (16, 0, 'HEART', 'Heart');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (16, 12);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (16, 13); 

insert into st_tissue_type (id, version, code, name) values (17, 0, 'ILIUM', 'Ilium');

insert into st_tissue_loc (id, version, code, name) values (26, 0, 'ILIUMUCOSA', 'Nodular mucosa and submucosa of most distal ileum');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (17, 26); 

insert into st_tissue_type (id, version, code, name) values (18, 0, 'KIDNEY', 'Kidney');
insert into st_tissue_type (id, version, code, name) values (19, 0, 'KIDNETCORTEX', 'Kidney - cortex');
insert into st_tissue_type (id, version, code, name) values (20, 0, 'KIDNEYMEDULL', 'Kidney - medulla');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (18, 3); /* Left */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (18, 4); /* Right */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (19, 3); /* Left */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (19, 4); /* Right */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (20, 3); /* Left */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (20, 4); /* Right */

insert into st_tissue_type (id, version, code, name) values (21, 0, 'LIVER', 'Liver');

insert into st_tissue_loc (id, version, code, name) values (27, 0, 'CENTRALREG', 'Central region');
insert into st_tissue_loc (id, version, code, name) values (28, 0, 'CENTRIGHTLOBE', 'Central right lobe');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (21, 27); 
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (21, 28); 

insert into st_tissue_type (id, version, code, name) values (22, 0, 'LUNG', 'Lung');

insert into st_tissue_loc (id, version, code, name) values (29, 0, 'LEFTUPLOBE', 'Inferior segment of left upper lobe');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (22, 29);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (22, 4); /* Right */

insert into st_tissue_type (id, version, code, name) values (23, 0, 'MAMMARY', 'Mammary tissue (breast)');

insert into st_tissue_loc (id, version, code, name) values (30, 0, 'NOS', 'Not otherwise specified');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (23, 3); /* Left */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (23, 4); /* Right */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (23, 30);

insert into st_tissue_type (id, version, code, name) values (24, 0, 'MINSALVGLD', 'Minor salivary glands');

insert into st_tissue_loc (id, version, code, name) values (31, 0, 'INSLOWLIP', 'Inner surface of lower lip');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (24, 31);

insert into st_tissue_type (id, version, code, name) values (25, 0, 'MUSCLESKEL', 'Muscle, skeletal');

insert into st_tissue_loc (id, version, code, name) values (32, 0, 'ABKNEELEFT', 'Above knee - Left');
insert into st_tissue_loc (id, version, code, name) values (33, 0, 'ABKNEERIGHT', 'Above knee - Right');
insert into st_tissue_loc (id, version, code, name) values (34, 0, 'BELOKNEELEFT', 'Below knee - Left');
/* Below knee right is defined above */
insert into st_tissue_loc (id, version, code, name) values (35, 0, 'GASTROCLEFT', 'Gastrocnemius - Left');
insert into st_tissue_loc (id, version, code, name) values (36, 0, 'GASTROCRIGHT', 'Gastrocnemius - Right');
insert into st_tissue_loc (id, version, code, name) values (37, 0, 'GASTROCLOWER', 'Gastrocnemius below patella');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (25, 32);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (25, 33); 
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (25, 34);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (25, 11);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (25, 35);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (25, 36);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (25, 37);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (25, 1);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (25, 2);

insert into st_tissue_type (id, version, code, name) values (26, 0, 'TIBIALNERVE', 'Nerve - tibial');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (26, 34);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (26, 11);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (26, 1);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (26, 2);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (26, 3);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (26, 4);

insert into st_tissue_type (id, version, code, name) values (27, 0, 'OMENTUM', 'Omentum');

insert into st_tissue_loc (id, version, code, name) values (38, 0, 'OMENTUMADIPOSE', 'Greater omentum adipose tissue');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (27, 38);

insert into st_tissue_type (id, version, code, name) values (28, 0, 'OVARY', 'Ovary');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (28, 3); /* Left */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (28, 4); /* Right */

insert into st_tissue_type (id, version, code, name) values (29, 0, 'PANCREAS', 'Pancreas');

insert into st_tissue_loc (id, version, code, name) values (39, 0, 'PANCREASMID', 'Mid-portion (not tail)');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (29, 39);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (29, 17);

insert into st_tissue_type (id, version, code, name) values (30, 0, 'PITUITARY', 'Pituitary');

insert into st_tissue_loc (id, version, code, name) values (40, 0, 'ENTIREPIT', 'Entire pituitary gland');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (30, 40);

insert into st_tissue_type (id, version, code, name) values (31, 0, 'PROSTATE', 'Prostate');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (31, 22);

insert into st_tissue_type (id, version, code, name) values (32, 0, 'SIGMOIDCOL', 'Sigmoid colon');

insert into st_tissue_loc (id, version, code, name) values (41, 0, 'COLONABREC', 'Curved portion of colon above rectum');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (32, 41);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (32, 24);

insert into st_tissue_type (id, version, code, name) values (33, 0, 'SKIN', 'Skin');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (33, 1);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (33, 2);

insert into st_tissue_type (id, version, code, name) values (34, 0, 'SPLEEN', 'Spleen');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (34, 27); 

insert into st_tissue_type (id, version, code, name) values (35, 0, 'STOMACH', 'Stomach');

insert into st_tissue_loc (id, version, code, name) values (42, 0, 'STOMACHBOD', 'Body (of stomach)');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (35, 42); 

insert into st_tissue_type (id, version, code, name) values (36, 0, 'SKINPUBIC', 'Suprapubic skin');

insert into st_tissue_loc (id, version, code, name) values (43, 0, 'ABOVPUBHAIR', 'Skin just above pubic hair');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (36, 43); 

insert into st_tissue_type (id, version, code, name) values (37, 0, 'TESTIS', 'Testis');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (37, 3); /* Left */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (37, 4); /* Right */

insert into st_tissue_type (id, version, code, name) values (38, 0, 'THYROID', 'Thyroid gland');

insert into st_tissue_loc (id, version, code, name) values (44, 0, 'NONNODREGLR', 'Non-nodular region: Left and/or Right');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (38, 3); /* Left */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (38, 4); /* Right */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (38, 44);

insert into st_tissue_type (id, version, code, name) values (39, 0, 'BLADDER', 'Urinary bladder');

insert into st_tissue_loc (id, version, code, name) values (45, 0, 'CENTRALPOST', 'Central posterior');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (39, 45);
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (39, 17); /* Anterior */

insert into st_tissue_type (id, version, code, name) values (40, 0, 'UTERUS', 'Uterus');

insert into st_tissue_loc (id, version, code, name) values (46, 0, 'CORPUS', 'Corpus');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (40, 46);

insert into st_tissue_type (id, version, code, name) values (41, 0, 'VAGINA', 'Vagina');

insert into st_tissue_loc (id, version, code, name) values (47, 0, 'POSTERIOR', 'Posterior');

insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (41, 17); /* Anterior */
insert into st_tissue_type_tissue_locs (tissue_type_id, tissue_location_id) values (41, 47);


