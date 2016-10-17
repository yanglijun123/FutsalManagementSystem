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
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataBaseAccess db = new DataBaseAccess();
            DataTable dt = db.read("select distinct userType from UserInformation", CommandType.Text).Tables[0];
            DropDownList1.Items.Add("--->请选择管理类型<---".ToString());
            foreach (DataRow dr in dt.Rows)
            {
                DropDownList1.Items.Add(new ListItem(dr["userType"].ToString()));
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataBaseAccess db = new DataBaseAccess();
            try
            {
                DataTable dt = db.read("select Username from userinformation where Username='" + TextBox1.Text + "'", CommandType.Text).Tables[0];
                int i = dt.Rows.Count;
                if (i.ToString()== "0")
                {
                    if (TextBox2.Text == TextBox3.Text)
                    {
                        SqlParameter sname = new SqlParameter("@Username", TextBox1.Text);
                        SqlParameter spwd = new SqlParameter("@UserPassword", TextBox2.Text);
                        SqlParameter stype = new SqlParameter("@userType", DropDownList1.SelectedValue.ToString());
                        SqlParameter semail = new SqlParameter("@UserEmail", TextBox4.Text);
                        SqlParameter stel = new SqlParameter("@Usertelephone", TextBox5.Text);
                        SqlParameter sresult = new SqlParameter("@result", SqlDbType.Int);
                        sresult.Direction = ParameterDirection.Output;
                        db.command("insertuser", CommandType.StoredProcedure, sname, spwd,stype,semail, stel, sresult);
                        if (sresult.Value.ToString() == "1")
                        {
                            Response.Redirect("Login.aspx");
                            //Response.Write("<script>alert('继续');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('注册失败，请重新注册');</script>");
                        }
                    }
                    else
                    {
                        TextBox2.Text = "";
                        TextBox3.Text = "";
                        Response.Write("<script>alert('两次密码不一致！');</script>");
                    }
                }
                else
                {
                    TextBox2.Text = "";
                    TextBox3.Text = "";
                    Response.Write("<script>alert('该用户已存在！');</script>");
                }
            }
            catch (Exception ex)
            { throw ex; }
        }
    }
}