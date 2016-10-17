<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="五人制足球.MainPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>五人制足球--首页</title>
    <link href="css/MainPage.css" rel="stylesheet" />
    <link href="css/all.css" rel="stylesheet" />
    <script src="js/jquery.min.js"></script>
    <script src="js/main.js"></script>
    <%-- 焦点图 --%>
    <link href="css/jiaodiantu3.css" rel="stylesheet" />
    <script src="js/jquery.min2.js"></script>
    <script type="text/javascript">
        $(function () {
            var $banner = $('.banner');
            var $banner_ul = $('.banner-img');
            var $btn = $('.banner-btn');
            var $btn_a = $btn.find('a')
            var v_width = $banner.width();
            var page = 1;
            var timer = null;
            var btnClass = null;
            var page_count = $banner_ul.find('li').length;//把这个值赋给小圆点的个数
            var banner_cir = "<li class='selected' href='#'><a></a></li>";
            for (var i = 1; i < page_count; i++) {
                //动态添加小圆点
                banner_cir += "<li><a href='#'></a></li>";
            }
            $('.banner-circle').append(banner_cir);
            var cirLeft = $('.banner-circle').width() * (-0.5);
            $('.banner-circle').css({ 'marginLeft': cirLeft });
            $banner_ul.width(page_count * v_width);
            function move(obj, classname) {
                //手动及自动播放
                if (!$banner_ul.is(':animated')) {
                    if (classname == 'prevBtn') {
                        if (page == 1) {
                            $banner_ul.animate({ left: -v_width * (page_count - 1) });
                            page = page_count;
                            cirMove();
                        }
                        else {
                            $banner_ul.animate({ left: '+=' + v_width }, "slow");
                            page--;
                            cirMove();
                        }
                    }
                    else {
                        if (page == page_count) {
                            $banner_ul.animate({ left: 0 });
                            page = 1;
                            cirMove();
                        }
                        else {
                            $banner_ul.animate({ left: '-=' + v_width }, "slow");
                            page++;
                            cirMove();
                        }
                    }
                }
            }
            function cirMove() {
                //检测page的值，使当前的page与selected的小圆点一致
                $('.banner-circle li').eq(page - 1).addClass('selected').siblings().removeClass('selected');
            }
            $banner.mouseover(function () {
                $btn.css({ 'display': 'block' });
                clearInterval(timer);
            }).mouseout(function () {
                $btn.css({ 'display': 'none' });
                clearInterval(timer);
                timer = setInterval(move, 3000);
            }).trigger("mouseout");//激活自动播放
            $btn_a.mouseover(function () {
                //实现透明渐变，阻止冒泡
                $(this).animate({ opacity: 0.6 }, 'fast');
                $btn.css({ 'display': 'block' });
                return false;
            }).mouseleave(function () {
                $(this).animate({ opacity: 0.3 }, 'fast');
                $btn.css({ 'display': 'none' });
                return false;
            }).click(function () {
                //手动点击清除计时器
                btnClass = this.className;
                clearInterval(timer);
                timer = setInterval(move, 3000);
                move($(this), this.className);
            });
            $('.banner-circle li').live('click', function () {
                var index = $('.banner-circle li').index(this);
                $banner_ul.animate({ left: -v_width * index }, 'slow');
                page = index + 1;
                cirMove();
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
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
                    <a href="TopScorer.aspx">射手榜</a>
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
            <div class="leftcontent">
                <%-- 射手榜排名 --%>
                <div class="PlayerRangking">
                    <div class="RangkingTitle">
                        五甲射手榜
                        <a href="TopScorer.aspx" style="padding-right: 10px; float: right; /*color: #ffffff; */text-decoration: none;">更多</a>
                    </div>
                    <div class="RankingTable">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="280px">
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
                <div class="PlayerRangking">
                    <div class="teamtitle">
                        五甲积分榜
                        <a href="LeagueStanding.aspx" style="padding-right: 10px; float: right; /*color: #ffffff; */text-decoration: none;">更多</a>
                    </div>
                    <div class="teamtable">
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" Width="280px">
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
                <%-- 焦点图滚动 --%>
                <div class="banner" style="margin-top: 20px;">
                    <div class="banner-btn">
                        <a href="javascript:;" class="prevBtn"><i></i></a>
                        <a href="javascript:;" class="nextBtn"><i></i></a>
                    </div>
                    <ul class="banner-img">
                        <li><a href="#">
                            <img src="img/1.jpg"></a></li>
                        <li><a href="#">
                            <img src="img/2.jpg"></a></li>
                        <li><a href="#">
                            <img src="img/3.jpg"></a></li>
                        <li><a href="#">
                            <img src="img/4.jpg"></a></li>
                        <li><a href="#">
                            <img src="img/5.jpg"></a></li>
                        <li><a href="#">
                            <img src="img/6.jpg"></a></li>
                    </ul>
                    <ul class="banner-circle"></ul>
                </div>
            </div>
        </div>
        <div style="height: 15px; overflow: hidden; clear: both;"></div>
        <div class="footer">三峡大学信息管理与信息系统专业</div>
    </form>
</body>
</html>
