#!/bin/sh

DESCRIPTION="Generate a mvc web project and a domain (netstandard) classlibrary.\
\nAdditionally this script sets up a solution and links project references."


NAME=$1
WEBNAME=web
DOMAINNAME=$NAME.Domain
TESTNAME=$NAME.Tests

if [ -z $NAME ]; then
	echo "\n\t Usage: $(basename $0) <name>\n" 
	echo $DESCRIPTION
       	exit 1
fi

# Create solutionsfolder
mkdir $NAME && cd $NAME

# Create new solution
dotnet new sln -n $NAME


# Create projects
dotnet new mvc -o $WEBNAME
dotnet new classlib -f netstandard2.1 -o $DOMAINNAME
dotnet new xunit $TESTNAME

# Add projects to solution
dotnet sln add $WEBNAME/$WEBNAME.csproj
dotnet sln add $DOMAINNAME/$DOMAINNAME.csproj
dotnet sln add $TESTNAME/$TESTNAME.csproj

# Set up project reference
dotnet add $WEBNAME/$WEBNAME.csproj reference $DOMAINNAME/$DOMAINNAME.csproj
dotnet add $TESTNAME/$TESTNAME.csproj reference $WEBNAME/$WEBNAME.csproj

# Domain project structure
mkdir $DOMAINNAME/Entities
mkdir $DOMAINNAME/Repositories
