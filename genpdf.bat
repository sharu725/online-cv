rem Dont use this script its not qorking well enough
rem Use the Chrome plugins:
rem to produce similar to the webpage use PDF Mage, settings portrait, single page, 1024
rem a simple PDF use: https://chrome.google.com/webstore/detail/print-friendly-pdf/ohlencieiipommannpdfcmfdpjjmeolj?hl=en

wkhtmltopdf  http://localhost:4000/online-cv/ assets/pdf/steven_wells_resume.pdf 
pause
rem --disable-smart-shrinking
rem --viewport-size 1024x768 
rem --margin-left 0mm --margin-right 0mm --margin-top 27mm --margin-bottom 12mm