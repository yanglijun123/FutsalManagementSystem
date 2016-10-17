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
alter table teamplayer add teamname nvarchar(20)
alter table teamplayer add constraint aaa foreign key(Teamname) references teamsum(teamname)
alter table teamplayer drop column gender
alter table teamplayer add gender char(2)
--alter table ��Ա add constraint u_��Ա unique(��Ա��)
--alter table TeamPlayer add constraint u_��Ա���� unique(����)
create table JudgeInformation   --������Ϣ
(
Judgernumber smallint primary key,
Judgername nvarchar(10),
)
create table TimeKeeperInformation  --��ʱԱ��Ϣ
(
Timekeepernumber smallint primary key,
Timekeepername nvarchar(10),
)
create table PlayCourt  --����Ϣ
(
Courtname nvarchar(10)primary key,--
Courtplace nvarchar(10),
)
create table ScheduleArrange
(
Turn nvarchar(10),--�ִ�
FieldOrder smallint,--����
fixture datetime,--����ʱ��
VSteam varchar(60),--��������
Courtname nvarchar(10),--����
Judgername nvarchar(10),--������
Timekeepername nvarchar(10),--��ʱԱ��
primary key(Turn,FieldOrder),
)
create table TopScorer -- ���ְ�
(
Playerorder smallint,--��Ա���
Playergoals smallint,--�ܽ�����
Playername nvarchar(20),--��Ա��
Teamname nvarchar(20),--�����
Playernumber smallint,--����
Turn nvarchar(10),--�ִ�
primary key(Playerorder),
foreign key (Playerorder) references TeamPlayer(Playerorder),
foreign key(Teamname)references TeamSum(Teamname),
--foreign key(Playername)references TeamPlayer(Playername)
)
create table LeagueStanding
(
Teamname nvarchar(20)primary key,--�����
FieldOrder smallint,--����
Teamscore smallint,--��ӵ÷�
Teamlose smallint,--���ʧ��
GoalDifference smallint,--��Ӿ�ʤ��
Score smallint,--��ӻ���
Teamranking smallint,--�������
Turn nvarchar(10),--�ִ�
foreign key (Teamname) references TeamSum(Teamname),
)
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
create table UserInformation
(
Username nvarchar(20),--�û���
userType nvarchar(10),--���
UserPassword char(10),--��¼����
primary key (Username,userType),
)



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