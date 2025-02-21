#secure-ssh.sh
#author hayden-siok13
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in

#Check if a usernmae is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1
HOME_DIR="/home/$USERNAME"
SSH_DIR="$HOME_DIR/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authroized_keys"
PUBLIC_KEY_PATH="/home/hayden-loc/.ssh/id_rsa.pub"

# Create user with specified home directory and shell
sudo useradd -m -d "$HOME_DIR" -s /bin/bash "$USERNAME"

# Create .ssh directory
sudo mkdir -p "$SSH_DIR"

# Copy the public key to authorized_keys if it exists
if [ -f "PUBLIC_KEY_PATH" ]; then
    sudo cp "$PUBLIC_KEY_PATH" "$AUTHORIZED_KEYS"
else 
    echo "Public key file not found at $PUBLIC_KEY_PATH"
    exit 1
fi

# Set appropriate permissions
sudo chmod 600 "$AUTHORIZED_KEYS"
sudo chmod 700 "$SSH_DIR"

# Change ownership to the new user
sudo chown -R "$USERNAME:$USERNAME" "$SSH_DIR"

# Code for if root SSH needs to be disabled. If it needs to be disabled uncomment the code below:
# sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config'
# sudo systemctl restart sshd
echo "User $USERNAME created and secured SSH access configured."
