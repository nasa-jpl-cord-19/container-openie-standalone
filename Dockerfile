FROM mozilla/sbt as build

WORKDIR /srv

RUN git clone --depth=1 https://github.com/dair-iitd/OpenIE-standalone 
RUN mkdir -p /srv/OpenIE-standalone/{lib,data}

COPY ./BONIE.jar /srv/OpenIE-standalone/lib/BONIE.jar
COPY ./ListExtractor.jar /srv/OpenIE-standalone/lib/ListExtractor.jar

WORKDIR /srv/OpenIE-standalone/srlie
RUN sbt compile && sbt publishLocal

WORKDIR /srv/OpenIE-standalone/ONRE
RUN sbt compile && sbt publishLocal

# COPY ./languageModel /srv/OpenIE-standalone/data/languageModel

WORKDIR /srv/OpenIE-standalone
# Yes I know this is probably dangerous but it wouldn't build in the container without it
RUN echo 'test in assembly := {}' >> build.sbt
RUN sbt clean
RUN sbt compile
RUN sbt -J-Xmx10000M assembly

FROM openjdk:8-jre-slim
RUN mkdir -p /srv/{lib,data}
COPY --from=build /srv/OpenIE-standalone/lib/BONIE.jar /srv/lib/BONIE.jar
COPY --from=build /srv/OpenIE-standalone/lib/ListExtractor.jar /srv/lib/ListExtractor.jar
COPY ./languageModel /srv/data/languageModel
COPY --from=build /srv/OpenIE-standalone/target/scala-2.10/openie-assembly-5.0-SNAPSHOT.jar /srv/openie-assembly.jar
WORKDIR /srv
ENTRYPOINT [ "java", "-Xmx20g", "-XX:+UseConcMarkSweepGC", "-jar",  "openie-assembly.jar", "--httpPort", "8182" ]
