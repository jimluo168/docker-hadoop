DOCKER_NETWORK = dockerhadoop_default
ENV_FILE = hadoop.env
# current_branch := $(shell git rev-parse --abbrev-ref HEAD)
current_branch := 1.0.0-hadoop2.7.7-java8
build:
	docker build -t registry.advanpro.cn/hadoop-base:$(current_branch) ./base
	docker build -t registry.advanpro.cn/hadoop-namenode:$(current_branch) ./namenode
	docker build -t registry.advanpro.cn/hadoop-datanode:$(current_branch) ./datanode
	docker build -t registry.advanpro.cn/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t registry.advanpro.cn/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t registry.advanpro.cn/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t registry.advanpro.cn/hadoop-submit:$(current_branch) ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} registry.advanpro.cn/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} registry.advanpro.cn/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal /opt/hadoop-2.7.7/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} registry.advanpro.cn/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} registry.advanpro.cn/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} registry.advanpro.cn/hadoop-base:$(current_branch) hdfs dfs -rm -r /input
