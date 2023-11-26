# Docker ElasticSearch Kibana MongoDB Monstache

## 이 프로젝트는 오프소스를 참고하여 보안설정을 제외한 간소화한 버전입니다

참고: https://github.com/akdev-tech/docker-elastic-monstache.git

[MongoDB Change stream](https://www.mongodb.com/docs/manual/changeStreams/)를 이용하면 몽고DB의 데이터와 변경점등을
엘라스틱서치에 자동으로 동기화가 가능합니다.

## Getting Started

~~이 프로젝트를 클론하고 구동한 뒤, 몽고쉘에서 레플리카셋을 설정해줘야 정상 작동합니다.~~ <br>
sh 파일 덕분에 더이상 레플리카셋을 수동으로 구동 안 해도 됩니다.

### Installing

```
$ git clone https://github.com/JeonB/doc-ela-mon.git
$ cd doc-ela-mon
```

이 프로젝트는 mongodb의 유저 설정 및 보안 설정 하지 않기에 `.env`파일을 따로 수정하지 않아도 됩니다.

### Running

```
$ docker-compose up -d
```

## Default configuration

### MongoDB

__아래 작업은 더 이상 불필요합니다. 수동으로 레플리카셋을 구성하는 방법이므로 참고만 해주세요!__

1. 몽고쉘 접속
```
$ docker exec -it mongo1 mongosh
```
2. 하단의 레플리카 초기화 명령어 입력
```
   rs.initiate({
   "\_id": "myReplicaSet",
   "members": [
   {
   "_id": 0,
   "host": "mongo1:27017",
   "priority": 2,
   "votes": 1
   },
   {
   "_id": 1,
   "host": "mongo2:27017",
   "priority": 0.5,
   "votes": 1
   },
   {
   "_id": 2,
   "host": "mongo3:27017",
   "priority": 0.5,
   "votes": 1
   }
   ]
   });
```
3. 더미데이터 삽입
```
   for (var i = 1; i <= 25; i++) {
   db.mycollection.insert( { x : i } )
   }
```
4. 컨테이너 재시작
-----------------
```
유의사항
mongodb://mongo1:27017,mongo2:27017,mongo3:27017/servicename?replicaSet=myReplicaSet
mongo-compass를 통해 위 url로 접속하여 직접 데이터 삽입 및 수정이 가능하지만, etc/hosts에서
127.0.0.1 mongo1
127.0.0.1 mongo2
127.0.0.1 mongo3
위와 같이 호스트 네임을 추가해야 합니다.
```

### ElasticSearch

http://127.0.0.1:9200

### Kibana web interface

http://127.0.0.1:5601

## Built With These Docker Images

- [MongoDB](https://hub.docker.com/_/mongo)
- [ElasticSearch](https://hub.docker.com/_/elasticsearch)
- [Kibana](https://hub.docker.com/_/kibana)
- [Monstache](https://hub.docker.com/r/rwynn/monstache)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
