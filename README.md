# Creating an ORM with WinCC OA

WinCC OA is a powerful tool and gives its users great freedoms in creating useful addons that can make development faster and easier.  One thing that I noticed when I first start using WinCC OA was that doing queries to a traditional SQL Database was not an arbitrary task.  Shortly after noticing this I began thinking to other programming languages and how they have made this task easier.  Then it came to me, most modern programming languages utilize an ORM in some form.  An ORM is an Object Relational Mapper, in laymen’s terms it takes your database tables and translates them into code objects to be manipulated.  This was a perfect use case for the CTRL++ language inside of WinCC OA so I began working on one.
The process is broken down into two major components, the automatic generation of the classes based on a database connection and the ORM logic itself.  The most import piece of these components is the ORM logic itself.  The ORM is has multiple major pieces that work together to make the process as simple as possible for an end user.
# Breakdown of Classes
# Database Adapter 
The Database Adapter is where all the database interactions are held.  This includes the connection along with the actual interaction with the database.  These interactions are currently limited to basic SELECTS, INSERTS, UPDATES, and DELETES.  This class is meant to be ignored by the end user and be in the background forgotten about.
# Abstract Mapper
The Abstract Mapper is the ‘Abstract’ class that all Concrete Mappers inherit from and does the communication between the user and the Database Adapter.  Again, this class is meant to be basically ignored by the user.
# Models
Models are a Plain old Object inside of the CTRL++ language.  They have public properties that relate to the corresponding database fields.  Example: if we have a database column called name and is a varchar then the Model will have a property called name and will be a string.
# Concrete Mappers
This is where the brunt of the logic actually happens.  In these classes, one for each database table, we map the results from the Database Adapter to actual classes inside of CTRL++.  Then utilizing the dyn_anytype data type it allows us to pass any of the classes that are created to anywhere in the software.



# Using the ORM Creator
 
From any panel in your application simply create an instance of the OrmFactory then call the Init function, passing in the name of the odbc connection, the database user and the database password.  Then call the StartOrm function passing the name of the database you want to map out.  Doing this will create the Models and the Concrete mappers needed to run the ORM.  You will need to refresh the project folders to see the files that were created.

# Disclaimer
I built this to help with the SQL interaction inside of WinCC OA, but there are limitations to these components and I only consider this to be an Alpha product.  There is possibly more than can be done to this to make it better but I thought it would be cool to release it to the community and see if others have ideas to make it better.  This code also comes as is and is completely open source.
# Limitations
•	Currently does not auto create sub classes, this functionality can be added in but it needs to be hand added.
•	Datetimes saving to the SQL server has some issues.
•	If you do incorporate sub classes a View Model will be needed because converting a class to a string with sub classes makes the update function confused.
•	Currently the OrmFactory is hard coded to a specific file path and needs to be more dynamic.


