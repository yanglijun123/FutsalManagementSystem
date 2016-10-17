<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlayerAdd.aspx.cs" Inherits="五人制足球.PlayerAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>五人制足球---增加球员</title>
    <link href="css/MainPage.css" rel="stylesheet" />
    <link href="css/zxcd.css" rel="stylesheet" />
    <link href="css/TopScorer.css" rel="stylesheet" />
    <link href="css/Login.css" rel="stylesheet" />
    <link type="text/css" href="css/jquery-ui.css" rel="stylesheet" />
    <script src="js/jquery-1.8.4.min.js"></script>
    <script src="js/jquery-ui-datepicker.js"></script>
    <style type="text/css">
        body
        {
            height: 100%;
            font: 14px/20px sans-serif;
            color: #51555C;
        }

        .td5
        {
            float: left;
            text-align: right;
            font-family: 微软雅黑;
            font-size: 12px;
        }

        .td6
        {
            float: left;
            text-align: center;
        }
    </style>
    <script type="text/javascript" src="js/jquery-ui-datepicker.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#date_1").datepicker();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <%-- 导航栏的标题--%>
        <div class="title">
            <div style="border: 1px solid #aaa; border-radius: 5px; text-align: center; line-height: 80px; font-size: 24px;">五人制足球球队管理系统</div>
            <div style="margin-bottom: 0; text-align: right; color: red"><a href="Login.aspx" style="text-decoration: none; color: red">管理员退出</a></div>
        </div>
        <%-- 内容 --%>
        <div class="content">
            <div class="leftcontent" style="border: 1px solid #aaa; border-radius: 5px; text-align: center; font-size: 24px; height: 420px; margin-top: 10px;">
                <asp:TreeView ID="TreeView1" runat="server" ImageSet="Arrows" NodeIndent="10" NoExpandImageUrl="url">
                    <HoverNodeStyle Font-Underline="false" />
                    <NodeStyle Font-Names="Arial" Font-Size="12pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
                    <ParentNodeStyle Font-Bold="false" />
                    <SelectedNodeStyle Font-Underline="true" HorizontalPadding="0px" VerticalPadding="0px" />
                </asp:TreeView>
            </div>
            <div class="rightcontent" style="border: 1px solid #aaa; border-radius: 5px; height: 420px; margin-top: 10px;">
                <div class="pagetitle" style="width: 580px; margin-left: 20px; height: 40px; border-bottom: 1px solid #036; font-family: 楷体; line-height: 40px;">
                    <i>增加球队球员信息</i>
                </div>
                <div class="login" style="margin-top: 50px; margin-right: 60px;">
                    <%-- 球队名Teamname--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label" runat="server" Text="球队名称" CssClass="td4"></asp:Label>
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="td2"></asp:DropDownList>
                        <span style="color: red; margin-left: 0;" class="td3"></span>
                    </div>
                    <%-- 球员名Playername --%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label1" runat="server" Text="球员姓名" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3"></span>
                    </div>
                    <%-- 球员order --%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label2" runat="server" Text="球员编号" CssClass="td1"></asp:Label>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3"></span>
                    </div>
                    <%-- 出生年月Datebirth --%>
                    <div style="margin-top: 10px;" class="aaa">
                        <asp:Label ID="Label4" runat="server" Text="出生日期" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="date_1" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3"></span>
                    </div>
                    <%-- 选择性别 --%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label5" runat="server" Text="球员性别" CssClass="td5" Width="200px"></asp:Label>
                        <asp:RadioButtonList ID="ChooseSex" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CssClass="td6" OnSelectedIndexChanged="ChooseSex_SelectedIndexChanged" RepeatLayout="Flow">
                            <asp:ListItem Text="男" Value="0" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="女" Value="1"></asp:ListItem>
                        </asp:RadioButtonList>
                        <span style="color: red; margin-left: 0;" class="td3"></span>
                    </div>
                    <br />
                    <%-- 身份证号IDnumber --%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label6" runat="server" Text="身份证号" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox6" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3"></span>
                    </div>
                    <%-- 登录 --%>
                    <div style="width: 630px; text-align: center; margin-top: 10px;">
                        <asp:Button ID="Button1" runat="server" Text="添加球员" BorderWidth="5" OnClick="Button1_Click" Style="height: 27px" />
                    </div>
                </div>
            </div>
        </div>
        <div style="height: 15px; overflow: hidden; clear: both;"></div>
        <div class="footer">三峡大学信息管理与信息系统专业</div>
    </form>
</body>
</html>
