FROM registry.advanpro.cn/hadoop-base:1.0.0-hadoop2.7.7-java8
MAINTAINER luojimeng <luojimeng@advanpro.hk>

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8042

CMD ["/run.sh"]
