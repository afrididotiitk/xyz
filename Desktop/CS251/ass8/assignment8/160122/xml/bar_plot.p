set terminal png size 800,500 enhanced font "Helvetica,20"

red = "#FF0000"; green = "#00FF00"; blue = "#0000FF"; skyblue = "#87CEEB";
yellow="#FFFF00"
set yrange [0:20]
set style data histogram
set style fill solid
set boxwidth 0.9
set xtics format ""
set grid ytics
set output "as.eps"
set title "A Sample Bar Chart"
plot "bar_plot.out" using 2:xtic(1) title "Thread=1" linecolor rgb red, \
            '' using 3 title "Thread=2" linecolor rgb blue, \
            '' using 4 title "Thread=4" linecolor rgb green, \
            '' using 5 title "Thread=8" linecolor rgb skyblue, \
            '' using 6 title "Thread=16" linecolor rgb yellow
