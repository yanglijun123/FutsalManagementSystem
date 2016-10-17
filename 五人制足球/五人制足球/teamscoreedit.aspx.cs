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
    public partial class teamscoreedit : System.Web.UI.Page
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
        private void BindGrid()
        {
            DataBaseAccess db = new DataBaseAccess();
            DataTable dt = db.read("select * from LeagueStanding order by turn desc", CommandType.Text).Tables[0];
            DataView dv = dt.DefaultView;
            GridView1.DataKeyNames = new string[] { "teamname", "turn" };
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
                string teamname = (GridView1.DataKeys[drv.RowIndex]["teamname"].ToString());
                db.command("delete from LeagueStanding where teamname='" + teamname + "' and turn='" + turn + "'", CommandType.Text);
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
            string teamname = GridView1.DataKeys[e.RowIndex]["teamname"].ToString();
            string turn = GridView1.DataKeys[e.RowIndex]["turn"].ToString();
            string teamscore = ((TextBox)GridView1.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            string teamlose = ((TextBox)GridView1.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
            //string score = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[4].Controls[0]).Text;
            string score = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("dropdownlist1")).SelectedValue.ToString();
            DataTable dt = db.read("select score from LeagueStanding where teamname='" + teamname + "' and turn=" + turn  + "-1", CommandType.Text).Tables[0];
            string scor = dt.Rows[0]["score"].ToString();
            db.command("update LeagueStanding set teamscore='" + teamscore + "',teamlose='"+teamlose+"',score="+scor+"+"+score+" where turn=" + turn + " and teamname='" + teamname + "'", CommandType.Text);
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
                    ((Label)e.Row.FindControl("score")).Text = drv["score"].ToString();
                }
                if (e.Row.RowState == DataControlRowState.Edit)
                {
                    DropDownList ddl = (DropDownList)e.Row.FindControl("DropDownList1");
                    ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(drv["score"].ToString()));
                }
            }
            if ((e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate)) || (e.Row.RowState == DataControlRowState.Edit))
            {
                TextBox curText;
                curText = (TextBox)e.Row.Cells[2].Controls[0];
                curText.Width = Unit.Pixel(40);
                curText = (TextBox)e.Row.Cells[3].Controls[0];
                curText.Width = Unit.Pixel(40);
            }
        }
    }
}