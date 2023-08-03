<!-- ====================================================================== -->
<!-- DocBk XML Notations V3.1.7
     Part of the DocBk XML V3.1.7 DTD
     http://nwalsh.com/docbook/xml/

     See COPYRIGHT for more information

     Please direct all questions and comments about this DTD to
     Norman Walsh, <ndw@nwalsh.com>.
                                                                            -->
<!-- ====================================================================== -->

<!ENTITY % local.notation.class "">
<!ENTITY % notation.class
		"BMP| CGM-CHAR | CGM-BINARY | CGM-CLEAR | DITROFF | DVI
		| EPS | EQN | FAX | GIF | GIF87a | GIF89a 
		| JPG | JPEG | IGES | PCX
		| PIC | PS | SGML | TBL | TEX | TIFF | WMF | WPG
		| linespecific
		%local.notation.class;">

<!NOTATION BMP		PUBLIC
"+//ISBN 0-7923-9432-1::Graphic Notation//NOTATION Microsoft Windows bitmap//EN">
<!NOTATION CGM-CHAR	PUBLIC "ISO 8632/2//NOTATION Character encoding//EN">
<!NOTATION CGM-BINARY	PUBLIC "ISO 8632/3//NOTATION Binary encoding//EN">
<!NOTATION CGM-CLEAR	PUBLIC "ISO 8632/4//NOTATION Clear text encoding//EN">
<!NOTATION DITROFF	SYSTEM "DITROFF">
<!NOTATION DVI		SYSTEM "DVI">
<!NOTATION EPS		PUBLIC 
"+//ISBN 0-201-18127-4::Adobe//NOTATION PostScript Language Ref. Manual//EN">
<!NOTATION EQN		SYSTEM "EQN">
<!NOTATION FAX		PUBLIC 
"-//USA-DOD//NOTATION CCITT Group 4 Facsimile Type 1 Untiled Raster//EN">
<!NOTATION GIF		SYSTEM "GIF">
<!NOTATION GIF87a               PUBLIC
"-//CompuServe//NOTATION Graphics Interchange Format 87a//EN">

<!NOTATION GIF89a               PUBLIC
"-//CompuServe//NOTATION Graphics Interchange Format 89a//EN">
<!NOTATION JPG		SYSTEM "JPG">
<!NOTATION JPEG		SYSTEM "JPG">
<!NOTATION IGES		PUBLIC 
"-//USA-DOD//NOTATION (ASME/ANSI Y14.26M-1987) Initial Graphics Exchange Specification//EN">
<!NOTATION PCX		PUBLIC 
"+//ISBN 0-7923-9432-1::Graphic Notation//NOTATION ZSoft PCX bitmap//EN">
<!NOTATION PIC		SYSTEM "PIC">
<!NOTATION PS		SYSTEM "PS">
<!NOTATION SGML		PUBLIC 
"ISO 8879:1986//NOTATION Standard Generalized Markup Language//EN">
<!NOTATION TBL		SYSTEM "TBL">
<!NOTATION TEX		PUBLIC 
"+//ISBN 0-201-13448-9::Knuth//NOTATION The TeXbook//EN">
<!NOTATION TIFF		SYSTEM "TIFF">
<!NOTATION WMF		PUBLIC 
"+//ISBN 0-7923-9432-1::Graphic Notation//NOTATION Microsoft Windows Metafile//EN">
<!NOTATION WPG		SYSTEM "WPG"> <!--WordPerfect Graphic format-->
<!NOTATION linespecific	SYSTEM "linespecific">

<!-- End of DocBk XML notations module V3.1.7 ............................. -->
<!-- ...................................................................... -->
