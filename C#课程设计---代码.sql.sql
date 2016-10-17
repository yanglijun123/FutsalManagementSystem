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
Alter table teamplayer Add  Constraint  PK_Playerorder  Primary  Key (Playerorder)
alter table teamplayer add Playerorder int identity(1,1)
alter table teamplayer drop constraint aaa
alter table teamplayer add teamname nvarchar(20)
alter table teamplayer add constraint aaa foreign key(Teamname) references teamsum(teamname)
alter table teamplayer drop column Playorder
alter table teamplayer add gender char(2)
--alter table 球员 add constraint u_球员 unique(球员名)
--alter table TeamPlayer add constraint u_球员号码 unique(号码)
create table JudgeInformation   --裁判信息
(
Judgernumber smallint primary key,
Judgername nvarchar(10),
)
alter table Judgeinformation add Judgernumber int identity(1,1)
alter table Judgeinformation drop column Judgernumber 
alter table Judgeinformation drop constraint PK__JudgeInf__3A90779A5629CD9C
alter table judgeinformation add Judgername nvarchar(10) primary key
create table TimeKeeperInformation  --计时员信息
(
Timekeepernumber smallint primary key,
Timekeepername nvarchar(10),
)
alter table TimeKeeperInformation add Timekeepernumber int identity(1,1)
alter table TimeKeeperInformation drop constraint PK__TimeKeep__3AA2E11D1367E606
alter table TimeKeeperInformation add Timekeepername nvarchar(10) primary key

create table PlayCourt  --球场信息
(
Courtname nvarchar(10)primary key,--
Courtplace nvarchar(10),
)
--比赛安排
create table ScheduleArrange
(
Turn int,--轮次
FieldOrder smallint,--场序
fixture datetime,--比赛时间
VSteam varchar(60),--比赛队伍
Courtname nvarchar(10),--球场名
Judgername nvarchar(10) not null,--裁判名
Timekeepername nvarchar(10) not null,--计时员名
teama nvarchar(20) not null,
teamb nvarchar(20) not null,
primary key(Turn,FieldOrder),
)
 --select   convert(varchar(10),getdate(),120)   
alter table ScheduleArrange drop constraint FK_Timekeepername

alter table ScheduleArrange drop column VSteam
alter table ScheduleArrange add TeamA nvarchar(20)
alter table ScheduleArrange add TeamB nvarchar(20)
alter table ScheduleArrange add constraint FK_TeamA foreign key(TeamA) references TeamSum(Teamname)
alter table ScheduleArrange add constraint FK_TeamB foreign key(TeamB) references TeamSum(Teamname)
alter table ScheduleArrange add constraint FK_Judgername foreign key(Judgername) references Judgeinformation(Judgername)
--获得日期和时间
select CONVERT(varchar(100),fixture,5) from ScheduleArrange
select DATENAME(MM,fixture)+'-'+datename(DD,fixture)+'-'+datename(HH,fixture)+'-'+datename(MINUTE,fixture)'fixture' from ScheduleArrange

--对赛事安排的查询
select Turn,FieldOrder,CONVERT(varchar(100),fixture,20)fixture,
Courtname,Judgername,Timekeepername,TeamA,TeamB  from ScheduleArrange

create table TopScorer -- 射手榜
(
Playerorder smallint,--球员编号
Playergoals smallint,--总进球数
Playername nvarchar(20),--球员名
Teamname nvarchar(20),--球队名
Playernumber smallint,--号码
Turn nvarchar(10),--轮次
--primary key(Playerorder),
foreign key (Playerorder) references TeamPlayer(Playerorder),
foreign key(Teamname)references TeamSum(Teamname),
--foreign key(Playername)references TeamPlayer(Playername)
)
alter table TopScorer drop constraint PK_PlayerorderTurn
alter table TopScorer drop column Playerorder
alter table TopScorer add turn int not null
alter table TopScorer add Playerorder int not null
alter table TopScorer add Turn smallint not null
Alter table TopScorer Drop Constraint fk_Playerorder
Alter table TopScorer Add  Constraint  PK_PlayerorderTurn  Primary  Key (Playerorder,Turn)
alter table TopScorer add constraint fk_Playerorder foreign key(Playerorder) references TeamPlayer(Playerorder)
--球队积分
create table LeagueStanding
(
Teamname nvarchar(20)primary key,--球队名
FieldOrder smallint,--场序
Teamscore smallint,--球队得分
Teamlose smallint,--球队失分
GoalDifference smallint,--球队净胜数
Score smallint,--球队积分
Teamranking smallint,--球队排名
Turn int,--轮次
--foreign key (Teamname) references TeamSum(Teamname),
)
alter table LeagueStanding drop constraint PK__LeagueSt__D60BCE36656C112C
alter table LeagueStanding drop constraint fk_Teamname
alter table LeagueStanding drop column ping
alter table LeagueStanding add ping int
alter table LeagueStanding drop column Teamranking
alter table LeagueStanding add Turn nvarchar(10) not null
Alter table LeagueStanding Add  Constraint  PK_TeamnameTurn  Primary  Key (Teamname,Turn)
alter table LeagueStanding add Constraint fk_Teamname foreign key (Teamname) references TeamSum(Teamname)
--红黄牌处罚公告
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
alter table RedYellowCards drop constraint fk_Teamnam 
alter table RedYellowCards drop column Playername
alter table RedYellowCards add Turn int not null
Alter table RedYellowCards Add  Constraint  PK_PlayerordeTurn  Primary  Key (Playerorder,Turn)
alter table RedYellowCards add Constraint fk_Playerorde foreign key (Playerorder) references TeamPlayer(Playerorder)
alter table RedYellowCards add Constraint fk_Teamnam foreign key (Teamname) references TeamSum(Teamname)
--alter table RedYellowCards add Constraint fk_Turn foreign key (turn) references ScheduleArrange(turn)
create table UserInformation
(
Username nvarchar(20),--用户名
userType nvarchar(10),--类别
UserPassword char(10),--登录密码
primary key (Username,userType),
)
alter table UserInformation drop constraint PK_UsernameType 
alter table UserInformation drop column userType
alter table UserInformation add Username nvarchar(20) not null
alter table UserInformation add userType nvarchar(20) not null
alter table UserInformation add UserEmail nvarchar(20)--用户邮箱
alter table UserInformation add Usertelephone nvarchar(20)--用户联系方式
Alter table UserInformation Add  Constraint  PK_UsernameType  Primary  Key (Username,usertype)
--球队安排的node
create table teamnode
(
permissionid int primary key,
permissionname char(20),
url char(40),
topid int,
username char(20),
)
--查找球队管理的节点
alter proc findnode
--@username char(20)
as
select * from teamnode where teamnode.username='aaa';
exec findnode
--查找赛事管理的节点
alter proc findmatchnode
as
select * from teamnode where teamnode.username='bbb';
exec findnode




--射手榜排名前五甲视图
alter view PlayerRanking 
as 
select Top 5 TeamPlayer.Playername,TeamPlayer.teamname,a.turn,
Playergoals,place=(select COUNT(*) from TopScorer where TopScorer.Playergoals>=a.Playergoals and 
TopScorer.turn=(select top 1 turn from TopScorer order by turn desc))
from TopScorer as a,TeamPlayer
where TeamPlayer.Playerorder=a.Playerorder and a.turn=(select top 1 turn from TopScorer order by turn desc)
order by Playergoals desc
--球员每轮排名
alter view playerrangkingall
as
select TeamPlayer.Playername,TeamPlayer.teamname,a.turn,Playergoals,TeamPlayer.Playernumber
from TopScorer as a,TeamPlayer
where TeamPlayer.Playerorder=a.Playerorder
--球队积分前五甲视图
alter view teamranking
as
select top 5 *,place=(select COUNT(*)+1 from LeagueStanding 
where LeagueStanding.GoalDifference>b.GoalDifference and 
LeagueStanding.Turn=(select top 1 turn from LeagueStanding order by turn desc ))
from LeagueStanding as b 
where b.turn=(select top 1 turn from LeagueStanding order by turn desc )
order by GoalDifference desc
---存储过程 验证登录密码
alter proc checkuser
@userName nvarchar(20),@userPassword char(10),@userType nvarchar(20),@checkresult int output
as
if(exists(
select username
from userinformation
where UserInformation.userName=@userName and userinformation.UserPassword=@userPassword and userinformation.userType=@userType))
set @checkresult=1
else set @checkresult=0
--存储过程，验证用户是否存在
alter proc ifexituser
@userName nvarchar(20),@checkresult int output
as
if(exists(
select username
from userinformation
where UserInformation.userName=@userName))
set @checkresult=1
else set @checkresult=0
--存储过程，用户注册，插入数据
alter proc insertuser
@Username nvarchar(20),@UserPassword char(10),@userType nvarchar(20),@UserEmail nvarchar(20),@Usertelephone nvarchar(20),@result int output
as
begin
insert into userinformation values(@Username,@UserPassword,@UserEmail,@Usertelephone,@userType)
set @result=1 
end
exec insertuser '12','1212','球队管理员','1234@qq.com',12345
--@result output
--存储过程，插入球队新数据
alter proc insertteam
@Teamname nvarchar(20),@Leadername nvarchar(10),@Teamcoach nvarchar(10),@Telephone varchar(12),@checkresult int output
as
if(not exists(select Teamname from TeamSum where TeamSum.Teamname=@Teamname))
begin
insert into TeamSum values(@Teamname,@Leadername,@Teamcoach,@Telephone)
set @checkresult=1
end
else set @checkresult=0
exec insertteam 'abc','aaa','ccc','123654'
--删除球队的同时，删除球员
delete from TeamPlayer where TeamPlayer.teamname='aaa'
--存储过程，插入球员
alter proc playeradd
@playernumber smallint,@playername nvarchar(20),@datebirth date,@idnumber char(18),@gender char(2),@teamname nvarchar(20),@returnresult int output
as
begin
if(@playername='' or @playernumber=''or @idnumber='')
 set @returnresult=3 --判断球队名，球员名，球员编号，id是否为空
else
  begin
    if(exists(select playerorder from (select * from TeamPlayer where TeamPlayer.teamname=@teamname) a where a.Playername=@playername or a.Playernumber=@playernumber))
     set @returnresult=2--球队编号或球员姓名是否已经存在
  else
    begin
	  if(exists(select idnumber from TeamPlayer where IDnumber=@idnumber))
	    set @returnresult=1 --id应该是唯一的
	  else
		begin
			insert into teamplayer(playernumber,playername,datebirth,idnumber,gender,teamname) 
			values(@playernumber,@playername,@datebirth,@idnumber,@gender,@teamname)
			set @returnresult=0
		end
    end
  end
end
declare @returnresul int
exec playeradd '','','','12389','男','aaa',@returnresul output
select @returnresul

delete from TeamPlayer where TeamPlayer.Playernumber=2 and TeamPlayer.teamname='武汉地龙'

--存储过程，修改teamplayer中的数据
alter proc updateplayer
@playerorder int,@playername nvarchar(20),@playernumber smallint,@gender char(2),@datebirth date,@IDnumber char(18)
,@teamname nvarchar(20),@updateresult int output
as
begin
update TeamPlayer set teamname=@teamname,Playername=@playername,Playernumber=@playernumber,
gender=@gender,Datebirth=@datebirth,IDnumber=@IDnumber where Playerorder=@playerorder
set @updateresult=0
end


--存储过程，插入，修改Judge信息
alter proc updatejudge
@Judgernumber int,@Judgername nvarchar(10)--,@result int output
as
begin
	if(exists(select Judgernumber from JudgeInformation where JudgeInformation.Judgernumber=@Judgernumber))
	begin
	update JudgeInformation set Judgername=@Judgername where Judgernumber=@Judgernumber
	end
	else
	begin
	insert into JudgeInformation(Judgername) values(@Judgername)
	end
end

--存储过程，插入，修改timekeeper信息
alter proc updatetimekeeper
@Timekeepernumber int,@Timekeepername nvarchar(10)--,@result int output
as
begin
	--if(exists(select Judgernumber from JudgeInformation where JudgeInformation.Judgernumber=@Timekeepernumber))
	update TimeKeeperInformation set Timekeepername=@Timekeepername where Timekeepernumber=@Timekeepernumber
end

--存储过程，插入，修改court信息
alter proc updatecourt
@Courtplace nvarchar(10),@Courtname nvarchar(10)
as
update PlayCourt set Courtplace=@Courtplace where Courtname=@Courtname

--存储过程，插入比赛安排、
create proc insertmatch
@turn int,@FieldOrder smallint,@fixture datetime,@A nvarchar(20),@B nvarchar(20),
@courtname nvarchar(20),@Judgername nvarchar(10),@Timekeepername nvarchar(10),@sprv int output
as
begin
	insert into ScheduleArrange(Turn,FieldOrder,fixture,teama,teamb,Courtname,Judgername,Timekeepername)
	values(@turn,@FieldOrder,@fixture,@A,@B,@courtname,@Judgername,@Timekeepername)
	set @sprv=0
end
--存储过程，更新比赛安排、
create proc updatematch
@turn int,@FieldOrder smallint,@fixture datetime,@teama nvarchar(20),
@teamb nvarchar(20),@Courtname nvarchar(10),@Judgername nvarchar(10),@Timekeepername nvarchar(10),@sprv int output
as
update ScheduleArrange
set turn=@turn,FieldOrder=@FieldOrder,fixture=@fixture,teama=@teama,teamb=@teamb,Courtname=@Courtname,
Judgername=@Judgername,Timekeepername=@Timekeepername
where turn=@turn and FieldOrder=@FieldOrder

--查询球队积分，相加
alter proc insertteamscore
@turn int,@teamname nvarchar(20),@teamscore smallint,@teamlose smallint,@score smallint,@sprv int output
as
begin
declare @goaldifference smallint,@scorea int
set @scorea=(select Score from LeagueStanding where turn=@turn-1 and Teamname=@teamname)
insert LeagueStanding(Teamname,turn,FieldOrder,Teamscore,Teamlose,GoalDifference,Score)
values(@teamname,@turn,@turn,@teamscore,@teamlose,@teamscore-@teamlose,@scorea+@score)
set @sprv=0
end
select  top 1  turn from LeagueStanding order by turn desc
exec insertteamscore '武汉地龙','3',12,3,1,'0','0'

update LeagueStanding
set win=win+1
where turn=2 and Teamname='武汉地龙'

---存储过程，插入球员得分
create proc insertplayerscore
@teamname nvarchar(20),@playername nvarchar(20),@turn int,@score smallint,@result int output
as 
begin
 declare @playerorder int
 set @playerorder=(select playerorder from TeamPlayer where teamname=@teamname and Playername=@playername)
 insert into TopScorer(Playergoals,Playerorder,turn) values(@score,@playerorder,@turn)
 set @result=0
end

--存储过程，插入最新的红黄牌处罚公告
create proc insertredyellow
@teamname nvarchar(20),@playername nvarchar(20),@turn int,@redcard smallint
,@yellowcard smallint,@stoppturn nvarchar(20),@result int output
as
begin
 declare @playerorder int
 set @playerorder=(select playerorder from TeamPlayer where teamname=@teamname and Playername=@playername)
 insert into RedYellowCards(turn,Playerorder,Playerredcard,Playeryellowcard,Stopperiod)
 values(@turn,@playerorder,@redcard,@yellowcard,@stoppturn)
 set @result=0
end











--存储过程 查询单个球队积分
create proc eteamscore
@teamname nvarchar(20)
as
select Teamname,Turn,Teamscore,Teamlose,GoalDifference,Score
from LeagueStanding
where Teamname=@teamname
exec eteamscore '湖大半球建工'

--查询每一轮次球队积分排名
alter proc turnteamrank
@turn nvarchar(10)
as
select Teamname,Turn,Teamscore,Teamlose,GoalDifference,Score,place=(select count(*)+1 from LeagueStanding where LeagueStanding.GoalDifference>b.GoalDifference and LeagueStanding.Turn=@turn)
from LeagueStanding as b
where turn=@turn
order by GoalDifference desc
exec turnteamrank 2

select * from TeamPlayer where TeamPlayer.Datebirth='1995-2-13'

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