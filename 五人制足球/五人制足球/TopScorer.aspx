<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TopScorer.aspx.cs" Inherits="五人制足球.TopScorer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>五人制足球---射手榜</title>
    <link href="css/MainPage.css" rel="stylesheet" />
    <link href="css/all.css" rel="stylesheet" />
    <link href="css/TopScorer.css" rel="stylesheet" />
    <link href="css/ScheduleArrange.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%-- 导航栏的picture --%>
        <div class="title" style="margin-top:5px;">
            <div style="border: 1px solid #aaa; border-radius: 5px; text-align: center; line-height: 80px; font-size: 24px;font-family:楷体">五人制足球管理系统</div>
        </div>
            <%-- 导航栏，title部分 --%>
            <div class="titlename">
                <ul class="nav">
                    <li class="first">
                        <a href="MainPage.aspx">首页</a>
                    </li>
                    <li class="bg"></li>
                    <li>
                        <a href="ScheduleArrange.aspx">赛事安排</a>
                    </li>
                    <li class="bg"></li>
                    <li>
                        <a href="LeagueStanding.aspx">球队得分</a>
                    </li>
                    <li class="bg"></li>
                    <li>
                        <a href="#">射手榜</a>
                    </li>
                    <li class="bg"></li>
                    <li>
                        <a href="redyellowshow.aspx">红黄牌处罚</a>
                    </li>
                    <li class="bg"></li>
                    <li>
                        <a href="Login.aspx">管理员入口</a>
                    </li>
                    <li class="bg"></li>
                </ul>
            </div>
            <div class="content">
                <%-- 左边部分 --%>
                <div class="leftcontent" style="border: none; margin-top: 0px;">
                    <%-- 射手榜排名 --%>
                    <div class="PlayerRangking">
                        <div class="RangkingTitle">
                            五甲射手榜
                        <a href="TopScorer.aspx" style="padding-right: 10px; float: right; /*color: #ffffff; */text-decoration: none;">更多</a>
                        </div>
                        <div class="RankingTable">
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" Width="280px">
                                <Columns>
                                    <asp:BoundField DataField="place" HeaderText="排名" />
                                    <asp:BoundField DataField="Playername" HeaderText="球员名" />
                                    <asp:BoundField DataField="Teamname" HeaderText="球队名" />
                                    <asp:BoundField DataField="Playergoals" HeaderText="进球数" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <%-- 五甲积分榜 --%>
                    <div class="PlayerRangking" style="height: 200px">
                        <div class="teamtitle">
                            五甲积分榜
                        <a href="LeagueStanding.aspx" style="padding-right: 10px; float: right; /*color: #ffffff; */text-decoration: none;">更多</a>
                        </div>
                        <div class="teamtable" style="margin-top: -50px;">
                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" Width="280px">
                                <Columns>
                                    <asp:BoundField DataField="place" HeaderText="名次" />
                                    <asp:BoundField DataField="Teamname" HeaderText="球队名" />
                                    <asp:BoundField DataField="Teamscore" HeaderText="得分" />
                                    <asp:BoundField DataField="Teamlose" HeaderText="失分" />
                                    <asp:BoundField DataField="GoalDifference" HeaderText="净胜" />
                                    <asp:BoundField DataField="Score" HeaderText="积分" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <%-- 右边部分 --%>
                <div class="rightcontent">
                    <div class="pagetitle" style="width: 580px; margin-left: 20px; height: 40px; border-bottom: 1px solid #036; font-family: 楷体; line-height: 40px;">
                        <i>射手榜公告</i>
                    </div>
                    <table style="margin-top: 20px;">
                        <tr>
                            <td>请选择轮次：
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList1" CssClass="DDL1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" Font-Size="Medium"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <div style="margin-top:30px;">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Teamname" HeaderText="球队名" />
                                <asp:BoundField DataField="Turn" HeaderText="轮次" />
                                <asp:BoundField DataField="Playername" HeaderText="球员名" />
                                <asp:BoundField DataField="Playernumber" HeaderText="球员号码" />
                                <asp:BoundField DataField="Playergoals" HeaderText="进球数" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
        <div style="height: 15px; overflow: hidden; clear: both;"></div>
        <div class="footer">三峡大学信息管理与信息系统专业</div>
    </form>
</body>
</html>
