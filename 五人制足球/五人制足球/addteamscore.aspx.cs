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
    public partial class addteamscore : System.Web.UI.Page
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
                DataTable da = db.read("select distinct turn from ScheduleArrange", CommandType.Text).Tables[0];
                DropDownList1.Items.Add("--->请选择轮次<---".ToString());
                foreach (DataRow dr in da.Rows)
                {
                    DropDownList1.Items.Add(new ListItem(dr["turn"].ToString()));
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
            SqlParameter[] sp=
            {
                new SqlParameter("@turn",DropDownList1.SelectedValue),
                new SqlParameter("@teamname",DropDownList2.SelectedValue),
                new SqlParameter("@teamscore",TextBox1.Text),
                new SqlParameter("@teamlose",TextBox2.Text),
                new SqlParameter("@score",DropDownList3.Text),
                new SqlParameter("@sprv",SqlDbType.Int)
            };
            sp[5].Direction=ParameterDirection.Output;
            DataBaseAccess db=new DataBaseAccess();
            db.command("insertteamscore",CommandType.StoredProcedure,sp);
            if (sp[5].Value.ToString() == "0")
            {
                Response.Write("<script>alert('添加成功！');</script>");
                DropDownList1.Items.Clear();
                DropDownList2.Items.Clear();
                DropDownList3.Items.Clear();
                TextBox1.Text = "";
                TextBox2.Text = "";
            }
            else
            {
                Response.Write("<script>alert('添加失败！');</script>");
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList2.Items.Clear();
            DataBaseAccess db = new DataBaseAccess();
            string turn = DropDownList1.SelectedValue;
            DataTable dateam = db.read("select teama from ScheduleArrange where turn='"+turn+"'", CommandType.Text).Tables[0];
            DropDownList2.Items.Add("--->请选择球队<---".ToString());
            foreach (DataRow dr in dateam.Rows)
            {
                DropDownList2.Items.Add(new ListItem(dr["teama"].ToString()));
            }
            DataTable dateamb = db.read("select teamb from ScheduleArrange where turn='" + turn + "'", CommandType.Text).Tables[0];
            foreach (DataRow dr in dateamb.Rows)
            {
                DropDownList2.Items.Add(new ListItem(dr["teamb"].ToString()));
            }
        }

    }
}