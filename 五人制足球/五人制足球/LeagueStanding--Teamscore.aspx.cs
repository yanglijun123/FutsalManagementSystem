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
    public partial class LeagueStanding__Teamscore : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataBaseAccess da = new DataBaseAccess();
                DataTable dt = da.read("select distinct turn from LeagueStanding", CommandType.Text).Tables[0];
                DropDownList1.Items.Add("--->轮次<---".ToString());
                foreach (DataRow dr in dt.Rows)
                {
                    DropDownList1.Items.Add(new ListItem(dr["turn"].ToString()));
                }
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ddl = DropDownList1.SelectedValue;
            DataBaseAccess db = new DataBaseAccess();
            DataTable dt = db.read("select Teamname,fieldorder,Turn,Teamscore,Teamlose,GoalDifference,Score from LeagueStanding where turn='" + ddl + "'", CommandType.Text).Tables[0];
            DataView dv = dt.DefaultView;
            GridView1.DataSource = dv;
            GridView1.DataBind();
        }
    }
}