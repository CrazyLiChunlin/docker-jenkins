# docker container for jenkins
# jenkins + plugins
#
FROM docker-base:1
MAINTAINER papaleo lee <papaleo@qq.com>

ENV JENKINS_USER jenkins
ENV JENKINS_HOME /home/jenkins/data
RUN useradd -d /home/jenkins ${JENKINS_USER} && mkdir /home/jenkins && chown jenkins:jenkins /home/jenkins
RUN gosu ${JENKINS_USER} mkdir -p ${JENKINS_HOME}

# create jenkins user
RUN gosu ${JENKINS_USER} mkdir -p ${JENKINS_HOME}/plugins

RUN curl -L http://mirrors.jenkins-ci.org/war/latest/jenkins.war -o /home/jenkins/jenkins.war
#ADD ./jenkins.war /home/jenkins/jenkins.war

VOLUME ${JENKINS_HOME}
WORKDIR ${JENKINS_HOME}

# install plugins
ENV PLUGINS_ENDPOINT=http://updates.jenkins-ci.org/latest/
ENV PLUGINS_DIR=${JENKINS_HOME}/plugins
RUN curl -L $PLUGINS_ENDPOINT/hipchat.hpi -o ${PLUGINS_DIR}/hipchat.hpi
RUN curl -L $PLUGINS_ENDPOINT/greenballs.hpi -o ${PLUGINS_DIR}/greenballs.hpi
RUN curl -L $PLUGINS_ENDPOINT/credentials.hpi -o ${PLUGINS_DIR}/credentials.hpi
RUN curl -L $PLUGINS_ENDPOINT/ssh-credentials.hpi -o ${PLUGINS_DIR}/ssh-credentials.hpi
RUN curl -L $PLUGINS_ENDPOINT/ssh-agent.hpi -o ${PLUGINS_DIR}/ssh-agent.hpi
RUN curl -L $PLUGINS_ENDPOINT/git-client.hpi -o ${PLUGINS_DIR}/git-client.hpi
RUN curl -L $PLUGINS_ENDPOINT/git.hpi -o ${PLUGINS_DIR}/git.hpi
RUN curl -L $PLUGINS_ENDPOINT/github.hpi -o ${PLUGINS_DIR}/github.hpi
RUN curl -L $PLUGINS_ENDPOINT/github-api.hpi -o ${PLUGINS_DIR}/github-api.hpi
RUN curl -L $PLUGINS_ENDPOINT/ghprb.hpi -o ${PLUGINS_DIR}/ghprb.hpi
RUN curl -L $PLUGINS_ENDPOINT/github-oauth.hpi -o ${PLUGINS_DIR}/github-oauth.hpi
RUN curl -L $PLUGINS_ENDPOINT/scm-api.hpi -o ${PLUGINS_DIR}/scm-api.hpi
RUN curl -L $PLUGINS_ENDPOINT/postbuild-task.hpi -o ${PLUGINS_DIR}/postbuild-task.hpi
RUN curl -L $PLUGINS_ENDPOINT/bitbucket.hpi -o ${PLUGINS_DIR}/bitbucket.hpi 
RUN curl -L $PLUGINS_ENDPOINT/gradle.hpi -o ${PLUGINS_DIR}/gradle.hpi
RUN curl -L $PLUGINS_ENDPOINT/ldap.hpi -o ${PLUGINS_DIR}/ldap.hpi
RUN curl -L $PLUGINS_ENDPOINT/gerrit-trigger.hpi -o ${PLUGINS_DIR}/gerrit-trigger.hpi
RUN curl -L $PLUGINS_ENDPOINT/job-dsl.hpi -o ${PLUGINS_DIR}/job-dsl.hpi
RUN curl -L $PLUGINS_ENDPOINT/subversion.hpi -o ${PLUGINS_DIR}/subversion.hpi
RUN curl -L $PLUGINS_ENDPOINT/token-macro.hpi -o ${PLUGINS_DIR}/token-macro.hpi
RUN curl -L $PLUGINS_ENDPOINT/plain-credentials.hpi -o ${PLUGINS_DIR}/plain-credentials.hpi
RUN curl -L $PLUGINS_ENDPOINT/mercurial.hpi -o ${PLUGINS_DIR}/mercurial.hpi
#ADD ./plugins/*.hpi ${JENKINS_HOME}/plugins/
#RUN cp ${PLUGINS_DIR}/* ${JENKINS_HOME}/plugins/
#RUN ls -l ${JENKINS_HOME}/plugins/ >&2

ENTRYPOINT ["gosu", "jenkins", "java", "-jar", "/home/jenkins/jenkins.war"]
EXPOSE 8080
#CMD ["/bin/bash", "gosu jenkins java -jar /var/lib/jenkins/jenkins.war"]

