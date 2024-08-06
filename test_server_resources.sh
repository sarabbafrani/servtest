#!/bin/bash

# Function to check if a package is installed
is_installed() {
    if dpkg -s "$1" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Function to install a package
install_package() {
    echo "Installing $1..."
    sudo apt-get install -y "$1"
}

# Function to ensure required packages are installed
ensure_packages() {
    packages=("sysbench" "iperf3")
    for package in "${packages[@]}"; do
        if ! is_installed "$package"; then
            install_package "$package"
        fi
    done
}

# Function to measure CPU performance
measure_cpu() {
    echo "Measuring CPU performance..."
    cpu_result=$(sysbench cpu --time=60 run | grep "events per second" | awk '{print $4}')
    echo "CPU Performance: $cpu_result events per second"
}

# Function to measure memory performance
measure_memory() {
    echo "Measuring Memory performance..."
    memory_result=$(sysbench memory --time=60 run | grep "transferred" | awk '{print $4}')
    echo "Memory Performance: $memory_result"
}

# Function to measure disk I/O performance
measure_disk_io() {
    echo "Measuring Disk I/O performance..."
    disk_result=$(sysbench fileio --file-total-size=1G prepare; sysbench fileio --file-total-size=1G --file-test-mode=rndrw --time=60 run; sysbench fileio --file-total-size=1G cleanup | grep "Requests/sec" | awk '{print $2}')
    echo "Disk I/O Performance: $disk_result requests/sec"
}

# Function to measure network performance
measure_network() {
    echo "Measuring Network performance..."
    network_result=$(iperf3 -c iperf.he.net -p 5201 -t 60 | grep "sender" | awk '{print $7 " " $8}')
    echo "Network Performance: $network_result"
}

# Function to measure network latency
measure_latency() {
    echo "Measuring Network latency..."
    latency_result=$(ping -c 10 iperf.he.net | tail -1 | awk -F '/' '{print $5 " ms"}')
    echo "Network Latency: $latency_result"
}

# Function to measure network packet loss
measure_packet_loss() {
    echo "Measuring Network packet loss..."
    packet_loss_result=$(ping -c 10 iperf.he.net | grep 'packet loss' | awk -F ', ' '{print $3}' | awk '{print $1}')
    echo "Network Packet Loss: $packet_loss_result"
}

# Function to measure network jitter
measure_jitter() {
    echo "Measuring Network jitter..."
    jitter_result=$(ping -c 10 iperf.he.net | tail -1 | awk -F '/' '{print $6 " ms"}')
    echo "Network Jitter: $jitter_result"
}

# Function to estimate concurrent users
estimate_concurrent_users() {
    echo "Estimating concurrent users..."
    # This is a simplistic estimation based on CPU performance
    concurrent_users=$(echo "$cpu_result * 10" | bc)
    echo "Estimated Concurrent Users: $concurrent_users"
}

# Function to print results in a table format with animation
print_results() {
    echo "----------------------------------------"
    echo "| Resource         | Performance      |"
    echo "----------------------------------------"
    echo -ne "| CPU              | $cpu_result events per second |"
    sleep 1
    echo -ne "\r| Memory           | $memory_result             |"
    sleep 1
    echo -ne "\r| Disk I/O         | $disk_result requests/sec  |"
    sleep 1
    echo -ne "\r| Network          | $network_result            |"
    sleep 1
    echo -ne "\r| Network Latency  | $latency_result            |"
    sleep 1
    echo -ne "\r| Network Packet Loss | $packet_loss_result       |"
    sleep 1
    echo -ne "\r| Network Jitter   | $jitter_result             |"
    sleep 1
    echo -ne "\r| Concurrent Users | $concurrent_users           |"
    sleep 1
    echo -ne "\r----------------------------------------\n"
}

# Main script execution
echo "Starting server resource tests..."

# Ensure required packages are installed
ensure_packages

measure_cpu
measure_memory
measure_disk_io
measure_network
measure_latency
measure_packet_loss
measure_jitter
estimate_concurrent_users

print_results

echo "Server resource tests completed."
