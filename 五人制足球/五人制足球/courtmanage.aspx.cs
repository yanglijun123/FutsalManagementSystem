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
    public partial class courtmanage : System.Web.UI.Page
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
        private void BindGrid()
        {
            DataBaseAccess db = new DataBaseAccess();
            DataTable da = db.read("select * from PlayCourt", CommandType.Text).Tables[0];
            DataView dv = da.DefaultView;
            GridView1.DataKeyNames = new string[] { "Courtname" };
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
                string Courtname = GridView1.DataKeys[drv.RowIndex].Value.ToString(); //此获取的值为GridView中绑定数据库中的主键值 
                //int number =(int.Parse)(e.CommandArgument.ToString());
                db.command("delete from PlayCourt where Courtname='" + Courtname + "'", CommandType.Text);
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
            string Courtnam = GridView1.DataKeys[e.RowIndex].Value.ToString();
            string Courtplac = ((TextBox)GridView1.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            SqlParameter Courtplace = new SqlParameter("@Courtplace", Courtplac);
            SqlParameter Courtname = new SqlParameter("@Courtname", Courtnam);
            SqlParameter tablename = new SqlParameter("@tablename", "JudgeInformation");
            // @result
            DataBaseAccess db = new DataBaseAccess();
            db.command("updatecourt", CommandType.StoredProcedure, Courtplace, Courtname);
            GridView1.EditIndex = -1;
            BindGrid();
            Response.Write("<script>alert('更新成功！');</script>");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string name = TextBox1.Text;
            string place = TextBox2.Text;
            DataBaseAccess db = new DataBaseAccess();
            db.command("insert into PlayCourt(Courtname,Courtplace) values('" + name + "','"+place+"')", CommandType.Text);
            Response.Write("<script>alert('添加成功！');</script>");
            BindGrid();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}