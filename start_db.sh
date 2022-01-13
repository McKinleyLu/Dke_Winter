C_NAME="our_dke_db"  #bash用双引号  等号两边不能有空格
PASSWORD="123"


before(){
    echo "yes....hahaha$1"
    docker stop "$1"
    docker rm "$1"
    echo ""
}

# start db
start_db(){
echo "start db......"
docker run \
    --detach \
    --name "${C_NAME}" \
    --env MARIADB_USER=example-user \
    --env MARIADB_PASSWORD=my_cool_secret \
    --env MARIADB_ROOT_PASSWORD="${PASSWORD}"  \
    mariadb:latest
}
test(){
    echo "do some test..."
    sudo apt install -y mysql-client
    sleep 10
    mysql -u root -h "172.17.0.2" -p${PASSWORD} -e "show databases;"
    echo ""
}
# detach 即使关闭终端仍然会运行
# name   名字
# env传环境变量(参数)
# startdb批处理脚本
# 使用 bash start_db.sh
before "${C_NAME}"
start_db 
test 