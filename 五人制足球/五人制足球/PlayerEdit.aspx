<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlayerEdit.aspx.cs" Inherits="五人制足球.PlayerEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>五人制足球---编辑球员</title>
    <link href="css/MainPage.css" rel="stylesheet" />
    <link href="css/zxcd.css" rel="stylesheet" />
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
                    <i>编辑球员信息</i>
                </div>
                <%-- 球队名Teamname--%>
                <div style="margin-top: 10px; text-align: center;">
                    <asp:Label ID="Label" runat="server" Text="球队名称" CssClass="td4"></asp:Label>
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="td2"></asp:DropDownList>
                    <asp:Button ID="Button1" runat="server" Text="确定" OnClick="Button1_Click" />
                    <span style="color: red; margin-left: 0;" class="td3"></span>
                </div>
                <%-- 球队信息 --%>
                <div style="margin-top: 10px; margin-left: 50px;">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDataBound="GridView1_RowDataBound" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCommand="GridView1_RowCommand">
                        <AlternatingRowStyle BackColor="#A6CAD8" />
                        <Columns>
                            <asp:BoundField DataField="playerorder" HeaderText="球员号" />
                            <asp:BoundField DataField="playername" HeaderText="球员名" />
                            <asp:BoundField DataField="playernumber" HeaderText="球员编号" />
                            <asp:BoundField DataField="datebirth" HeaderText="出生日期" />
                            <asp:BoundField DataField="IDnumber" HeaderText="身份证号" />
                            <asp:TemplateField HeaderText="性别">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropAttri" runat="server">
                                        <asp:ListItem Text="男"></asp:ListItem>
                                        <asp:ListItem Text="女"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="gender" runat="server" Text="Label"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" HeaderText="编辑信息" />
                            <asp:TemplateField HeaderText="删除">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="DeletePlayer" CommandName="DeletePlayer" ImageUrl="~/delete.jpg" ToolTip="删除课程" Width="21px" Height="21px" OnClientClick="return confirm('是否确认删除该球员信息？');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="#A6CAD8" />
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div style="height: 15px; overflow: hidden; clear: both;"></div>
        <div class="footer">三峡大学信息管理与信息系统专业</div>
    </form>
</body>
</html>
