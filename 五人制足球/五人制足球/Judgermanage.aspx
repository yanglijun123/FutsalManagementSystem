<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Judgermanage.aspx.cs" Inherits="五人制足球.Judgermanage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>五人制足球---裁判员管理</title>
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
                    <i>裁判员管理</i>
                </div>
                <div class="pagetitle" style="width: 550px; margin-left: 20px;text-align:center; height: 40px; border-bottom: 1px solid #036; font-family: 楷体; line-height: 40px;">
                    <i>添加裁判员</i>
                </div>
                <div class="login" style="margin-top: 20px;">
                    <%-- 用户名 --%>
                    <asp:Label ID="Label1" runat="server" Text="姓名" CssClass="td1"></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="td2"></asp:TextBox>
                    <span style="color: red; margin-left: 0;" class="td3">*</span><br />
                    <%-- 类别--%>
                    <%--                    <div style="margin-top: 10px;">
                        <asp:Label ID="Label3" runat="server" Text="类别" CssClass="td4"></asp:Label>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="td2"></asp:TextBox>
                        <span style="color: red; margin-left: 0;" class="td3">*</span>
                    </div>--%>
                    <table style="margin-top: 5px; text-align: center; margin-left: 150px;">
                        <tr>
                            <td colspan="3" class="td1" style="text-align: center; margin-top: 10px;">
                                <asp:Button ID="Button1" runat="server" Text="添加" BorderWidth="5" OnClick="Button1_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="pagetitle" style="width: 550px; margin-left: 20px;text-align:center; height: 40px; border-bottom: 1px solid #036; font-family: 楷体; line-height: 40px;">
                    <i>编辑裁判员信息</i>
                </div>
                <div class="judge" style="text-align: center; margin-left: 225px; margin-top: 10px">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="true" OnRowCancelingEdit="GridView1_RowCancelingEdit" PageSize="4" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="Judgernumber" HeaderText="编号" />
                            <asp:BoundField DataField="Judgername" HeaderText="姓名" />
                            <asp:CommandField ShowEditButton="True" HeaderText="编辑信息" />
                            <asp:TemplateField HeaderText="删除">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="DeletePlayer" CommandName="Delete" ImageUrl="~/delete.jpg" ToolTip="删除" Width="21px" Height="21px" OnClientClick="return confirm('是否确认删除该裁判信息？');" />
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
