# OaOrm

This is my attempt to create an ORM in the likes of Entity Framework for .NET inside of WinCC OA.  The end idea is that you can import the control libs
point the libs at a db and call the generate function.  The libs will then query the database to get the table and column information from
that information it will write that information to .ctl files in the form of model classes.
