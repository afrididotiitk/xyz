#set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5   # --- blue
#set key font ",22"
#set xtics font ",22"
#set ytics font ",22"
#set ylabel font ",25"
#set xlabel font ",25"
#set xtic auto
#set ytic auto

set output "line_1.eps"
#set title "Line Graph with Thread =1"
#set xlabel "Number of ELements"
#set ylabel "Time(in microseconds)"
#set logscale x
plot "line_1.out"  with linespoints #ls 1    