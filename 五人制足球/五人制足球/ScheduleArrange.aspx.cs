using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace 五人制足球
{
    public partial class ScheduleArrange : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PlayerBind();
                TeamBind();
                DataBaseAccess da = new DataBaseAccess();
                DataTable dt = da.read("select distinct turn from ScheduleArrange", CommandType.Text).Tables[0];
                DropDownList1.Items.Add("--->轮次<---".ToString());
                foreach (DataRow dr in dt.Rows)
                {
                    DropDownList1.Items.Add(new ListItem(dr["turn"].ToString()));
                }
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

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ddl = DropDownList1.SelectedValue;
            DataBaseAccess db = new DataBaseAccess();
            DataTable dt = db.read("select Turn,FieldOrder,CONVERT(varchar(100),fixture,20)fixture,Courtname,Judgername,Timekeepername,TeamA,TeamB  from ScheduleArrange where turn='" + ddl + "' order by FieldOrder asc", CommandType.Text).Tables[0];
            DataView dv = dt.DefaultView;
            GridView3.DataSource = dv;
            GridView3.DataBind();
        }
    }
}