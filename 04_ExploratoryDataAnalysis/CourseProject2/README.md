# Course Project 2

This repository stores scripts and files about the second course project for the Exploratory Data Analysis course in the Data Science Specialization offered by JHU on Coursera.

* [Repository content](#content)
* [Course Project context](#context)
* [The data](#data)
* [Assignment](#assignment)
* [R Scripts Process](#code)

<h1 id=content>Content of the repository</h1>

<table>
  <tr>
    <th>File Name</th>
    <th>Decription</th>
  </tr>
  <tr>
    <td>README.md</td>
    <td>Documentation explaining the files contained in the repository.</td>
  </tr>
  <tr>
    <td>plot*.R</td>
    <td>The scripts generating the four plots.</td>
  </tr>
  <tr>
    <td>plot*.png</td>
    <td>The four plots.</td>
  </tr>
</table>

<h1 id=context>The context</h1>

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the [EPA National Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html).

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

<h1 id=data>The data</h1>

The data for this assignment are available from the course web site as a single zip file. The zip file contains two files:

<table>
  <tr>
    <td> PM2.5 Emissions Data (summarySCC_PM25.rds)</td> 
    <td> This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, 
      the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. 
      <ul>
        <li> fips: A five-digit number (represented as a string) indicating the U.S. county </li>
        <li> SCC: The name of the source as indicated by a digit string (see source code classification table) </li>
        <li> Pollutant: A string indicating the pollutant </li>
        <li> Emissions: Amount of PM2.5 emitted, in tons </li>
        <li> type: The type of source (point, non-point, on-road, or non-road) </li>
        <li> year: The year of emissions recorded </li>
      </ul>
      </td>
  </tr>
  <tr>
    <td> Source Classification Code Table (Source_Classification_Code.rds)</td> 
    <td> This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. 
      The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever 
      categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.
    </td>
  </tr>
</table>

We can read each of the two files using the readRDS() function in R.

<h1 id=assignment>Assignment</h1>

The overall goal of this assignment is to explore the National Emissions 
Inventory database and see what it say about fine particulate matter pollution 
in the United states over the 10-year period 1999–2008. You may use any 
R package you want to support your analysis.

<h3>Questions</h3>
You must address the following questions and tasks in your exploratory analysis.
For each question/task you will need to make a single plot. 
Unless specified, you can use any plotting system in R to make your plot.

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
Using the base plotting system, make a plot showing the total PM2.5 emission 
from all sources for each of the years 1999, 2002, 2005, and 2008.

2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
(fips == "24510") from 1999 to 2008? 
Use the base plotting system to make a plot answering this question.

3. Of the four types of sources indicated by the type 
(point, nonpoint, onroad, nonroad) variable, which of these four sources 
have seen decreases in emissions from 1999–2008 for Baltimore City? 
Which have seen increases in emissions from 1999–2008? Use the ggplot2
plotting system to make a plot answer this question.

4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

<h1 id=code>R scripts process</h1>
