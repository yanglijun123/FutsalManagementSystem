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
    public partial class PlayerAdd : System.Web.UI.Page
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
                DataTable da = db.read("select distinct teamname from teamsum", CommandType.Text).Tables[0];
                DropDownList1.Items.Add("--->请选择球队名称<---".ToString());
                foreach (DataRow dr in da.Rows)
                {
                    DropDownList1.Items.Add(new ListItem(dr["teamname"].ToString()));
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
               //,@playername,@datebirth,@idnumber,@gender,@teamname
                SqlParameter playernumber = new SqlParameter("@playernumber", TextBox2.Text);
                SqlParameter playername = new SqlParameter("@playername", TextBox1.Text);
                SqlParameter teamname = new SqlParameter("@teamname", DropDownList1.SelectedValue.ToString());
                SqlParameter datebirth = new SqlParameter("@datebirth", date_1.Text);
                SqlParameter idnumber = new SqlParameter("@idnumber", TextBox6.Text);
                string sex = ChooseSex.SelectedIndex.ToString();
                if (sex == "1")
                {
                    sex = "女";
                }
                else
                {
                    sex = "男";
                }
                SqlParameter gender = new SqlParameter("@gender", sex);
                SqlParameter returnresult = new SqlParameter("@returnresult", SqlDbType.Int);
                returnresult.Direction = ParameterDirection.Output;
                db.command("playeradd",CommandType.StoredProcedure,playernumber,playername,datebirth,idnumber,gender,teamname,returnresult);
                if(returnresult.Value.ToString()=="0")
                {
                    Response.Write("<script>alert('添加成功！');</script>");
                }
                else
                    if (returnresult.Value.ToString() == "3")
                    {
                        Response.Write("<script>alert('球员名或身份证号或球员号码均不能为空，请检查！');</script>");
                    }
                    else
                    {
                        if (returnresult.Value.ToString() == "2")
                        {
                            Response.Write("<script>alert('球员编号或球员名已存在，请检查！');</script>");
                        }
                        else
                        {
                            if (returnresult.Value.ToString() == "1")
                                Response.Write("<script>alert('球员身份证号不唯一，请检查！');</script>");
                        }
                    }
            }
            catch(Exception ex)
            {
                throw ex;
            }
            
        }

        protected void ChooseSex_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}