TEST_DIR=/tmp/civicrm-buildkit-docker.baseurlenvvarTest
rm -r $TEST_DIR
mkdir $TEST_DIR
cd $TEST_DIR
git clone https://github.com/tiotsop01/civicrm-buildkit-docker
cd civicrm-buildkit-docker
git checkout tiotsop
docker-compose -p baseurlenvar down -v
docker volume rm -f `docker volume ls  -q --f name=baseurlenvar*`
export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120
docker-compose -p baseurlenvar up -d
docker-compose -p baseurlenvar exec -u buildkit civicrm git config --global user.name Test
docker-compose -p baseurlenvar exec -u buildkit civicrm git config --global user.email test@example.com
docker-compose -p baseurlenvar exec -u buildkit civicrm civibuild create dmaster --patch https://github.com/civicrm/civicrm-core/pull/12307
