# ĐIỀU CHỈNH VERSION MUỐN CÀI ĐẶT

OPEN_JDK=17
MAVEN=3.9.6
APACHE_SPARK=3.5.1
CLANG=17.0.6
BAZEL=6.5.0

# Cập nhật
echo "----------------Update repository--------------------"
sudo apt update && sudo apt upgrade -y
echo "Update completed successfully."

# Tạo SSH key
echo "----------------Generate SSH KEY--------------------"
ssh-keygen -t ed25519 -C git -f ~/.ssh/git -N "" -q
ssh-keygen -t ed25519 -C ansible -f ~/.ssh/ansible -N "" -q
ssh-keygen -t ed25519 -C global -f ~/.ssh/global -N "" -q

echo "# ssh agent" >> ~/.bashrc
echo "alias ssha='eval \$(ssh-agent) && ssh-add ~/.ssh/git && ssh-add ~/.ssh/ansible && ssh-add ~/.ssh/global'" >> ~/.bashrc
echo "ssha" >> ~/.bashrc
echo "" >> ~/.bashrc
source ~/.bashrc
echo "SSH keys generated and added to agent successfully."

# Git config
echo "----------------Git Config--------------------------"
git config --global user.name "Hoang Vo"
git config --global user.email "vohoang.w2002@gmail.com"
echo "Git configured successfully."

# Cài java 17
echo "-----------------Install Open JDK ------------------"
sudo apt install openjdk-${OPEN_JDK}-jdk -y
echo "Java ${OPEN_JDK} installed successfully."

# Cài maven
echo "-----------------Install MAVEN ------------------"
cd /tmp
wget https://dlcdn.apache.org/maven/maven-3/${MAVEN}/binaries/apache-maven-${MAVEN}-bin.tar.gz
sudo tar -xzvf apache-maven-${MAVEN}-bin.tar.gz -C /opt
echo "export MAVEN_HOME=/opt/apache-maven-${MAVEN}-bin" >> ~/.bashrc
echo "export PATH=\$MAVEN_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc
echo "Maven ${MAVEN} installed successfully."

# Cài spark 3.5.1
echo "-----------------Install Apache Spark ------------------"
wget https://dlcdn.apache.org/spark/spark-${APACHE_SPARK}/spark-${APACHE_SPARK}-bin-hadoop3.tgz
sudo tar -xvzf spark-${APACHE_SPARK}-bin-hadoop3.tgz -C /opt
echo "export SPARK_HOME=/opt/spark-${APACHE_SPARK}-bin-hadoop3" >> ~/.bashrc
echo 'export PATH=$PATH:$SPARK_HOME/bin' >> ~/.bashrc
source ~/.bashrc
echo "Apache Spark ${APACHE_SPARK} installed successfully."

# Cài miniconda
echo "-----------------Install Miniconda------------------"
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
echo "Miniconda installed successfully."

# Cài Clang
echo "-----------------Install Clang------------------"
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANG}/clang+llvm-${CLANG}-x86_64-linux-gnu-ubuntu-22.04.tar.xz
tar -xvf clang+llvm-${CLANG}-x86_64-linux-gnu-ubuntu-22.04.tar.xz
sudo cp -r clang+llvm-${CLANG}-x86_64-linux-gnu-ubuntu-22.04/* /usr
echo "Clang ${CLANG} installed successfully."

# Cài bazel
echo "-----------------Install Bazel------------------"
sudo apt install apt-transport-https curl gnupg -y
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
sudo apt update
sudo apt install bazel-${BAZEL} -y
sudo ln -s /usr/bin/bazel-${BAZEL} /usr/bin/bazel
echo "Bazel ${BAZEL} installed successfully."

# Cài ansible
echo "-----------------Install Ansible------------------"
sudo apt install ansible -y
echo "Ansible installed successfully."

# Cài helm
echo "-----------------Install Helm------------------"
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=\$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm -y
echo "Helm installed successfully."

# Cài aws-cli
echo "-----------------Install AWS_CLI-----------------"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
./aws/install -i /usr/local/aws-cli -b /usr/local/bin
echo "AWS CLI installed successfully."

# Cài Nginx, MongoDB, Mysql, MriaDB
echo "-----------------Install NGINX, MYSQL, MARIA DB-----------------"
sudo apt install nginx -y && \
sudo apt install mysql-server -y && \
sudo apt install mariadb-server -y 
sudo systemctl stop nginx mysql mariadb
sudo systemctl disable nginx mysql mariadb
echo "NGINX, MYSQL, and MARIA DB installed successfully."

# Cài Terraform
echo "-----------------Install Terraform-----------------"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y
echo "Terraform installed successfully."