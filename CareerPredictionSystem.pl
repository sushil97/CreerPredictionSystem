/*Main starting point*/
run:-
	nl,
	writeln(' ****** Welcome to the career prediction system for M.TECH **********'),nl,nl,
	writeln('For each question enter your choice followed by a dot. Press Enter if you want to input more data. To finish input type \"stop\" followed by dot\x28\.\x29\ '),nl,nl,
	reset_system,
	ask(subj),nl,
	ask(programming),nl,
	ask(skill),nl,
	ask(work),nl,
	chooseCareer(Career),
	explain(Career).
run :-
	write('Can\'t find a career for you. Sorry! :('), nl.

chooseCareer(Career):-
	career(Career).

/*-----------------------------------------------------------------------------------------------------*/


/*some dynamic predicates*/
:- dynamic(subject/1).
:- dynamic(programming/1).
:- dynamic(skill/1).
:- dynamic(work/1).

/*-----------------------------------------------------------------------------------------------------*/
	
/*Reset System*/
reset_system:-
	
	retractall(subject(_)),
	retractall(programming(_)),
	retractall(skill(_)),
	retractall(work(_)).
	
/*-----------------------------------------------------------------------------------------------------*/
	
/* Questions Section */

ask(subj):-
	writeln('Choose your favorite subjects '),
	print_option(['Machine Learning','Data Mining','Natural Language Processing','Information Retrieval','Data Structure','Artificial intelligence','Algorithms','Operating Systems','DataBase management Systems','Computer Networks','Computer Security','Distributed Systems'],1),
	take_input(RESULT,stop),
	valid_input(RESULT),
	loop_result(RESULT,[ml,dm,nlp,ir,dsa,ai,algo,os,dbms,cn,cs,ds]),!.
	
ask(programming):-
	writeln('Choose programming languages you know'),
	print_option(['Python','C','C++','R','Java','JavaScript','Prolog','C#','Assembly Language','PHP','Android','iOS','SQL'],1),
	take_input(RESULT,stop),
	valid_input(RESULT),
	loop_result(RESULT,[python,c,cpp,r,java,javascript,prolog,csharp,assembly,php,android,ios,sql]),!.


ask(skill):-
	writeln('What skills do you have'),
	print_option(['Development Frameworks','UI/UX','DataBase','Software Testing and Validation','Cloud Technologies','Version Control Systems','Object Oriented Design','Linux','Data Visualisation','Aptitude','Statistics and probability','Hadoop and TensorFlow','Networking'],1),
	take_input(RESULT,stop),
	valid_input(RESULT),
	loop_result(RESULT,[framework,ui,db,testing,cloud,vcs,oopd,linux,dv,apti,stats,tensor,networking]),!.


ask(work):-
	writeln('Which kind of work sounds most appealing to you?'),
	print_option(['Debugging','Research and development','Repetitive','Development','New Technologies','Challenging','Maintenance','Creative'],1),
	take_input(RESULT,stop),
	valid_input(RESULT),
	loop_result(RESULT,[debugging,rnd,repetitive,dev,tech,challenging,maintenance,creative]),!.


/*-----------------------------------------------------------------------------------------------------*/


/*Function to map user input to actual subjects*/	
loop_result([],_).
loop_result([HEAD|TAIL],X):-
	loop(X,HEAD),
	loop_result(TAIL,X).
	
loop([],_).
loop([HEAD|_],1):-
	option(HEAD).
loop([_|TAIL],N):-
	A is N-1,
	loop(TAIL,A).

/*-----------------------------------------------------------------------------------------------------*/


/*List of work*/
option(debugging):-
	asserta(work(debugging)).
option(rnd):-
	asserta(work(rnd)).
option(repetitive):-
	asserta(work(repetitive)).
option(dev):-
	asserta(work(dev)).
option(tech):-
	asserta(work(tech)).
option(maintenance):-
	asserta(work(maintenance)).
option(creative):-
	asserta(work(creative)).
option(challenging):-
	asserta(work(challenging)).
	
/*List of skills*/
option(framework):-
	asserta(skill(framework)).
option(ui):-
	asserta(skill(ui)).
option(db):-
	asserta(skill(db)).
option(testing):-
	asserta(skill(testing)).
option(cloud):-
	asserta(skill(cloud)).
option(vcs):-
	asserta(skill(vcs)).
option(oopd):-
	asserta(skill(oopd)).
option(linux):-
	asserta(skill(linux)).
option(dv):-
	asserta(skill(dv)).
option(apti):-
	asserta(skill(apti)).
option(stats):-
	asserta(skill(stats)).
option(tensor):-
	asserta(skill(tensor)).
option(networking):-
	asserta(skill(networking)).
	
/*List of subjects*/
option(ml):-
	asserta(subject(ml)).
option(dm):-
	asserta(subject(dm)).
option(dsa):-
	asserta(subject(dsa)).
option(ai):-
	asserta(subject(ai)).
option(algo):-
	asserta(subject(algo)).
option(os):-
	asserta(subject(os)).
option(dbms):-
	asserta(subject(dbms)).
option(cn):-
	assert(subject(cn)).
option(cs):-
	assert(subject(cs)).
option(ds):-
	assert(subject(ds)).
option(nlp):-
	asserta(subject(nlp)).
option(ir):-
	asserta(subject(ir)).
	
/*List of programming languages*/
option(python):-
	asserta(programming(python)).
option(android):-
	asserta(programming(android)).
option(ios):-
	asserta(programming(ios)).
option(sql):-
	asserta(programming(sql)).
option(c):-
	asserta(programming(c)).
option(cpp):-
	asserta(programming(cpp)).
option(r):-
	asserta(programming(r)).
option(java):-
	asserta(programming(java)).
option(javascript):-
	asserta(programming(javascript)).
option(prolog):-
	asserta(programming(prolog)).
option(assembly):-
	asserta(programming(assembly)).
option(csharp):-
	asserta(programming(csharp)).
option(php):-
	asserta(programming(php)).

	
	
/*-----------------------------------------------------------------------------------------------------*/
	
/*Check if input is valid*/
valid_input(RESULT):-
	list_length(RESULT,L),
	L<1 -> writeln("Please provide valid input"), abort;
	true.

/*-----------------------------------------------------------------------------------------------------*/

/*Compute length of the list*/	
list_length([],0).
list_length([_|TAIL],N):- list_length(TAIL,N1),N is N1+1.        

/*-----------------------------------------------------------------------------------------------------*/

/* Input Section  */
take_input(L, End) :-
    (   element(E, End)  ->  L = [E|L1],
        take_input(L1, End);   
        L = []
    ).

element(E, End) :-
    read(E),
    dif(E, End).


/*-----------------------------------------------------------------------------------------------------*/

    
/*Option printing Section*/
print_option([],_).
print_option([HEAD|TAIL], A) :-
	write(A), write(' '),	
	write(HEAD), nl,
	N is A +1,
	print_option(TAIL, N).
	
/*-----------------------------------------------------------------------------------------------------*/

	
/*Career Section*/

career(ml_engineer):-
	subject(ml),
	(
		subject(ai);
		subject(nlp);
		subject(dm)
	),
	(
		programming(python);
		programming(r)
	),
	(
		(
			skill(stats);
			skill(apti)
		),
		skill(dv),
		skill(tensor)
	),
	\+ work(repetitive),
	(
		
		work(creative);
		work(rnd);			
		work(challenging)
	).
	
career(software_enginner):-
	subject(dsa),
	subject(algo),
	skill(apti),
	skill(oopd),
	skill(framework),
	skill(db),
	\+work(repetitive),
	work(dev),
	(
		programming(python);
		programming(c);
		programming(cpp);
		programming(java);
		programming(javascript);
		programming(csharp);
		programming(php)
	),	
	(
			skill(ui);
			skill(db);
			skill(vcs);
			work(tech);
			work(challenging);
			work(creative);
			work(debugging);
			work(maintenance)
			
	).	
	
career(mobile_app_developer):-
	subject(dsa),
	subject(algo),
	skill(framework),
	skill(ui),
	skill(db),
	(
		programming(ios);
		programming(android)
	),
	(
		programming(java);
		programming(javascript);
		programming(cpp);
		programming(c);
		programming(python)
	),
	\+work(repetitive),
	work(dev),
	(
		work(challenging);
		work(creative);
		work(debugging);
		work(maintenance);
		skill(vcs)
	).


career(ai_developer):-
	subject(ai),
	subject(ml),
	programming(java),
	programming(prolog),
	programming(python),
	work(challenging),
	work(rnd),
	skill(apti),
	skill(dv),
	\+work(repetitive),
	(
		subject(dm);
		subject(ir);
		subject(nlp)
	),
	(
		skill(tensor);
		work(maintenance);
		work(creative)
	).
		
		
career(data_scientist):-
	subject(dm),
	subject(ir),
	subject(ml),
	(
		programming(python);
		programming(r);
		programming(java)
	),
	skill(dv),
	skill(apti),
	work(creative),
	work(challenging),
	\+work(repetitive),
	(
		subject(ai);
		subject(nlp);
		subject(dsa);
		subject(algo)
	),
	(	
		work(rnd);
		programming(cpp);
		programming(c);
		work(tech)
	).


career(devOps_enginner):-
	subject(dbms),
	subject(os),
	subject(ds),
	programming(python),
	programming(javascript),
	programming(assembly),
	skill(db),
	skill(testing),
	skill(cloud),
	skill(vcs),
	skill(linux),
	work(creative),
	work(tech),
	work(maintenance),
	work(debugging),
	\+work(repetitive),
	\+work(rnd),
	(
		skill(apti);
		skill(tensor);
		subject(dsa);
		programming(c)
	).
		

career(database_administrator):-
	subject(dbms),
	(
		subject(cn);
		subject(ds)
	),
	programming(sql),
	(
		programming(python);
		programming(cpp);
		programming(java);
		programming(javascript)
	),
	skill(db),
	skill(cloud),
	work(challenging),
	work(maintenance),
	work(tech),
	\+work(repetitive),
	(
		work(creative);
		work(rnd);
		skill(framework);
		skill(testing)
	).
	
career(computer_network_architect):-
	subject(cn),
	subject(cs),
	(
		subject(os);
		subject(ds)
	),
	(
		programming(c);
		programming(java);
		programming(cpp)
	),
	skill(networking),
	work(challenging),
	work(maintenance),
	\+work(repetitive),
	(
		work(creative);
		work(rnd);
		skill(testing)
	).
	

career(web_developer):-
	subject(dsa),
	subject(ds),
	(
		subject(dbms);
		subject(cs)
	),
	programming(javascript),
	(
		programming(python);
		programming(php)
	),
	skill(ui),
	skill(cloud),
	skill(framework),
	work(creative),
	work(dev),
	work(challenging),
	(
		work(rnd);
		work(maintenance);
		skill(testing);
		skill(networking)
	).

career(data_architect):-
	subject(dbms),
	subject(ml),
	subject(dm),
	(
		subject(os);
		subject(dsa);
		subject(ds);
		subject(algo)
	),
	programming(python),
	programming(java),
	programming(sql),
	(
		programming(c);
		programming(cpp)
	),
	skill(db),
	skill(dv),
	skill(linux),
	skill(tensor),
	(	
		skill(networking);
		skill(framework)
	),
	\+work(repetitive),
	work(creative),
	work(challenging),
	work(tech),
	(	
		work(rnd);
		work(dev)
	).

career(sdet):-
	subject(dsa),
	subject(algo),
	(
		programming(java);
		programming(cpp);
		programming(python)
	),
	skill(testing),
	(
		skill(db);
		skill(apti)
	),
	work(debugging),
	work(maintenance),
	(
		work(dev);
		work(challenging)
	).
	
		
/*-----------------------------------------------------------------------------------------------------*/


/*Explain Career*/
	
explain(ml_engineer):-
	write("Machine Learning Engineer : "),nl,
	write("As a machine learning engineer, you will be working in this branch of artificial intelligence, you'll be responsible for creating programmes and algorithms that enable machines to take actions without being directed. This domain will let you put your machine learning expertise into the real world applications").

explain(software_enginner):-
	write("Software enginner"),nl,
	write("A software engineer is a person who applies the principles of software engineering to the design, development, maintenance, testing, and evaluation of computer software.You will be utilizing your object oriented design skills to produce great softwares ").
	
	
explain(mobile_app_developer):-
	write("Mobile App developer"),nl,
	write("As a mobile application developer you will be required to write computer programs for smartphones and other mobile devices. Instead of building for a larger PC screen. In this domain you can utilize your android/ios programming skills properly.").
	

explain(ai_developer):-
	write("Artificial Intelligence Enginner"),nl,
	write("As a professional AI enginner you will be responsible for working with neural networks, algorithms and associated tools to solve problems in business or technology.Your inclination towards AI will help you grow alot in this field").
	
explain(data_scientist):-
	write("Data Scientist"),nl,
	write("As a data scientist, you will be required to build data models and organize structured and unstructured data to interpret solutions. According to your input your skills match up with this profile very well").

explain(devOps_enginner):-
	write("DevOps Enginner"),nl,
	write("As a devOps Engineer you will be required work with software developers, system operators and admins, IT operations staff and others to oversee and/or facilitate code releases or deployments. In this domain you will encounter debugging tasks as well as you will be exposed to use slew of emerging technologies").

explain(database_administrator):-
	write("Database Administrator"),nl,
	write("As a database administrator you will be required to analyze and evaluate the data needs of users. Also develop and improve the data resources used to store and retrieve critical information. This domain is best for people with good database management understanding").

explain(computer_network_architect):-
	write("Computer Network Architect"),nl,
	write("As a computer network architect you will be required to design, implement, and maintain networking and data communication systems, including local area networks, wide area networks, extranets, and intranets. Your computer network skills will help you alot in this career").

explain(web_developer):-
	write("Web Developer"),nl,
	write("Web developers assess the needs of users for information-based resources. They create the technical structure for websites and make sure that web pages are accessible and easily downloadable through a variety of browsers and interfaces.").

explain(data_architect):-
	write("Data Architect"),nl,
	write("Data architects create blueprints for data management systems. After assessing a company's potential data sources (internal and external), architects design a plan to integrate, centralize, protect and maintain them. Your skill in dbms and machine learning will enable you become a very good data architect").

explain(sdet):-
	write("Software Development Engineer in Test"),nl,
	write("This role requires understanding project documents, customer demands, and product objectives to create and execute test cases").
