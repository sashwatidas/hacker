#!/bin/sh
PASS=0
FAIL=0
TEST_1=$(find /home/user/.jenkins/secrets/initialAdminPassword | wc -l)
TEST_2=$(find /home/user/.jenkins/jobs/MavenDemo/builds -name build.xml -exec grep -o "SUCCESS" {} \; | wc -l)
TEST_3=$(find /home/user/.jenkins/workspace/MavenDemo/target/surefire-reports/TEST-*xml | wc -l)
TEST_4=$(find /home/user/.jenkins/jobs/MavenDemo/builds -name junitResult.xml -exec grep -o "/home/user/.jenkins/workspace/MavenDemo/target/surefire-reports/TEST-.*xml" {} \; | wc -l)
TEST_5=$(grep -o -e "com.cloudbees.jenkins.GitHubPushTrigger" -e "clean" -e "install" -e "https://github.com/frescoplaylab/maven-war.git" -e "target/surefire-reports/TEST-.*xml" /home/user/.jenkins/jobs/MavenDemo/config.xml| wc -l)

if [ "$TEST_1" -eq 1 ]
then ((PASS++))
fi;

if [ "$TEST_2" -ge 1 ]
then ((PASS++))
fi;

if [ "$TEST_3" -ge 1 ]
then ((PASS++))
fi;

if [ "$TEST_4" -ge 1 ]
then ((PASS++))
fi;

if [ "$TEST_5" -ge 6 ]
then ((PASS++))
fi;



FAIL=$(( 5 - $PASS ))

echo "Test cases executed = 5";
echo "PASS = $PASS   FAIL=$FAIL" 