<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="五人制足球.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>管理员注册</title>
    <link href="css/all.css" rel="stylesheet" />
    <link href="css/MainPage.css" rel="stylesheet" />
    <link href="css/TopScorer.css" rel="stylesheet" />
    <link href="css/Login.css" rel="stylesheet" />
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
            </div>
            <div class="rightcontent">
                <div class="pagetitle" style="width: 580px; margin-left: 20px; height: 40px; border-bottom: 1px solid #036; font-family: 楷体; line-height: 40px;">
                    <i>管理员注册</i>
                </div>
                <div class="login" style="margin-top:50px;">
                    <%-- 用户名 --%>
                    <asp:Label ID="Label1" runat="server" Text="用户" CssClass="td1"></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="td2"></asp:TextBox>
                    <span style="color: red; margin-left: 0;" class="td3">*</span><br />
                    <%-- 密码 --%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label2" runat="server" Text="密码" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%-- 确认密码 --%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label3" runat="server" Text="确认" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="td2" TextMode="Password"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%-- 类别--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label6" runat="server" Text="类别" CssClass="td4"></asp:Label>
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="td2"></asp:DropDownList>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%-- 邮箱 --%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label4" runat="server" Text="邮箱" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%--  联系方式--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label5" runat="server" Text="电话" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <table style="margin-top: 5px;">
                        <%-- 验证码 --%>
                        <%--                    <tr>                   
                        <td class="td1">验证码:</td>
                        <td class="td2"><input id="Text8" class="txtinput" type="text" name="code" /></td>
                        <td class="td3"></td>
                    </tr>--%>
                        <tr>
                            <td colspan="3" class="td1" style="text-align: center; margin-top: 10px;">
                                <asp:Button ID="Button1" runat="server" Text="注册" BorderWidth="5" OnClick="Button1_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="td1" style="text-align: center; margin-top: 20px">
                                <a href="Login.aspx" style="color: red;">登录>></a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div style="height: 15px; overflow: hidden; clear: both;"></div>
        <div class="footer">三峡大学信息管理与信息系统专业</div>
    </form>
</body>
</html>
