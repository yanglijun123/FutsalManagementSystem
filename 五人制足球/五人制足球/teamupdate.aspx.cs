using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace 五人制足球
{
    public partial class teamupdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataBaseAccess db = new DataBaseAccess();
                dt = db.read("findnode", CommandType.StoredProcedure).Tables[0];
                DataRow[] rows = dt.Select("topid='0'");
                for (int i = 0; i < rows.Length; i++)
                {
                    TreeNode node = new TreeNode(rows[i]["permissionname"].ToString(), rows[i]["permissionid"].ToString(), "", rows[i]["url"].ToString(), "MainFrame");
                    TreeView1.Nodes.Add(node);
                    AddChildNode(node, dt.Select("topid='" + rows[i]["permissionid"].ToString() + "'"));
                }
                databind();
            }
        }
        DataTable dt;
        void AddChildNode(TreeNode node, DataRow[] rows)
        {
            for (int i = 0; i < rows.Length; i++)
            {
                TreeNode node1=new TreeNode(rows[i]["permissionname"].ToString(), rows[i]["permissionid"].ToString(), "",rows[i]["url"].ToString(), "MainFrame");
                node.ChildNodes.Add(node1);
                DataRow[] dr = dt.Select("topid='" + rows[i]["permissionid"].ToString() + "'");
                if (dr != null)
                {
                    AddChildNode(node1, dr);
                }
            }
        }
        void databind()
        {
            DataBaseAccess db = new DataBaseAccess();
            DataTable da = db.read("select * from TeamSum", CommandType.Text).Tables[0];
            DataView dv = da.DefaultView;
            GridView1.DataKeyNames = new string[] { "teamname" };
            if (Session["sort"] != null)
                dv.Sort = Session["sort"].ToString();
            GridView1.DataSource = dv;
            GridView1.DataBind();
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string teamname = ((TextBox)GridView1.Rows[e.RowIndex].Cells[0].Controls[0]).Text;
            string Leadername = ((TextBox)GridView1.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            string Teamcoach = ((TextBox)GridView1.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            string Telephone = ((TextBox)GridView1.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
            DataBaseAccess db = new DataBaseAccess();
            db.command("update TeamSum set teamname='" + teamname + "',Leadername='" + Leadername + "',Teamcoach='" + Teamcoach + "',Telephone='" + Telephone + "' where teamname='" + teamname + "'", CommandType.Text);
            GridView1.EditIndex = -1;
            databind();
            Response.Write("<script>alert('更新成功！');</script>");
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                DataBaseAccess db = new DataBaseAccess();
                GridViewRow drv = ((GridViewRow)(((ImageButton)(e.CommandSource)).Parent.Parent)); //此得出的值是表示那行被选中的索引值
                string teamname = (GridView1.DataKeys[drv.RowIndex]["teamname"].ToString());
                db.command("delete from TeamSum where teamname='" + teamname + "'", CommandType.Text);
                db.command("delete from TeamPlayer where teamname='" + teamname + "'", CommandType.Text);
                databind();
                Response.Write("<script>alert('删除成功！');</script>");
            }
        }

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (Session["sort"] == null)
            {
                Session["sort"] = e.SortExpression + "asc";
            }
            else
            {
                string sort = Session["sort"].ToString();
                string[] ss=sort.Split(' ');
                if (ss[0] == e.SortExpression)
                    if (ss[1] == "asc")
                    {
                        Session["sort"] = e.SortExpression + "desc";
                    }
                    else
                        Session["sort"] = e.SortExpression + "asc";
            }
            databind();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            databind();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            databind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate)) || (e.Row.RowState == DataControlRowState.Edit))
            {
                TextBox curText;
                curText = (TextBox)e.Row.Cells[0].Controls[0];
                curText.Width = Unit.Pixel(60);
                curText = (TextBox)e.Row.Cells[1].Controls[0];
                curText.Width = Unit.Pixel(60);
                curText = (TextBox)e.Row.Cells[2].Controls[0];
                curText.Width = Unit.Pixel(60);
                curText = (TextBox)e.Row.Cells[3].Controls[0];
                curText.Width = Unit.Pixel(80);
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            databind();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

    }
}