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
    public partial class LeagueStanding___Team : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dt();
            }
        }
        //datalist绑定
        private void dt()
        {
            DataBaseAccess da = new DataBaseAccess();
            DataTable dt = da.read("select distinct teamname from LeagueStanding", CommandType.Text).Tables[0];
            DataView dv = dt.DefaultView;
            DataList1.DataSource = dv;
            DataList1.DataKeyField = "teamname";
            DataList1.DataBind();
        }
        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ddd = DataList1.DataKeys[DataList1.SelectedItem.ItemIndex].ToString();
            string dda = "select teamname,teamlose,teamscore,goaldifference,score,turn from LeagueStanding where teamname='" + ddd + "'";
            ds(dda);
        }
        public void ds(string str)
        {
            DataBaseAccess dtm = new DataBaseAccess();
            DataTable dt = dtm.read(str, CommandType.Text).Tables[0];
            DataView dv = dt.DefaultView;
            GridView1.DataSource = dv;
            GridView1.DataBind();
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}