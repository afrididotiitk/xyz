
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

set key top left
set output "plot"
set xrange [-0.1:0]
set yrange [-1:1.4]
plot cos(x)     ls 1 title 'ls 1'

