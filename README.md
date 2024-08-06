
# Server Resources Test Script

This script, `test_server_resources.sh`, is designed to monitor and report on various server resources such as CPU usage, memory usage, disk space, and network activity. It provides a quick overview of the current state of your server's resources.

## Usage

### Direct Execution

1. Clone the repository to your local machine:
   ```sh
   git clone https://github.com/sarabbafrani/servtest.git
   ```

2. Navigate to the repository directory:
   ```sh
   cd servtest
   ```

3. Make the script executable:
   ```sh
   chmod +x test_server_resources.sh
   ```

4. Run the script:
   ```sh
   ./test_server_resources.sh
   ```

### One-liner with `curl`

You can download and execute the script directly using `curl`:

```sh
curl -sSL https://raw.githubusercontent.com/sarabbafrani/servtest/main/test_server_resources.sh | bash
```

### One-liner with `wget`

Alternatively, you can use `wget` to achieve the same result:

```sh
wget -qO- https://raw.githubusercontent.com/sarabbafrani/servtest/main/test_server_resources.sh | bash
```

## Script Details

The `test_server_resources.sh` script performs the following tasks:

- Checks CPU usage
- Monitors memory usage
- Reports disk space utilization
- Displays network activity

## Requirements

- Bash shell
- Basic Unix utilities (e.g., `top`, `free`, `df`, `netstat`)
