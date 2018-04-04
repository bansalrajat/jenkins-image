docker run -d --rm -u root -v $PWD/myjenkins-home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -p 9090:8080 -p 9191:9191 myjenkins:latest
