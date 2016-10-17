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
    public partial class AllTeam : System.Web.UI.Page
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataBaseAccess db = new DataBaseAccess();
            try
            {
                SqlParameter steanmane = new SqlParameter("@Teamname", TextBox1.Text);
                SqlParameter sleader = new SqlParameter("@Leadername", TextBox2.Text);
                SqlParameter scoach = new SqlParameter("@Teamcoach", TextBox3.Text);
                SqlParameter stel = new SqlParameter("@Telephone", TextBox4.Text);
                SqlParameter sprv = new SqlParameter("@checkresult", SqlDbType.Int);
                sprv.Direction = ParameterDirection.Output;
                db.command("insertteam", CommandType.StoredProcedure, steanmane, sleader, scoach, stel, sprv);
                if (sprv.Value.ToString() == "1")
                {
                    Response.Write("<script>alert('添加成功！');</script>");
                }
                else 
                {
                    TextBox1.Text = "";
                    TextBox2.Text = "";
                    TextBox3.Text = "";
                    TextBox4.Text = "";
                    Response.Write("<script>alert('添加失败，请重新添加球队');</script>");
                }
            }
            catch(Exception ex)
            { throw ex; }
        }
    }
}