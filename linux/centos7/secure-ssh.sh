#secure-ssh.sh
#author hayden-siok13
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in

# Create user sys265 user with specified home directory and shell
sudo useradd -m -d /home/sys265 -s /bin/bash sys265

#Create .ssh directory
sudo mkdir /home/sysy265/.ssh

#Copy the public key to authorized_keys
sudo cp SYS265/linux/public-keys/id_rsa.pub /home/sys265/.ssh/authorized_keys

# Set appropriate permissions
sudo chmod 700 /home/sys265/.ssh
sudo chmod 600 /home/sys265/.ssh/authorized_keys

# Change ownership to sys265
sudo chown -R sys265:sys265 /home/sys265/.ssh

# Disable root SSH access
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "User sys265 created and secured SSH access configured."
