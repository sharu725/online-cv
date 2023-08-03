<!-- ====================================================================== -->
<!-- Simplified DocBook XML Information Pool V4.1.2.4
     Part of the Simplified DocBook XML V4.1.2.4 DTD
     http://nwalsh.com/docbook/simple/

     See COPYRIGHT for more information

     Please direct all questions and comments about this DTD to
     Norman Walsh, <ndw@nwalsh.com>.
                                                                            -->
<!-- ====================================================================== -->

<!ENTITY % local.component.mix "">
<!ENTITY % component.mix
		"%list.class;		|%admon.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		|%formal.class;		|%compound.class;
					|%descobj.class;
		%local.component.mix;">

<!ENTITY % local.sidebar.mix "">
<!ENTITY % sidebar.mix
		"%list.class;		|%admon.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		|%formal.class;
		%local.sidebar.mix;">

<!ENTITY % local.qandaset.mix "">
<!ENTITY % qandaset.mix
		"%list.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		|%formal.class;
		%local.qandaset.mix;">

<!ENTITY % local.revdescription.mix "">
<!ENTITY % revdescription.mix
		"%list.class;		|%admon.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		|%formal.class;
		%local.revdescription.mix;">

<!ENTITY % local.footnote.mix "">
<!ENTITY % footnote.mix
		"%list.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		%local.footnote.mix;">

<!ENTITY % local.example.mix "">
<!ENTITY % example.mix
		"%list.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		%local.example.mix;">

<!ENTITY % local.highlights.mix "">
<!ENTITY % highlights.mix
		"%list.class;		|%admon.class;
		|%para.class;
		%local.highlights.mix;">

<!ENTITY % local.para.mix "">
<!ENTITY % para.mix
		"%list.class;           |%admon.class;
		|%linespecific.class;
					|%informal.class;
		|%formal.class;
		%local.para.mix;">

<!ENTITY % local.admon.mix "">
<!ENTITY % admon.mix
		"%list.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		|%formal.class;
		%local.admon.mix;">

<!ENTITY % local.figure.mix "">
<!ENTITY % figure.mix
		"%linespecific.class;
					|%informal.class;
		%local.figure.mix;">

<!ENTITY % local.tabentry.mix "">
<!ENTITY % tabentry.mix
		"%list.class;		|%admon.class;
		|%linespecific.class;
		|%para.class;		|mediaobject
		%local.tabentry.mix;">

<!ENTITY % local.glossdef.mix "">
<!ENTITY % glossdef.mix
		"%list.class;
		|%linespecific.class;
		|%para.class;		|%informal.class;
		|%formal.class;
		%local.glossdef.mix;">

<!ENTITY % local.legalnotice.mix "">
<!ENTITY % legalnotice.mix
		"%list.class;		|%admon.class;
		|%linespecific.class;
		|%para.class;		|blockquote
		%local.legalnotice.mix;">

<!ENTITY % local.textobject.mix "">
<!ENTITY % textobject.mix
		"%list.class;		|%admon.class;
		|%linespecific.class;
		|%para.class;		|blockquote
		%local.textobject.mix;">

<!-- Character-level mixtures ............................................. -->

<!ENTITY % ubiq.exclusion "">
<!ENTITY % ubiq.inclusion "">

<!ENTITY % local.para.char.mix "">
<!ENTITY % para.char.mix
		"#PCDATA
					|%gen.char.class;
		|%link.char.class;	|%tech.char.class;
					|%inlineobj.char.class;
		%local.para.char.mix;">

<!ENTITY % local.title.char.mix "">
<!ENTITY % title.char.mix
		"#PCDATA
					|%gen.char.class;
		|%link.char.class;	|%tech.char.class;
					|%docinfo.char.class;
					|%inlineobj.char.class;
		%local.title.char.mix;">

<!ENTITY % local.cptr.char.mix "">
<!ENTITY % cptr.char.mix
		"#PCDATA
		|%link.char.class;	|%tech.char.class;
					|inlinemediaobject
		%local.cptr.char.mix;">

<!ENTITY % local.smallcptr.char.mix "">
<!ENTITY % smallcptr.char.mix
		"#PCDATA
					|replaceable
					|inlinemediaobject
		%local.smallcptr.char.mix;">

<!ENTITY % local.word.char.mix "">
<!ENTITY % word.char.mix
		"#PCDATA
					|acronym|emphasis|trademark
		|%link.char.class;
					|inlinemediaobject
		%local.word.char.mix;">

<!ENTITY % local.docinfo.char.mix "">
<!ENTITY % docinfo.char.mix
		"#PCDATA
		|%link.char.class;
					|emphasis|trademark
					|replaceable
					|inlinemediaobject
		%local.docinfo.char.mix;">

<!ENTITY % tbl.table.excep "">
<!ENTITY % tbl.table.mdl
	"(title, (mediaobject+|tgroup+))">

<!ENTITY % programlisting.content "%para.char.mix; | lineannotation">
