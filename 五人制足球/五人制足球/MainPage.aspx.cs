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
    public partial class MainPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PlayerBind();
                TeamBind();
            }
        }
        //球员射手榜前五甲
        void PlayerBind()
        {
            DataBaseAccess db = new DataBaseAccess();
            DataTable dt = db.read("select place,playername,teamname,playergoals from playerranking", CommandType.Text).Tables[0];
            DataView dv = dt.DefaultView;
            GridView1.DataSource = dv;
            GridView1.DataBind();
        }
        //球队积分榜五甲
        void TeamBind()
        {
            DataBaseAccess db = new DataBaseAccess();
            DataTable dt = db.read("select * from teamranking", CommandType.Text).Tables[0];
            DataView dv = dt.DefaultView;
            GridView2.DataSource = dv;
            GridView2.DataBind();
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}