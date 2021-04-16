#! /bin/bash

cd eVote-spark && sbt clean package && cd ..
printf "\n\n\nFind the compiled jar in ${PWD}/eVote-spark/target/scala-2.12/ with the name evote-spark_2.12-1.0.0.jar\n\n\n"

echo "Done!"
