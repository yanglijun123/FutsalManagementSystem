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
    public partial class editmatch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataBaseAccess db = new DataBaseAccess();
                dt = db.read("findmatchnode", CommandType.StoredProcedure).Tables[0];
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
            string sqlstr = "select distinct teama from ScheduleArrange";
            sqlcon = new SqlConnection(strCon);
            SqlCommand sqlcom = new SqlCommand(sqlstr, sqlcon);
            sqlcon.Open();
            return sqlcom.ExecuteReader();
        }
        public SqlDataReader ddlbindb()
        {
            SqlConnection sqlcon;
            string strCon = "data source=.;database=IndoorFootball;user id=sa;password=123;";
            string sqlstr = "select distinct teamb from ScheduleArrange";
            sqlcon = new SqlConnection(strCon);
            SqlCommand sqlcom = new SqlCommand(sqlstr, sqlcon);
            sqlcon.Open();
            return sqlcom.ExecuteReader();
        }
        public SqlDataReader ddlbindtimekeeper()
        {
            SqlConnection sqlcon;
            string strCon = "data source=.;database=IndoorFootball;user id=sa;password=123;";
            string sqlstr = "select distinct Timekeepername from TimeKeeperInformation";
            sqlcon = new SqlConnection(strCon);
            SqlCommand sqlcom = new SqlCommand(sqlstr, sqlcon);
            sqlcon.Open();
            return sqlcom.ExecuteReader();
        }       
        public SqlDataReader ddlbindjudge()
        {
            SqlConnection sqlcon;
            string strCon = "data source=.;database=IndoorFootball;user id=sa;password=123;";
            string sqlstr = "select distinct Judgername from JudgeInformation";
            sqlcon = new SqlConnection(strCon);
            SqlCommand sqlcom = new SqlCommand(sqlstr, sqlcon);
            sqlcon.Open();
            return sqlcom.ExecuteReader();
        }      
        private void BindGrid()
        {
            DataBaseAccess db = new DataBaseAccess();
            DataTable dt = db.read("select * from ScheduleArrange order by turn,FieldOrder", CommandType.Text).Tables[0];
            DataView dv = dt.DefaultView;
            GridView1.DataKeyNames = new string[] { "turn", "FieldOrder" };
            GridView1.DataSource = dv;
            GridView1.DataBind();
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                DataBaseAccess db = new DataBaseAccess();
                GridViewRow drv = ((GridViewRow)(((ImageButton)(e.CommandSource)).Parent.Parent)); //此得出的值是表示那行被选中的索引值
                //int number = Convert.ToInt32(GridView1.DataKeys[drv.RowIndex].Value); //此获取的值为GridView中绑定数据库中的主键值 
                ////int number =(int.Parse)(e.CommandArgument.ToString());
                int turn = Int32.Parse(GridView1.DataKeys[drv.RowIndex]["turn"].ToString());
                int FieldOrder = Int32.Parse(GridView1.DataKeys[drv.RowIndex]["FieldOrder"].ToString());
                db.command("delete from ScheduleArrange where turn=" + turn + " and FieldOrder=" + FieldOrder + "", CommandType.Text);
                BindGrid();
                Response.Write("<script>alert('删除成功！');</script>");
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string turn = GridView1.DataKeys[e.RowIndex]["turn"].ToString();
            string FieldOrder = GridView1.DataKeys[e.RowIndex]["FieldOrder"].ToString();
            string fixture = ((TextBox)GridView1.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            string teama = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList1")).SelectedValue.ToString();
            string teamb = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList2")).SelectedValue.ToString();
            string Courtname = ((TextBox)GridView1.Rows[e.RowIndex].Cells[5].Controls[0]).Text;
            string Judgername = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList3")).SelectedValue.ToString();
            string Timekeepername = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList4")).SelectedValue.ToString();
            SqlParameter[] sp =
            {
                new SqlParameter("@turn",turn),
                new SqlParameter("FieldOrder",FieldOrder),
                new SqlParameter("@fixture",fixture),
                new SqlParameter("@teama",teama),
                new SqlParameter("@teamb",teamb),
                new SqlParameter("@Courtname",Courtname),
                new SqlParameter("@Judgername",Judgername),
                new SqlParameter("@Timekeepername",Timekeepername),
                new SqlParameter("@sprv",SqlDbType.Int)
            };
            sp[8].Direction= ParameterDirection.Output;
            DataBaseAccess db = new DataBaseAccess();
            db.command("updatematch", CommandType.StoredProcedure,sp);
            GridView1.EditIndex = -1;
            BindGrid();
            Response.Write("<script>alert('更新成功！');</script>");
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

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState
                    == DataControlRowState.Alternate)
                {
                    ((Label)e.Row.FindControl("teama")).Text = drv["teama"].ToString();
                    ((Label)e.Row.FindControl("teamb")).Text = drv["teamb"].ToString();
                    ((Label)e.Row.FindControl("Judgername")).Text = drv["Judgername"].ToString();
                    ((Label)e.Row.FindControl("Timekeepername")).Text = drv["Timekeepername"].ToString();
                }
                if (e.Row.RowState == DataControlRowState.Edit)
                {
                    DropDownList ddl = (DropDownList)e.Row.FindControl("DropDownList1");
                    ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(drv["teama"].ToString()));
                    DropDownList dd = (DropDownList)e.Row.FindControl("DropDownList2");
                    dd.SelectedIndex = dd.Items.IndexOf(ddl.Items.FindByValue(drv["teamb"].ToString()));
                    DropDownList d = (DropDownList)e.Row.FindControl("DropDownList3");
                    d.SelectedIndex = d.Items.IndexOf(ddl.Items.FindByValue(drv["Judgername"].ToString()));
                    DropDownList ddll = (DropDownList)e.Row.FindControl("DropDownList4");
                    ddll.SelectedIndex = ddll.Items.IndexOf(ddl.Items.FindByValue(drv["Timekeepername"].ToString()));
                }
            }
            if ((e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate)) || (e.Row.RowState == DataControlRowState.Edit))
            {
                TextBox curText;
                curText = (TextBox)e.Row.Cells[0].Controls[0];
                curText.Width = Unit.Pixel(20);
                curText = (TextBox)e.Row.Cells[1].Controls[0];
                curText.Width = Unit.Pixel(20);
                curText = (TextBox)e.Row.Cells[2].Controls[0];
                curText.Width = Unit.Pixel(100);
                curText = (TextBox)e.Row.Cells[5].Controls[0];
                curText.Width = Unit.Pixel(40);
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
    }
}