<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addmatch.aspx.cs" Inherits="五人制足球.addmatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>五人制足球---增加赛事</title>
    <link href="css/MainPage.css" rel="stylesheet" />
    <link href="css/zzsc.css" rel="stylesheet" />
    <style type="text/css">
        body
        {
            height: 100%;
            font: 14px/20px sans-serif;
            color: #51555C;
        }
    </style>
    <link href="css/TopScorer.css" rel="stylesheet" />
    <link href="css/Login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <%-- 导航栏的标题--%>
        <div class="title">
            <div style="border: 1px solid #aaa; border-radius: 5px; text-align: center; line-height: 80px; font-size: 24px;">五人制足球赛事管理系统</div>
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
                    <i>增加赛事</i>
                </div>
                <div class="login" style="margin-top: 30px;">
                    <%-- 轮次 --%>
                    <asp:Label ID="Label1" runat="server" Text="轮次" CssClass="td1"></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="td2"></asp:TextBox>
                    <span style="color: red; margin-left: 0;" class="td3">*</span><br />
                    <%-- 场序--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label3" runat="server" Text="场序" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%-- 比赛时间--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label2" runat="server" Text="时间" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%-- 对战队伍A--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label4" runat="server" Text="A队 " CssClass="td4"></asp:Label>
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="td2"></asp:DropDownList>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%-- 对战队伍B--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label5" runat="server" Text="B队 " CssClass="td4"></asp:Label>
                        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="td2"></asp:DropDownList>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%--比赛地点--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label6" runat="server" Text="地点" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox6" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%--裁判--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label7" runat="server" Text="裁判" CssClass="td4"></asp:Label>
                        <asp:DropDownList ID="DropDownList3" runat="server" CssClass="td2"></asp:DropDownList>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <%--计时--%>
                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label8" runat="server" Text="计时" CssClass="td4"></asp:Label>
                        <asp:DropDownList ID="DropDownList4" runat="server" CssClass="td2"></asp:DropDownList>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>
                    <table style="margin-top: 5px; text-align: center; margin-left: 150px;">
                        <tr>
                            <td colspan="3" class="td1" style="text-align: center; margin-top: 10px;">
                                <asp:Button ID="Button1" runat="server" Text="添加" BorderWidth="5" OnClick="Button1_Click" Style="height: 27px" />
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
