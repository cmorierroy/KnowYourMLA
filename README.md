# KnowYourMLA
I conceived and designed this app for my final project in the Udacity iOS Developer course. <br>
It is an attempt at making information about Manitoban MLA's very accessible. <br>

Current features are simple:
<li>A pie chart of current legislative assembly constitution by party</li>
<li>A page where users can scroll and select an MLA</li>
<li>An MLA details page once the MLA is selected</li>

## Project Dependencies
All dependencies are installed with cocoapods and contained in the podfile. <br>
*Alamofire*: For web requests (scraping). <br>
*Kanna*: For parsing html. <br>
*Charts*: For presenting scraped data. <br>

### Scraping
Data is currently taken from:<br>
https://www.gov.mb.ca/legislature/members/mla_list_constituency.html<br>

Unfortunately, there is not yet an API to make this cleaner, but I hope that it'll exist someday.<br>

If you are attempting to build this in Xcode, build it from the KnowYourMLA.xworkspace file.
