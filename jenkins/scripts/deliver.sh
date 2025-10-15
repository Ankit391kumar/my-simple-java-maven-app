# #!/usr/bin/env bash

# echo 'The following Maven command installs your Maven-built Java application'
# echo 'into the local Maven repository, which will ultimately be stored in'
# echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
# echo 'volume).'
# set -x
# mvn jar:jar install:install help:evaluate -Dexpression=project.name
# set +x

# echo 'The following command extracts the value of the <name/> element'
# echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
# set -x
# NAME=`mvn -q -DforceStdout help:evaluate -Dexpression=project.name`
# set +x

# echo 'The following command behaves similarly to the previous one but'
# echo 'extracts the value of the <version/> element within <project/> instead.'
# set -x
# VERSION=`mvn -q -DforceStdout help:evaluate -Dexpression=project.version`
# set +x

# echo 'The following command runs and outputs the execution of your Java'
# echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
# set -x
# java -jar target/${NAME}-${VERSION}.jar


#!/usr/bin/env bash

set -e  # Exit on error
set -x  # Debug mode

# Install the jar and evaluate project metadata
mvn jar:jar install:install help:evaluate -Dexpression=project.name

# Get artifact name and version
NAME=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.name)
VERSION=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.version)

JAR_FILE="target/${NAME}-${VERSION}.jar"

# Check if jar file exists
if [[ ! -f "$JAR_FILE" ]]; then
    echo "❌ JAR file not found: $JAR_FILE"
    exit 1
fi

# Rename JAR for Docker if needed
cp "$JAR_FILE" target/app.jar

# Build Docker image
docker build -t ${NAME}:${VERSION} .

# Optional: Stop and remove previous container
docker rm -f ${NAME} || true

# Run Docker container
docker run -d -p 8090:8090 --name ${NAME} ${NAME}:${VERSION}
