create database IndoorFootball
on primary
(
name='IndoorFootball_data',
filename='F:\����������\IndoorFootball_data.mdf',
size=5mb,
maxsize=100mb,
filegrowth=15%
)
log on
(
name='IndoorFootball_log',
filename='F:\����������\IndoorFootball_log.ldf',
size=2mb,
filegrowth=1mb
)
use IndoorFootball 
create table TeamSum  --�����Ϣ�ۺ�  
(
Teamname	nvarchar(20) primary key,--�����
Leadername	Nvarchar(10),
Teamcoach	Nvarchar(10),
Telephone	Varchar(12),
)
create table TeamPlayer --��Ա��Ϣ�ۺ�
(
Playerorder smallint,--��Ա���
Teamname	nvarchar(20) unique,--��Ա��
Playernumber	SMALLINT,--��Ա������еĺ���
Playername	nvarchar(20) not null,
Datebirth date ,
Gender bit,--�Ա�
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
--alter table ��Ա add constraint u_��Ա unique(��Ա��)
--alter table TeamPlayer add constraint u_��Ա���� unique(����)
create table JudgeInformation   --������Ϣ
(
Judgernumber smallint primary key,
Judgername nvarchar(10),
)
alter table Judgeinformation add Judgernumber int identity(1,1)
alter table Judgeinformation drop column Judgernumber 
alter table Judgeinformation drop constraint PK__JudgeInf__3A90779A5629CD9C
alter table judgeinformation add Judgername nvarchar(10) primary key
create table TimeKeeperInformation  --��ʱԱ��Ϣ
(
Timekeepernumber smallint primary key,
Timekeepername nvarchar(10),
)
alter table TimeKeeperInformation add Timekeepernumber int identity(1,1)
alter table TimeKeeperInformation drop constraint PK__TimeKeep__3AA2E11D1367E606
alter table TimeKeeperInformation add Timekeepername nvarchar(10) primary key

create table PlayCourt  --����Ϣ
(
Courtname nvarchar(10)primary key,--
Courtplace nvarchar(10),
)
--��������
create table ScheduleArrange
(
Turn int,--�ִ�
FieldOrder smallint,--����
fixture datetime,--����ʱ��
VSteam varchar(60),--��������
Courtname nvarchar(10),--����
Judgername nvarchar(10) not null,--������
Timekeepername nvarchar(10) not null,--��ʱԱ��
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
--������ں�ʱ��
select CONVERT(varchar(100),fixture,5) from ScheduleArrange
select DATENAME(MM,fixture)+'-'+datename(DD,fixture)+'-'+datename(HH,fixture)+'-'+datename(MINUTE,fixture)'fixture' from ScheduleArrange

--�����°��ŵĲ�ѯ
select Turn,FieldOrder,CONVERT(varchar(100),fixture,20)fixture,
Courtname,Judgername,Timekeepername,TeamA,TeamB  from ScheduleArrange

create table TopScorer -- ���ְ�
(
Playerorder smallint,--��Ա���
Playergoals smallint,--�ܽ�����
Playername nvarchar(20),--��Ա��
Teamname nvarchar(20),--�����
Playernumber smallint,--����
Turn nvarchar(10),--�ִ�
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
--��ӻ���
create table LeagueStanding
(
Teamname nvarchar(20)primary key,--�����
FieldOrder smallint,--����
Teamscore smallint,--��ӵ÷�
Teamlose smallint,--���ʧ��
GoalDifference smallint,--��Ӿ�ʤ��
Score smallint,--��ӻ���
Teamranking smallint,--�������
Turn int,--�ִ�
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
--����ƴ�������
create table RedYellowCards
(
Playerorder smallint,--��Ա���
Turn nvarchar(10),--�ִ�
Playerredcard smallint,--��Ա������
Playeryellowcard smallint,--��Ա������
Stopperiod nvarchar(10),--ͣ����
Playername nvarchar(20),--��Ա��
Teamname nvarchar(20),--�����
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
Username nvarchar(20),--�û���
userType nvarchar(10),--���
UserPassword char(10),--��¼����
primary key (Username,userType),
)
alter table UserInformation drop constraint PK_UsernameType 
alter table UserInformation drop column userType
alter table UserInformation add Username nvarchar(20) not null
alter table UserInformation add userType nvarchar(20) not null
alter table UserInformation add UserEmail nvarchar(20)--�û�����
alter table UserInformation add Usertelephone nvarchar(20)--�û���ϵ��ʽ
Alter table UserInformation Add  Constraint  PK_UsernameType  Primary  Key (Username,usertype)
--��Ӱ��ŵ�node
create table teamnode
(
permissionid int primary key,
permissionname char(20),
url char(40),
topid int,
username char(20),
)
--������ӹ���Ľڵ�
alter proc findnode
--@username char(20)
as
select * from teamnode where teamnode.username='aaa';
exec findnode
--�������¹���Ľڵ�
alter proc findmatchnode
as
select * from teamnode where teamnode.username='bbb';
exec findnode




--���ְ�����ǰ�����ͼ
alter view PlayerRanking 
as 
select Top 5 TeamPlayer.Playername,TeamPlayer.teamname,a.turn,
Playergoals,place=(select COUNT(*) from TopScorer where TopScorer.Playergoals>=a.Playergoals and 
TopScorer.turn=(select top 1 turn from TopScorer order by turn desc))
from TopScorer as a,TeamPlayer
where TeamPlayer.Playerorder=a.Playerorder and a.turn=(select top 1 turn from TopScorer order by turn desc)
order by Playergoals desc
--��Աÿ������
alter view playerrangkingall
as
select TeamPlayer.Playername,TeamPlayer.teamname,a.turn,Playergoals,TeamPlayer.Playernumber
from TopScorer as a,TeamPlayer
where TeamPlayer.Playerorder=a.Playerorder
--��ӻ���ǰ�����ͼ
alter view teamranking
as
select top 5 *,place=(select COUNT(*)+1 from LeagueStanding 
where LeagueStanding.GoalDifference>b.GoalDifference and 
LeagueStanding.Turn=(select top 1 turn from LeagueStanding order by turn desc ))
from LeagueStanding as b 
where b.turn=(select top 1 turn from LeagueStanding order by turn desc )
order by GoalDifference desc
---�洢���� ��֤��¼����
alter proc checkuser
@userName nvarchar(20),@userPassword char(10),@userType nvarchar(20),@checkresult int output
as
if(exists(
select username
from userinformation
where UserInformation.userName=@userName and userinformation.UserPassword=@userPassword and userinformation.userType=@userType))
set @checkresult=1
else set @checkresult=0
--�洢���̣���֤�û��Ƿ����
alter proc ifexituser
@userName nvarchar(20),@checkresult int output
as
if(exists(
select username
from userinformation
where UserInformation.userName=@userName))
set @checkresult=1
else set @checkresult=0
--�洢���̣��û�ע�ᣬ��������
alter proc insertuser
@Username nvarchar(20),@UserPassword char(10),@userType nvarchar(20),@UserEmail nvarchar(20),@Usertelephone nvarchar(20),@result int output
as
begin
insert into userinformation values(@Username,@UserPassword,@UserEmail,@Usertelephone,@userType)
set @result=1 
end
exec insertuser '12','1212','��ӹ���Ա','1234@qq.com',12345
--@result output
--�洢���̣��������������
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
--ɾ����ӵ�ͬʱ��ɾ����Ա
delete from TeamPlayer where TeamPlayer.teamname='aaa'
--�洢���̣�������Ա
alter proc playeradd
@playernumber smallint,@playername nvarchar(20),@datebirth date,@idnumber char(18),@gender char(2),@teamname nvarchar(20),@returnresult int output
as
begin
if(@playername='' or @playernumber=''or @idnumber='')
 set @returnresult=3 --�ж����������Ա������Ա��ţ�id�Ƿ�Ϊ��
else
  begin
    if(exists(select playerorder from (select * from TeamPlayer where TeamPlayer.teamname=@teamname) a where a.Playername=@playername or a.Playernumber=@playernumber))
     set @returnresult=2--��ӱ�Ż���Ա�����Ƿ��Ѿ�����
  else
    begin
	  if(exists(select idnumber from TeamPlayer where IDnumber=@idnumber))
	    set @returnresult=1 --idӦ����Ψһ��
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
exec playeradd '','','','12389','��','aaa',@returnresul output
select @returnresul

delete from TeamPlayer where TeamPlayer.Playernumber=2 and TeamPlayer.teamname='�人����'

--�洢���̣��޸�teamplayer�е�����
alter proc updateplayer
@playerorder int,@playername nvarchar(20),@playernumber smallint,@gender char(2),@datebirth date,@IDnumber char(18)
,@teamname nvarchar(20),@updateresult int output
as
begin
update TeamPlayer set teamname=@teamname,Playername=@playername,Playernumber=@playernumber,
gender=@gender,Datebirth=@datebirth,IDnumber=@IDnumber where Playerorder=@playerorder
set @updateresult=0
end


--�洢���̣����룬�޸�Judge��Ϣ
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

--�洢���̣����룬�޸�timekeeper��Ϣ
alter proc updatetimekeeper
@Timekeepernumber int,@Timekeepername nvarchar(10)--,@result int output
as
begin
	--if(exists(select Judgernumber from JudgeInformation where JudgeInformation.Judgernumber=@Timekeepernumber))
	update TimeKeeperInformation set Timekeepername=@Timekeepername where Timekeepernumber=@Timekeepernumber
end

--�洢���̣����룬�޸�court��Ϣ
alter proc updatecourt
@Courtplace nvarchar(10),@Courtname nvarchar(10)
as
update PlayCourt set Courtplace=@Courtplace where Courtname=@Courtname

--�洢���̣�����������š�
create proc insertmatch
@turn int,@FieldOrder smallint,@fixture datetime,@A nvarchar(20),@B nvarchar(20),
@courtname nvarchar(20),@Judgername nvarchar(10),@Timekeepername nvarchar(10),@sprv int output
as
begin
	insert into ScheduleArrange(Turn,FieldOrder,fixture,teama,teamb,Courtname,Judgername,Timekeepername)
	values(@turn,@FieldOrder,@fixture,@A,@B,@courtname,@Judgername,@Timekeepername)
	set @sprv=0
end
--�洢���̣����±������š�
create proc updatematch
@turn int,@FieldOrder smallint,@fixture datetime,@teama nvarchar(20),
@teamb nvarchar(20),@Courtname nvarchar(10),@Judgername nvarchar(10),@Timekeepername nvarchar(10),@sprv int output
as
update ScheduleArrange
set turn=@turn,FieldOrder=@FieldOrder,fixture=@fixture,teama=@teama,teamb=@teamb,Courtname=@Courtname,
Judgername=@Judgername,Timekeepername=@Timekeepername
where turn=@turn and FieldOrder=@FieldOrder

--��ѯ��ӻ��֣����
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
exec insertteamscore '�人����','3',12,3,1,'0','0'

update LeagueStanding
set win=win+1
where turn=2 and Teamname='�人����'

---�洢���̣�������Ա�÷�
create proc insertplayerscore
@teamname nvarchar(20),@playername nvarchar(20),@turn int,@score smallint,@result int output
as 
begin
 declare @playerorder int
 set @playerorder=(select playerorder from TeamPlayer where teamname=@teamname and Playername=@playername)
 insert into TopScorer(Playergoals,Playerorder,turn) values(@score,@playerorder,@turn)
 set @result=0
end

--�洢���̣��������µĺ���ƴ�������
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











--�洢���� ��ѯ������ӻ���
create proc eteamscore
@teamname nvarchar(20)
as
select Teamname,Turn,Teamscore,Teamlose,GoalDifference,Score
from LeagueStanding
where Teamname=@teamname
exec eteamscore '������򽨹�'

--��ѯÿһ�ִ���ӻ�������
alter proc turnteamrank
@turn nvarchar(10)
as
select Teamname,Turn,Teamscore,Teamlose,GoalDifference,Score,place=(select count(*)+1 from LeagueStanding where LeagueStanding.GoalDifference>b.GoalDifference and LeagueStanding.Turn=@turn)
from LeagueStanding as b
where turn=@turn
order by GoalDifference desc
exec turnteamrank 2

select * from TeamPlayer where TeamPlayer.Datebirth='1995-2-13'

--��ӻ�����Ϣ���������Ա��
create view ��ӻ�����Ϣ
as 
select ���.����� ,������,�����,��ϵ�绰,��Ա��,����,�Ա�,��������,���֤��
from ��Ա,��� 
where ��Ա.�����=��� .�����
--�����Ϣ,��һ���û���
create view �����Ϣ
as
select ���.����� ,������,�����,��Ա��,����
from ��Ա,��� 
where ��Ա.�����=��� .�����
--��������,��������Ա�����췽��
create view ��������
as
select ����ʱ��,������Ϣ .����,�򳡵ص� ,������Ϣ .������ ,����Ա��� ,������Ϣ.��ʱԱ��,��ʱԱ���
from ������Ϣ ,����Ա ,��ʱԱ ,�� 
where ������Ϣ .������=����Ա .������ and ������Ϣ .��ʱԱ�� =��ʱԱ .��ʱԱ�� and �� .���� =������Ϣ .���� 
--��������,�������˿�
create view ��������
as
select �ִ�,����,����ʱ��,��������,�ͳ�����,����
from ������Ϣ 
--���ְ񹫸�,�����˿ɼ�
create view ���ְ񹫸�
as
select ����� ,����,��Ա��,�ܽ�����
from ���ְ� ,��Ա
where ���ְ� .��Ա��� =��Ա.��Ա��� 
--�������ֹ���,�����˿ɼ�
create view �������ֹ���
as
select  top 100 percent �����,����,��ӵ÷�,���ʧ��,��Ӿ�ʤ��,��ӻ���
from �������ְ� 
order by ��ӻ��� ,��Ӿ�ʤ��,�����,����,��ӵ÷�,���ʧ��
--��������,�����˿ɼ�
create view ��������
as
select ����� ,���� ,�ִ�,��Ա��,��Ա������,��Ա������,ͣ����
from ����ƹ���,��Ա 
where ����ƹ��� .��Ա��� =��Ա .��Ա���

/*******************************/
/****************/
/***************/	��������
/**************/
/******************************/

create unique index qiuyuanming on ��Ա(��Ա��)
create unique index lunci on ����ƹ���(�ִ�)