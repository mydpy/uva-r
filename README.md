# uva-r
Resources, installation instructions, and examples prepared for the University of Virginia McIntire School of Commerce R Seminar

####Installation Instructions
The following software is recommended to fully enjoy the seminar:

* R version 3.2.0 (or later) (2015-08-14) -- "Fire Safety"
* RStudio (optional)
* Visualization Packages (optional)


#####Linux
Install using your built-in package manager (apt-get, yum, zypper, etc.)

	sudo apt-get update
    sudo apt-get install r-base		

RStudio

* Download the R-Studio binary file built for your system [here](https://www.rstudio.com/products/rstudio/download/)
* Run the installer 

#####Mac
Base-R

* Download the 64-bit .dmg installer for Mavericks [here](http://cran.us.r-project.org/bin/macosx/R-3.2.2.pkg) and Snow Leopard [here](http://cran.us.r-project.org/bin/macosx/R-3.2.1-snowleopard.pkg)
* Run the .dmg installer
* Drag the RStudio application in the Applications folder

RStudio

* Download the 64-bit Mac R-Studio .dmg file [here](https://www.rstudio.com/products/rstudio/download/)
* Run the .dmg installer
* Drag the RStudio application in the Applications folder

#####Windows 
Base-R

* Download the 32/64-bit .exe installer from CRAN [here](http://cran.us.r-project.org/bin/windows/base/R-3.2.2-win.exe)
* Run the .exe installer

RStudio 

* Download the Windows installer [here](https://download1.rstudio.org/RStudio-0.99.486.exe)
* Run the .exe installer

#####Confirm installation
You have a few options based on your operating system: 

* Linux/Mac - Open a terminal session and type 'r'
* Windows - Go to Start > All Programs > R > R application (click)
	This opens up the RGui application, which works similar to the R shell. 
* Open R Studio

Any of the options above should show the following dialog:

	Last login: Wed Oct 21 20:19:52 on ttys003
	PATAPL-G0NLG3QA:uva-r mbaker003c$ R
	
	R version 3.2.2 (2015-08-14) -- "Fire Safety"
	Copyright (C) 2015 The R Foundation for Statistical Computing
	Platform: x86_64-apple-darwin13.4.0 (64-bit)
	
	R is free software and comes with ABSOLUTELY NO WARRANTY.
	You are welcome to redistribute it under certain conditions.
	Type 'license()' or 'licence()' for distribution details.
	
	  Natural language support but running in an English locale
	  
	R is a collaborative project with many contributors.
	Type 'contributors()' for more information and
	'citation()' on how to cite R or R packages in publications.
	
	Type 'demo()' for some demos, 'help()' for on-line help, or
	'help.start()' for an HTML browser interface to help.
	Type 'q()' to quit R.

Confirm the base packages are installed by invoking the package library

	>library()

Packages in library ‘/Library/Frameworks/R.framework/Versions/3.2/Resources/library’:

	base                    The R Base Package
	boot                    Bootstrap Functions (Originally by Angelo Canty
	                        for S)
	.						.
	.						.	
	.						.
	utils                   The R Utils Package

#####Install optional packages

	> install.packages("ggplot2")   
	> install.packages("randomForest")   
	> install.packages("MASS")
	> install.packages("ipred")
	> install.packages("e1071")

Select a mirror (a place to download the file from) and you should see log messages dumped to your screen. 
You can confirm the packages installed correctly by invoking the system library again. 

	> library()

You can show more information about a specific package by invoking the help on a given package:

	> library(help = "package_name")

####Clone GitHub Repository
	git clone https://github.com/mydpy/uva-r.git

####Run Examples

	cd uva-r 
	R -i > sample_input

