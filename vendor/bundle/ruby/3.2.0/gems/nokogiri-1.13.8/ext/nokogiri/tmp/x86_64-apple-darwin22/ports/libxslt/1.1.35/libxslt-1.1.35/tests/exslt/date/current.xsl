<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">

<xsl:output method="text"/>

<xsl:template match="/">
  <xsl:message>Current Date : <xsl:value-of select="date:date-time()"/>
     <!-- dateTime, date, gYearMonth or gYear; else NaN -->
     year                 : <xsl:value-of select="date:year()"/>
     <!-- dateTime, date, gYearMonth or gYear; else NaN -->
     leap-year            : <xsl:value-of select="date:leap-year()"/>
     <!-- dateTime, date, gYearMonth, gMonth or gMonthDay; else NaN -->
     month-in-year        : <xsl:value-of select="date:month-in-year()"/>
     <!-- dateTime, date, gYearMonth or gMonth; else '' -->
     month-name           : <xsl:value-of select="date:month-name()"/>
     <!-- dateTime, date, gYearMonth or gMonth; else '' -->
     month-abbreviation   : <xsl:value-of select="date:month-abbreviation()"/>
     <!-- dateTime or date; else NaN -->
     week-in-year         : <xsl:value-of select="date:week-in-year()"/>
     <!-- dateTime, date; else NaN -->
     day-in-year          : <xsl:value-of select="date:day-in-year()"/>
     <!-- dateTime, date, gMonthDay or gDay; else NaN -->
     day-in-month         : <xsl:value-of select="date:day-in-month()"/>
     <!-- dateTime, date; else NaN -->
     day-of-week-in-month : <xsl:value-of select="date:day-of-week-in-month()"/>
     <!-- dateTime, date; else NaN -->
     day-in-week          : <xsl:value-of select="date:day-in-week()"/>
     <!-- dateTime or date; else NaN -->
     day-name             : <xsl:value-of select="date:day-name()"/>
     <!-- dateTime or date; else NaN -->
     day-abbreviation     : <xsl:value-of select="date:day-abbreviation()"/>
    <!-- dateTime or time;  else '' -->
     time                 : <xsl:value-of select="date:time()"/>
     <!-- dateTime or time;  else NaN -->
     hour-in-day          : <xsl:value-of select="date:hour-in-day()"/>
     <!-- dateTime or time;  else NaN -->
     minute-in-hour       : <xsl:value-of select="date:minute-in-hour()"/>
     <!-- dateTime or time;  else NaN -->
     second-in-minute     : <xsl:value-of select="date:second-in-minute()"/>
  </xsl:message>
</xsl:template>

</xsl:stylesheet>

