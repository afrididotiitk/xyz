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
set output "scatter_1.eps"
plot 'outputfile1.out'  title "With Thread 1" with points ls 1




##################################################
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
set output "scatter_2.eps"
plot 'outputfile2.out'  title "With Thread 2" with points ls 1




##################################################
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
set output "scatter_4.eps"
plot 'outputfile4.out'  title "With Thread 4" with points ls 1




##################################################
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
set output "scatter_8.eps"
plot 'outputfile8.out'  title "With Thread 8" with points ls 1




##################################################
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
set output "scatter_16.eps"
plot 'outputfile16.out'  title "With Thread 16" with points ls 1
