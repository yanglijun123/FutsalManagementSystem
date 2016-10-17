create database IndoorFootball
on primary
(
name='IndoorFootball_data',
filename='F:\五人制足球\IndoorFootball_data.mdf',
size=5mb,
maxsize=100mb,
filegrowth=15%
)
log on
(
name='IndoorFootball_log',
filename='F:\五人制足球\IndoorFootball_log.ldf',
size=2mb,
filegrowth=1mb
)
use IndoorFootball 
create table TeamSum  --球队信息综合  
(
Teamname	nvarchar(20) primary key,--球队名
Leadername	Nvarchar(10),
Teamcoach	Nvarchar(10),
Telephone	Varchar(12),
)
create table TeamPlayer --球员信息综合
(
Playerorder smallint,--球员编号
Teamname	nvarchar(20) unique,--球员名
Playernumber	SMALLINT,--球员在球队中的号码
Playername	nvarchar(20) not null,
Datebirth date ,
Gender bit,--性别
IDnumber char(18),
primary key(Playerorder),
foreign key (Teamname) references TeamPlayer(Teamname)
)
alter table teamplayer add teamname nvarchar(20)
alter table teamplayer add constraint aaa foreign key(Teamname) references teamsum(teamname)
alter table teamplayer drop column gender
alter table teamplayer add gender char(2)
--alter table 球员 add constraint u_球员 unique(球员名)
--alter table TeamPlayer add constraint u_球员号码 unique(号码)
create table JudgeInformation   --裁判信息
(
Judgernumber smallint primary key,
Judgername nvarchar(10),
)
create table TimeKeeperInformation  --计时员信息
(
Timekeepernumber smallint primary key,
Timekeepername nvarchar(10),
)
create table PlayCourt  --球场信息
(
Courtname nvarchar(10)primary key,--
Courtplace nvarchar(10),
)
create table ScheduleArrange
(
Turn nvarchar(10),--轮次
FieldOrder smallint,--场序
fixture datetime,--比赛时间
VSteam varchar(60),--比赛队伍
Courtname nvarchar(10),--球场名
Judgername nvarchar(10),--裁判名
Timekeepername nvarchar(10),--计时员名
primary key(Turn,FieldOrder),
)
create table TopScorer -- 射手榜
(
Playerorder smallint,--球员编号
Playergoals smallint,--总进球数
Playername nvarchar(20),--球员名
Teamname nvarchar(20),--球队名
Playernumber smallint,--号码
Turn nvarchar(10),--轮次
primary key(Playerorder),
foreign key (Playerorder) references TeamPlayer(Playerorder),
foreign key(Teamname)references TeamSum(Teamname),
--foreign key(Playername)references TeamPlayer(Playername)
)
create table LeagueStanding
(
Teamname nvarchar(20)primary key,--球队名
FieldOrder smallint,--场序
Teamscore smallint,--球队得分
Teamlose smallint,--球队失分
GoalDifference smallint,--球队净胜数
Score smallint,--球队积分
Teamranking smallint,--球队排名
Turn nvarchar(10),--轮次
foreign key (Teamname) references TeamSum(Teamname),
)
create table RedYellowCards
(
Playerorder smallint,--球员编号
Turn nvarchar(10),--轮次
Playerredcard smallint,--球员红牌数
Playeryellowcard smallint,--球员黄牌数
Stopperiod nvarchar(10),--停赛期
Playername nvarchar(20),--球员名
Teamname nvarchar(20),--球队名
primary key(Playerorder),
foreign key(Playerorder)references TeamPlayer(Playerorder),
foreign key(Teamname)references TeamSum(Teamname),
)
create table UserInformation
(
Username nvarchar(20),--用户名
userType nvarchar(10),--类别
UserPassword char(10),--登录密码
primary key (Username,userType),
)



--球队基本信息，给球队人员看
create view 球队基本信息
as 
select 球队.球队名 ,教练名,领队名,联系电话,球员名,号码,性别,出生年月,身份证号
from 球员,球队 
where 球员.球队名=球队 .球队名
--球队信息,给一般用户看
create view 球队信息
as
select 球队.球队名 ,教练名,领队名,球员名,号码
from 球员,球队 
where 球员.球队名=球队 .球队名
--工作安排,给工作人员和主办方看
create view 工作安排
as
select 比赛时间,比赛信息 .球场名,球场地点 ,比赛信息 .裁判名 ,裁判员序号 ,比赛信息.计时员名,计时员序号
from 比赛信息 ,裁判员 ,计时员 ,球场 
where 比赛信息 .裁判名=裁判员 .裁判名 and 比赛信息 .计时员名 =计时员 .计时员名 and 球场 .球场名 =比赛信息 .球场名 
--比赛安排,给所有人看
create view 比赛安排
as
select 轮次,场序,比赛时间,主场队伍,客场队伍,球场名
from 比赛信息 
--射手榜公告,所有人可见
create view 射手榜公告
as
select 球队名 ,号码,球员名,总进球数
from 射手榜 ,球员
where 射手榜 .球员编号 =球员.球员编号 
--联赛积分公告,所有人可见
create view 联赛积分公告
as
select  top 100 percent 球队名,场次,球队得分,球队失分,球队净胜数,球队积分
from 联赛积分榜 
order by 球队积分 ,球队净胜数,球队名,场次,球队得分,球队失分
--处罚公告,所有人可见
create view 处罚公告
as
select 球队名 ,号码 ,轮次,球员名,球员黄牌数,球员红牌数,停赛期
from 红黄牌公告,球员 
where 红黄牌公告 .球员编号 =球员 .球员编号

/*******************************/
/****************/
/***************/	建立索引
/**************/
/******************************/

create unique index qiuyuanming on 球员(球员名)
create unique index lunci on 红黄牌公告(轮次)