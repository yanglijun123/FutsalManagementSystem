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
    public partial class playerscoreedit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataBaseAccess db = new DataBaseAccess();
                dt = db.read("select * from teamnode where username='ccc'", CommandType.Text).Tables[0];
                DataRow[] rows = dt.Select("topid='0'");
                for (int i = 0; i < rows.Length; i++)
                {
                    TreeNode node = new TreeNode(rows[i]["permissionname"].ToString(), rows[i]["permissionid"].ToString(), "", rows[i]["url"].ToString(), "MainFrame");
                    TreeView1.Nodes.Add(node);
                    AddChildNode(node, dt.Select("topid='" + rows[i]["permissionid"].ToString() + "'"));
                }
                BindGrid();
            }
        }
        DataTable dt;
        void AddChildNode(TreeNode node, DataRow[] rows)
        {
            for (int i = 0; i < rows.Length; i++)
            {
                TreeNode node1 = new TreeNode(rows[i]["permissionname"].ToString(), rows[i]["permissionid"].ToString(), "", rows[i]["url"].ToString(), "MainFrame");
                node.ChildNodes.Add(node1);
                DataRow[] dr = dt.Select("topid='" + rows[i]["permissionid"].ToString() + "'");
                if (dr != null)
                {
                    AddChildNode(node1, dr);
                }
            }
        }
        public SqlDataReader ddlbind()
        {
            SqlConnection sqlcon;
            string strCon = "data source=.;database=IndoorFootball;user id=sa;password=123;";
            string sqlstr = "select distinct teamname from LeagueStanding";
            sqlcon = new SqlConnection(strCon);
            SqlCommand sqlcom = new SqlCommand(sqlstr, sqlcon);
            sqlcon.Open();
            return sqlcom.ExecuteReader();
        }
        private void BindGrid()
        {
            DataBaseAccess db = new DataBaseAccess();
            DataTable dt = db.read("select top 100 * from TeamPlayer,topscorer where teamplayer.playerorder=topscorer.playerorder order by turn", CommandType.Text).Tables[0];
            DataView dv = dt.DefaultView;
            GridView1.DataKeyNames = new string[] { "playername","turn" };
            GridView1.DataSource = dv;
            GridView1.DataBind();
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                DataBaseAccess db = new DataBaseAccess();
                GridViewRow drv = ((GridViewRow)(((ImageButton)(e.CommandSource)).Parent.Parent)); //此得出的值是表示那行被选中的索引值
                int turn = Int32.Parse(GridView1.DataKeys[drv.RowIndex]["turn"].ToString());
                string playername = (GridView1.DataKeys[drv.RowIndex]["playername"].ToString());
                DataTable dt = db.read("select playerorder from TeamPlayer where playername='" + playername + "'", CommandType.Text).Tables[0];
                string playerorder = dt.Rows[0]["playerorder"].ToString();
                db.command("delete from topscorer where playerorder=" + playerorder + " and turn='"+turn+"'", CommandType.Text);
                BindGrid();
                Response.Write("<script>alert('删除成功！');</script>");
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            DataBaseAccess db = new DataBaseAccess();
            string playername = GridView1.DataKeys[e.RowIndex]["playername"].ToString();
            string turn = GridView1.DataKeys[e.RowIndex]["turn"].ToString();
            DataTable dt = db.read("select playerorder from TeamPlayer where playername='" + playername + "'", CommandType.Text).Tables[0];
            string playerorder = dt.Rows[0]["playerorder"].ToString();
            string playergoals = ((TextBox)GridView1.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
            db.command("update topscorer set playergoals='" + playergoals + "' where turn=" + turn + " and playerorder='" + playerorder + "'", CommandType.Text);
            GridView1.EditIndex = -1;
            BindGrid();
            Response.Write("<script>alert('更新成功！');</script>");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState
                    == DataControlRowState.Alternate)
                {
                    ((Label)e.Row.FindControl("teamname")).Text = drv["teamname"].ToString();
                }
                if (e.Row.RowState == DataControlRowState.Edit)
                {
                    DropDownList ddl = (DropDownList)e.Row.FindControl("DropDownList1");
                    ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(drv["teamname"].ToString()));
                }
            }
            if ((e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate)) || (e.Row.RowState == DataControlRowState.Edit))
            {
                TextBox curText;
                curText = (TextBox)e.Row.Cells[0].Controls[0];
                curText.Width = Unit.Pixel(20);
                curText = (TextBox)e.Row.Cells[2].Controls[0];
                curText.Width = Unit.Pixel(60);
                curText = (TextBox)e.Row.Cells[3].Controls[0];
                curText.Width = Unit.Pixel(40);
            }
        }
    }
}