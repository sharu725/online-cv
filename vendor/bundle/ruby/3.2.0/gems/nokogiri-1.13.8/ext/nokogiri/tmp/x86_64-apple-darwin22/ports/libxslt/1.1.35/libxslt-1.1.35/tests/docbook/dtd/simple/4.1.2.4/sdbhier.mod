<!-- ====================================================================== -->
<!-- Simplified DocBook XML Document Hierarchy V4.1.2.4
     Part of the Simplified DocBook XML V4.1.2.4 DTD
     http://nwalsh.com/docbook/simple/

     See COPYRIGHT for more information

     Please direct all questions and comments about this DTD to
     Norman Walsh, <ndw@nwalsh.com>.
                                                                            -->
<!-- ====================================================================== -->

<!ENTITY % local.divcomponent.mix "">
<!ENTITY % divcomponent.mix
		"%list.class;		|%admon.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		|%formal.class;		|%compound.class;
					|%descobj.class;
		%local.divcomponent.mix;">

<!ENTITY % bookcomponent.content
	"((%divcomponent.mix;)+, section*)
	| section+">

<![ %include.refentry; [

<!ENTITY % local.refinline.char.mix "">
<!ENTITY % refinline.char.mix
		"#PCDATA
					|%gen.char.class;
		|%link.char.class;	|%tech.char.class;
		%local.refinline.char.mix;">

<!ENTITY % local.refcomponent.mix "">
<!ENTITY % refcomponent.mix
		"%list.class;		|%admon.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		|%formal.class;		|%compound.class;
					|%descobj.class;
		%local.divcomponent.mix;">

<!ELEMENT refentry (refentryinfo?, refmeta?, (%link.char.class;)*,
                    refnamediv, refsynopsisdiv?, refsect1+)>

<!ELEMENT refentryinfo ((mediaobject | legalnotice
		| subjectset | keywordset
                | %bibliocomponent.mix;)+)>

<!ELEMENT refmeta (refentrytitle, manvolnum?, refmiscinfo*)>

<!ELEMENT refsect1info ((mediaobject | legalnotice
	| keywordset | subjectset | %bibliocomponent.mix;)+)>

<!ELEMENT refsect2info ((mediaobject | legalnotice
	| keywordset | subjectset | %bibliocomponent.mix;)+)>

<!ELEMENT refsect3info ((mediaobject | legalnotice
	| keywordset | subjectset | %bibliocomponent.mix;)+)>

<!ELEMENT refsynopsisdivinfo ((mediaobject | legalnotice
	| keywordset | subjectset | %bibliocomponent.mix;)+)>

<!ELEMENT refnamediv (refdescriptor?, refname+, refpurpose, refclass*,
		(%link.char.class;)*)>

]]>
