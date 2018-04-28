
#######################################################################3
#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5   # --- blue
set terminal postscript eps enhanced color
set key samplen 2 spacing 1.5 font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set ylabel "Time (micro sec)"
set xlabel "Number of Elements"
set ytic auto
set xtic auto
set logscale x
set key top left
set output "line1.eps"
plot 'line_1.out'  title "With Thread 1" with linespoints ls 1

#############################################################

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5   # --- blue
set terminal postscript eps enhanced color
set key samplen 2 spacing 1.5 font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set ylabel "Time (micro sec)"
set xlabel "Number of Elements"
set ytic auto
set xtic auto
set logscale x
set key top left
set output "line2.eps"
plot 'line_2.out'  title "With Thread 2" with linespoints ls 1


#############################################################

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5   # --- blue
set terminal postscript eps enhanced color
set key samplen 2 spacing 1.5 font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set ylabel "Time (micro sec)"
set xlabel "Number of Elements"
set ytic auto
set xtic auto
set logscale x
set key top left
set output "line4.eps"
plot 'line_4.out'  title "With Thread 4" with linespoints ls 1


#############################################################

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5   # --- blue
set terminal postscript eps enhanced color
set key samplen 2 spacing 1.5 font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set ylabel "Time (micro sec)"
set xlabel "Number of Elements"
set ytic auto
set xtic auto
set logscale x
set key top left
set output "line8.eps"
plot 'line_8.out'  title "With Thread 8" with linespoints ls 1


#############################################################

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5   # --- blue
set terminal postscript eps enhanced color
set key samplen 2 spacing 1.5 font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set ylabel "Time (micro sec)"
set xlabel "Number of Elements"
set ytic auto
set xtic auto
set logscale x
set key top left
set output "line16.eps"
plot 'line_16.out'  title "With Thread 16" with linespoints ls 1



