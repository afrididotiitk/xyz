#set terminal postscript eps enhanced color size 3.9,2.9
set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "speedup.eps"

set key font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "Number of Elements"
set ylabel "Application speedup"
set yrange[0:]
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border
plot "bar_plot.out" using 2:xtic(1) title "Thread=1" , \
            '' using 3 title "Thread=2" fillstyle pattern 2, \
            '' using 4 title "Thread=4" fillstyle pattern 4, \
            '' using 5 title "Thread=8" fillstyle pattern 7, \
            '' using 6 title "Thread=16" fillstyle pattern 12 

set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "speedup_error.eps"
set xtics rotate by -45
set ytic auto 
#set yrange[-1:]
set style histogram errorbars lw 3
set style data histogram
plot "bar_plot.out" using 2:7:xticlabels(1) title "Thread=1" , \
            '' using 3:8 title "Thread=2" fillstyle pattern 2, \
            '' using 4:9 title "Thread=4" fillstyle pattern 4, \
            '' using 5:10 title "Thread=8" fillstyle pattern 7, \
            '' using 6:11 title "Thread=16" fillstyle pattern 12 