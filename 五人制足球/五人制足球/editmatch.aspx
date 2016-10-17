<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editmatch.aspx.cs" Inherits="五人制足球.editmatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>五人制足球---编辑赛事</title>
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
                    <i>编辑赛事</i>
                </div>
                <div style="margin-top: 20px;margin-left:20px">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="true" PageSize="5" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDataBound="GridView1_RowDataBound" OnRowDeleting="GridView1_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="turn" HeaderText="轮次" />
                            <asp:BoundField DataField="FieldOrder" HeaderText="场序" />
                            <asp:BoundField DataField="fixture" HeaderText="比赛时间" />
                            <asp:TemplateField HeaderText="A队">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" runat="server"
                                        DataSource="<%# ddlbind() %>" DataTextField="teama"
                                        DataValueField="teama">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="teama" runat="server" Text="Label"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="B队">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList2" runat="server"
                                        DataSource="<%# ddlbindb() %>" DataTextField="teamb"
                                        DataValueField="teamb">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="teamb" runat="server" Text="Label"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Courtname" HeaderText="比赛场地" />
                            <asp:TemplateField HeaderText="裁判">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList3" runat="server"
                                        DataSource="<%# ddlbindjudge() %>" DataTextField="Judgername"
                                        DataValueField="Judgername">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Judgername" runat="server" Text="Label"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="计时员">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList4" runat="server"
                                        DataSource="<%# ddlbindtimekeeper() %>" DataTextField="Timekeepername"
                                        DataValueField="Timekeepername">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Timekeepername" runat="server" Text="Label"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField HeaderText="编辑" ShowEditButton="True" />
                            <asp:TemplateField HeaderText="删除">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="Delete" CommandName="Delete" ImageUrl="~/delete.jpg" ToolTip="删除课程" Width="21px" Height="21px" OnClientClick="return confirm('是否确认删除该比赛信息？');" />
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
