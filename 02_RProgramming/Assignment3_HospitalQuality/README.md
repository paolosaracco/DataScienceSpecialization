# Assignment 3: Hospital Quality

Scripts for answering the Week 4 Quiz.

<table>
  <tr>
    <td>outcome-of-care-measures.csv</td>
    <td>Contains information about 30-day mortality and readmission rates
      for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.</td>
  </tr>
  <tr>
    <td>hospital-data.csv</td>
    <td>Contains information about each hospital.</td>
  </tr>
  <tr>
    <td>Hospital_Revised_Flatfiles.pdf</td>
    <td>Descriptions of the variables in each le (i.e the code book).</td>
  </tr>
  <tr>
    <td>best.R</td>
    <td>The function <code>best()</code> takes two arguments: the 2-character abbreviated name of a state and an
      outcome name. The function reads the <a href="outcome-of-care-measures.csv">outcome-of-care-measures.csv</a> file and returns a character vector
      with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specied outcome
      in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
      be one of "heart attack", "heart failure", or "pneumonia". Hospitals that do not have data on a particular
      outcome should be excluded from the set of hospitals when deciding the rankings.
      <br> <br>
      <strong>Handling ties</strong>. If there is a tie for the best hospital for a given outcome, then the hospital names is
      sorted in alphabetical order and the first hospital in that set is chosen (i.e. if hospitals "b", "c",
      and "f" are tied for best, then hospital "b" is returned).</td>
  </tr>
  <tr>
    <td>rankhospital.R</td><td>The function <code>rankhospital()</code> takes three arguments: the 2-character abbreviated name of a
      state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
      The function reads the <a href="outcome-of-care-measures.csv">outcome-of-care-measures.csv</a> file and returns a character vector with the name
      of the hospital that has the ranking specified by the num argument. 
      For example, the call <code>rankhospital("MD", "heart failure", 5)</code>
      would return a character vector containing the name of the hospital with the 5th lowest 30-day death rate
      for heart failure. The num argument can take values "best", "worst", or an integer indicating the ranking
      (smaller numbers are better). If the number given by num is larger than the number of hospitals in that
      state, then the function should return NA. Hospitals that do not have data on a particular outcome should
      be excluded from the set of hospitals when deciding the rankings.
      <br><br>
      <strong>Handling ties</strong>. It may occur that multiple hospitals have the same 30-day mortality rate for a given cause 
      of death. In those cases ties are broken by using the hospital name.</td>
  </tr>
  <tr>
    <td>rankall.R</td>
    <td>The function <code>rankall()</code> takes two arguments: an outcome name (outcome) and a hospital ranking (num). 
      The function reads the <a href="outcome-of-care-measures.csv">outcome-of-care-measures.csv</a> file and returns a 2-column data frame
      containing the hospital in each state that has the ranking specied in num. For example the function call
      <code>rankall("heart attack", "best")</code> would return a data frame containing the names of the hospitals that
      are the best in their respective states for 30-day heart attack death rates. The function returns a value
      for every state (some may be NA). The first column in the data frame is named hospital, which contains
      the hospital name, and the second column is named state, which contains the 2-character abbreviation for
      the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of
      hospitals when deciding the rankings.
      <br><br>
      <strong>Handling ties</strong>. The rankall function handles ties in the 30-day mortality rates in the same way
      that the rankhospital function handles ties.</td>
  </tr>
  <tr>
    <td>rankall_v2.R</td>
    <td>More elegant version of rankall, by using do.call instead of the for loop.</td>
  </tr>
</table>
