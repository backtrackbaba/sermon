ram_utilization=$(free | grep Mem | awk '{print int($3/$2 * 100.0)}')
cpu_consumption=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%2.2f\n",usage}')
disk_utilization=$(df -h --total | awk '/total/{print $3}')

echo Free Ram: $ram_utilization %
curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "value": '"$ram_utilization"' }' \http://sermon-tool.herokuapp.com/widgets/ram

echo CPU Consumption: $cpu_consumption %
curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "current": '"$cpu_consumption"' }' \http://sermon-tool.herokuapp.com/widgets/cpu

echo Disk Utilization: $disk_utilization"B"
curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "text": "'"$disk_utilization"B""'" }' \http://sermon-tool.herokuapp.com/widgets/disk