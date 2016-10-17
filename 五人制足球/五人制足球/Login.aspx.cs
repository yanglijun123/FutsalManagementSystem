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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataBaseAccess db = new DataBaseAccess();
                DataTable dt = db.read("select distinct userType from UserInformation", CommandType.Text).Tables[0];
                DropDownList1.Items.Add("--->请选择管理类型<---".ToString());
                foreach(DataRow dr in dt.Rows)
                {
                    DropDownList1.Items.Add(new ListItem(dr["userType"].ToString()));
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataBaseAccess db = new DataBaseAccess();
            try
            {
                SqlParameter sname = new SqlParameter("@Username", TextBox1.Text);
                SqlParameter spwd = new SqlParameter("@UserPassword", TextBox2.Text);
                SqlParameter stype = new SqlParameter("@userType", DropDownList1.SelectedValue.ToString());
                SqlParameter sprv = new SqlParameter("@checkresult", SqlDbType.Int);
                sprv.Direction = ParameterDirection.Output;
                db.command("checkuser", CommandType.StoredProcedure, sname, spwd, stype, sprv);
                if (sprv.Value.ToString() == "1")
                {
                    if (DropDownList1.SelectedValue.ToString() == "球队管理员")
                    {
                        Response.Redirect("teammanage.aspx");
                    }
                    else
                    {
                        if (DropDownList1.SelectedValue.ToString() == "赛事管理员")
                        {
                            Response.Redirect("matchmanage.aspx");
                        }
                        else
                        {
                            Response.Redirect("scoremanage.aspx");
                        }
                    }
                }
                else
                {
                    TextBox2.Text = "";
                    Response.Write("<script>alert('用户名或密码错误！');</script>");
                }
            }
            catch (Exception ex)
            { throw ex; }
        }
    }
}