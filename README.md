# CDR-Lite

The National Cancer Institute’s (NCI) Comprehensive Data Resource (CDR) is a distributed web-based system that manages and maintains multi-dimensional data models on biospecimens. The CDR was developed and is currently utilized to collect biospecimen annotation and clinical data on biospecimens collected from cancer patient donors and post-mortem donors, for the NCI’s Biospecimen Pre-analytical Variables (BPV) and NIH Genotype-tissue Expression (GTEx) programs.

The CDR provides secure data access based on a user’s roles and privileges. Through dynamic content redaction, it protects private information in compliance with HIPAA regulations. Its graphic user interfaces streamline data entry workflow based on SOPs for sample collection and processing. The automated data checks and validations confirm data integrity and SOP adherence simultaneously.

More information can be found here:

http://biospecimens.cancer.gov/newsevents/news/07172015.asp

The CDR-Lite is a Grails application. To get this standalone version up and running, please follow the steps below. Prerequisites:

Knowlege of Java and Git is assumed.

Install the latest JDK 7 per instructions for your environment. JDK 8 is not supported at this time.

Install PostgreSQL 9.3

Install Grails 2.4.4 per instructions for your environment. Later versions of Grails are not supported at this time.

See here for more Grails installation information: http://grails.org/doc/latest/guide/gettingStarted.html

After cloning from GitHub, open a console window, navigate to the cdrlite folder and run the following commands:

0) set JAVA_OPTS=-XX:MaxPermSize=128m -XX:PermSize=512m -Xms1024m -Xmx2048m (This is a generous estimate. Default memory settings are not enough.)

1) grails RunApp

This will download all project plug-ins, resolve dependencies and determine if your environment is set up properly. If all goes well, you should see the following message: Server running. Browse to http://localhost:8080/cahubdataservices

2) Open a browser if your choice and enter http://localhost:8080/cahubdataservices

3) You may log in with the following test accounts:

admin/admin

If you run into errors, try the following:

1) Grails clean

2) Grails upgrade (say yes)

3) Grails RunApp

The CDR was originally developed in the NetBeans IDE against Oracle XE. This version is using PostgreSQL 9.3.
