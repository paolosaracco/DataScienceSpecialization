# Course Project 1

This repository stores scripts and files about the first course project for the Exploratory Data Analysis course in the Data Science Specialization offered by JHU on Coursera.

Following the instructions for the project, I forked this GitHub repository and made it mine. The file [README.md](README.md) contains the given instructions for the project and the details about the dataset used to generate the plots.

* [Repository content](#content)
* [R Scripts Process](#code)

<h1 id=content>Content of the repository</h1>

<table>
  <tr>
    <th>File Name</th>
    <th>Decription</th>
  </tr>
  <tr>
    <td>README_PS.md</td>
    <td>Documentation explaining the files contained in the repository.</td>
  </tr>
  <tr>
    <td>README.md</td>
    <td>Readme file from the original directory explaining the details of the exercise and of the dataset to be used.</td>
  </tr>
  <tr>
    <td>plot*.R</td>
    <td>The scripts generating the four plots.</td>
  </tr>
  <tr>
    <td>plot*.png</td>
    <td>The four plots.</td>
  </tr>
  <tr>
    <td>figure</td>
    <td>The original plots to replicate.</td>
  </tr>
</table>

<h1 id=code>R scripts process</h1>

All the R scripts have the same structure.

1. Get the data by downloading and unzipping the folder provided by the assignment.
2. Parse the data.
   
   Since the dataset is fairly large, I decided to extract only the data concerning the 01/02/2007 and the 02/02/2007. This is achieved via <code>grep()</code> combined with <code>readLines()</code> to isolate the range, that then I specify to <code>read.table()</code> via the <code>skip</code> and <code>nrows</code> parameters.

   Variable names are added *a posteriori* and the Date and Time columns are converted into date and time formats.
3. The plots are generated using the base plotting system.
