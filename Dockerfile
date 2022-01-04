FROM mcr.microsoft.com/mssql/server:2019-latest
# ubuntu:20.04  
USER root
RUN apt-get update
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN apt-get install curl -y
WORKDIR /app
ADD requirements.txt .
ADD main.py .
#ADD backup file
#Optional
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=Testing1122
#ENV https_proxy=http://[proxy]:[port]
#ENV http_proxy=http://[proxy]:[port]
# install SQL Server tools
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/msprod.list 
RUN apt-get update 
RUN ACCEPT_EULA=Y apt-get install mssql-tools unixodbc-dev -y
RUN ACCEPT_EULA=Y apt-get install msodbcsql17
RUN apt-get install unixodbc -y
# install FreeTDS and dependencies
#RUN apt-get update \
# && apt-get install unixodbc -y \
# && apt-get install freetds-dev -y \
# && apt-get install freetds-bin -y \
# && apt-get install tdsodbc -y \
# && apt-get install --reinstall build-essential -y
# populate "ocbcinst.ini" as this is where ODBC driver config sits
#RUN echo "[FreeTDS]\n\
#Description = FreeTDS Driver\n\
#Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\n\
#Setup = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so" >> /etc/odbcinst.ini
#Pip command without proxy setting
RUN pip install -r requirements.txt
#Use this one if you have proxy setting
#RUN pip --proxy http://[proxy:port] install -r requirements.txt
#CMD ["python","-i","main.py"]
RUN mkdir /home/mssql
RUN chown -R mssql /home/mssql
USER mssql
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
#RUN /opt/mssql/bin/sqlservr --accept-eula & sleep 10
CMD /opt/mssql/bin/sqlservr
#CMD tail -f /dev/null