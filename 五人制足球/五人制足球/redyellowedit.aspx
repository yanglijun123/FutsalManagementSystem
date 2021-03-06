﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="redyellowedit.aspx.cs" Inherits="五人制足球.redyellowedit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>五人制足球---编辑红黄牌处罚</title>
    <link href="css/MainPage.css" rel="stylesheet" />
    <link href="css/zzsc.css" rel="stylesheet" />
    <link href="css/TopScorer.css" rel="stylesheet" />
    <link href="css/Login.css" rel="stylesheet" />
    <style type="text/css">
        body
        {
            height: 100%;
            font: 14px/20px sans-serif;
            color: #51555C;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <%-- 导航栏的标题--%>
        <div class="title">
            <div style="border: 1px solid #aaa; border-radius: 5px; text-align: center; line-height: 80px; font-size: 24px;">五人制足球积分管理系统</div>
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
                    <i>编辑球员得分</i>
                </div>
                <div class="login" style="margin-top: 20px;margin-left:70px;">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" PageSize="5" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDataBound="GridView1_RowDataBound" OnRowDeleting="GridView1_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="turn" HeaderText="轮次" />
                            <asp:TemplateField HeaderText="球队名">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" runat="server"
                                        DataSource="<%# ddlbind() %>" DataTextField="teamname"
                                        DataValueField="teamname">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="teamname" runat="server" Text="Label"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="playername" HeaderText="球员名" />
                            <asp:BoundField DataField="playerredcard" HeaderText="红牌数" />
                            <asp:BoundField DataField="playeryellowcard" HeaderText="黄牌数" />
                            <asp:BoundField DataField="stopperiod" HeaderText="停赛期" />
                            <asp:CommandField HeaderText="编辑" ShowEditButton="True" />
                            <asp:TemplateField HeaderText="删除">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="Delete" CommandName="Delete" ImageUrl="~/delete.jpg" ToolTip="删除课程" Width="21px" Height="21px" OnClientClick="return confirm('是否确认删除该处罚？');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div style="height: 15px; overflow: hidden; clear: both;"></div>
        <div class="footer">三峡大学信息管理与信息系统专业</div>
    </form>
</body>
</html>
