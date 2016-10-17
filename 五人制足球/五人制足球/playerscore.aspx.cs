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
    public partial class playerscore : System.Web.UI.Page
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
                DataTable da = db.read("select distinct turn from LeagueStanding", CommandType.Text).Tables[0];
                DropDownList3.Items.Add("--->选择轮次<---".ToString());
                foreach (DataRow dr in da.Rows)
                {
                    DropDownList3.Items.Add(new ListItem(dr["turn"].ToString(), dr["turn"].ToString()));
                }
                DataTable ds = db.read("select top 100 turn from LeagueStanding order by turn desc", CommandType.Text).Tables[0];
                tur= ds.Rows[0]["turn"].ToString();
            }
        }
        string tur;
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
            string teamname = DropDownList1.SelectedValue;
            string playername = DropDownList2.SelectedValue;
            string playerscore = TextBox1.Text;
            DataBaseAccess db = new DataBaseAccess();
            DataTable ds = db.read("select top 1 turn from LeagueStanding order by turn desc", CommandType.Text).Tables[0];
            tur = ds.Rows[0]["turn"].ToString();
            SqlParameter teamn = new SqlParameter("@teamname", teamname);
            SqlParameter player = new SqlParameter("@playername", playername);
            SqlParameter turn = new SqlParameter("@turn", tur);
            SqlParameter score = new SqlParameter("@score", playerscore);
            SqlParameter sprv = new SqlParameter("@result", SqlDbType.Int);
            sprv.Direction = ParameterDirection.Output;
            if (Button1.CommandName == "yes")
            {
                db.command("insertplayerscore", CommandType.StoredProcedure, teamn, player,turn, score, sprv);
                if (sprv.Value.ToString() == "0")
                {
                    Response.Write("<script>alert('添加成功！');</script>");
                    DropDownList1.Items.Clear();
                    DropDownList2.Items.Clear();
                    TextBox1.Text = "";
                }
                else
                {
                    Response.Write("<script>alert('添加失败，请检查！');</script>");
                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList2.Items.Clear();
            string teamname = DropDownList1.SelectedValue;
            DataBaseAccess db = new DataBaseAccess();
            DataTable dt = db.read("select playername from teamplayer where teamname='"+teamname+"'", CommandType.Text).Tables[0];
            DropDownList2.Items.Add("--->选择球员<---".ToString());
            foreach (DataRow dr in dt.Rows)
            {
                DropDownList2.Items.Add(new ListItem(dr["playername"].ToString(),dr["playername"].ToString()));
            }
        }

        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList1.Items.Clear();
            string turn = DropDownList3.SelectedValue;
            DropDownList1.Items.Add("--->选择球队<---".ToString());
            DataBaseAccess db = new DataBaseAccess();
            DataTable da = db.read("select distinct teamname from LeagueStanding where turn='"+turn+"'", CommandType.Text).Tables[0];
            foreach (DataRow dr in da.Rows)
            {
                DropDownList1.Items.Add(new ListItem(dr["teamname"].ToString(), dr["teamname"].ToString()));
            }
        }
    }
}