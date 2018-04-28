all: App runtest analyse plot report
CFLAGS= -I.  -pthread 
OBJECTS=prog.o thread_function.o
PLOTDATA=outputfile16.out outputfile1.out outputfile2.out outputfile4.out outputfile8.out
LINEDATA=line_1.out line_2.out line_4.out line_8.out line_16.out
maths=-lm
App:$(OBJECTS)
	gcc  $(CFLAGS) prog.o thread_function.o -lm -o App
prog.o: prog.c common.h
	gcc $(maths) -c $(CFLAGS) prog.c 
thread_function.o: thread_function.c common.h
	gcc $(maths) -c $(CFLAGS) thread_function.c 
runtest:App params.txt
#echo "Hello"
	python file_1.py
analyse:$(PLOTDATA) runtest
	python analyse.py 
plot:analyse plots.p plot.p scatter.p 
	gnuplot dum.p 
	gnuplot plots.p
	gnuplot plot.p
	gnuplot scatter.p
report:plot reports.tex
	echo "REPORT" > report
	pdflatex reports.tex 
clean:
	rm $(OBJECTS)  App analyse runtest plot 
	rm *.out
	rm *.eps
	rm *.aux
	rm *.log
	rm *.pdf
	rm report
