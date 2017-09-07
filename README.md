### 初次运行
添加box  vagrant box add --name ubuntu1604 xenial-server-cloudimg-amd64-vagrant.box  
#vagrant  https://www.vagrantup.com/  
#https://atlas.hashicorp.com/ubuntu/boxes/xenial64/versions/20170509.0.0/providers/virtualbox.box  
vagrant init ubuntu/xenial64; vagrant up --provider virtualbox  

### ssh参数
ssh IP 192.168.56.87 Port 22  
Username: ubuntu  
privatekey: xxxxxx\webcms\.vagrant\machines\default\virtualbox\private_key  

#若用putty等ssh登陆，需要采用puttygen将key转化为putty所支持格式  
修改密码passwd  


### 执行
sudo -s  
apt-get update  
apt-get upgrade  
apt-get install virtualbox-guest-utils  
apt-get install puppet  

### host
vagrant reload  
vagrant provision    
可多次运行  


若puppet没有自动执行，可能sudo apt-get install puppet  
no module name djangobower 访问https://django-bower.readthedocs.io/en/latest/installation.html  
no module name MySQLdb  采用sudo apt-get install python-mysqldb，pip安装会失败  

### http://127.0.0.1:8100/  


## 编程环境
    sudo -s
    django 没有自动安装，pip install django
    django-admin startproject webcms

    cd /home/vhost/webcms/webcms
    source /home/virtualenvs/webcms/bin/activate


    django-bower 没有自动安装 pip install django-bower
    python manage.py runserver 0.0.0.0:8000
    http://192.168.56.87:8000/


## 多语言
brew install gettext
-template
    'django.template.context_processors.i18n',  

-Middleware
    'django.middleware.locale.LocaleMiddleware',  
    django-admin makemessages -l zh-hans  
    django-admin makemessages -l en  
    django-admin compilemessages  

## 数据迁移
python manage.py makemigrations  
python manage.py migrate  
python manage.py createsuperuser  
administrator:super@admin  

python manage.py migrate --fake-initial  
python manage.py migrate --database=xmuorg_db  

## 多数据库
http://code.ziqiangxuetang.com/django/django-multi-database.html  


## bower
#https://django-bower.readthedocs.io/en/latest/installation.html  
#https://github.com/nvbn/django-bower/issues/51  
pip install django-bower  
python manage.py bower_install --allow-root  

## BBS django-machina https://django-machina.readthedocs.io/en/stable/



## Wamp部署 http://blog.csdn.net/chao_8023/article/details/74495116
download wamp
$ pip install mod_wsgi

$ mod_wsgi-express module-config
## add to http.conf
  LoadFile "c:/users/administrator/appdata/local/programs/python/python36/python36.dll"

  LoadModule wsgi_module "c:/users/administrator/appdata/local/programs/python/python36/lib/site-packages/mod_wsgi/server/mod_wsgi.cp36-win_amd64.pyd"

  WSGIPythonHome "c:/users/administrator/appdata/local/programs/python/python36"

## add vhost.conf
    <VirtualHost *:80>
        WSGIScriptAlias / c:/mswang/webcms/forum/forum/wsgi.py  

        ServerName forum.xmu.edu.cn
        
        DocumentRoot "c:/mswang/webcms/forum/"

        <Directory />
            Options FollowSymLinks
            AllowOverride None
        </Directory>

        <Directory  "c:/mswang/webcms/forum/forum">
            <Files wsgi.py>  
            Require all granted  
            </Files>
        </Directory>
    </VirtualHost>


$ pip install mysqlclient

$ 