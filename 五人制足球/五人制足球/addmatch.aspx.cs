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
    public partial class addmatch : System.Web.UI.Page
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
                DataTable da = db.read("select distinct Teamname from TeamSum", CommandType.Text).Tables[0];
                DropDownList1.Items.Add("--->请选择球队<---".ToString());
                DropDownList2.Items.Add("--->请选择球队<---".ToString());
                DropDownList3.Items.Add("--->请选择裁判员<---".ToString());
                DropDownList4.Items.Add("--->请选择计时员<---".ToString());
                foreach (DataRow dr in da.Rows)
                {
                    DropDownList1.Items.Add(new ListItem(dr["Teamname"].ToString()));
                    DropDownList2.Items.Add(new ListItem(dr["Teamname"].ToString()));
                }
                da = db.read("select Judgername from JudgeInformation", CommandType.Text).Tables[0];
                foreach (DataRow dr in da.Rows)
                {
                    DropDownList3.Items.Add(new ListItem(dr["Judgername"].ToString()));
                }
                da = db.read("select Timekeepername from TimeKeeperInformation", CommandType.Text).Tables[0];
                foreach (DataRow dr in da.Rows)
                {
                    DropDownList4.Items.Add(new ListItem(dr["Timekeepername"].ToString()));
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
                SqlParameter turn = new SqlParameter("@turn", TextBox1.Text);
                SqlParameter FieldOrder = new SqlParameter("@FieldOrder", TextBox2.Text);
                SqlParameter fixture = new SqlParameter("@fixture", TextBox3.Text);
                SqlParameter A = new SqlParameter("@A", DropDownList1.SelectedValue.ToString());
                SqlParameter B = new SqlParameter("@B", DropDownList2.SelectedValue.ToString());
                SqlParameter courtname = new SqlParameter("@courtname", TextBox6.Text);
                SqlParameter Judgername = new SqlParameter("@Judgername", DropDownList3.SelectedValue.ToString());
                SqlParameter Timekeepername = new SqlParameter("@Timekeepername", DropDownList4.SelectedValue.ToString());
                SqlParameter sprv = new SqlParameter("@sprv", SqlDbType.Int);
                sprv.Direction = ParameterDirection.Output;
                db.command("insertmatch", CommandType.StoredProcedure, turn, FieldOrder, fixture,A,B,courtname,Judgername,Timekeepername, sprv);
                if (sprv.Value.ToString() == "0")
                {
                    //if (DropDownList1.SelectedValue.ToString() == "球队管理员")
                    //{
                    //    Response.Redirect("teammanage.aspx");
                    //}
                    //else
                    //{
                    //    if (DropDownList1.SelectedValue.ToString() == "赛事管理员")
                    //    {
                    //        Response.Redirect("matchmanage.aspx");
                    //    }
                    //    else
                    //    {
                    //        Response.Write("<script>alert('登录成功！');</script>");
                    //    }
                    //}
                    Response.Write("<script>alert('添加成功！');</script>");
                }
                else
                {
                    TextBox2.Text = "";
                    Response.Write("<script>alert('插入失败！');</script>");
                }
            }
            catch (Exception ex)
            { throw ex; }
        }
    }
}