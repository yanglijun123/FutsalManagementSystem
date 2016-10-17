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
    public partial class PlayerEdit : System.Web.UI.Page
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
                DataTable da = db.read("select distinct teamname from TeamPlayer", CommandType.Text).Tables[0];
                DropDownList1.Items.Add("--->请选择球队名称<---".ToString());
                foreach (DataRow dr in da.Rows)
                {
                    DropDownList1.Items.Add(new ListItem(dr["teamname"].ToString()));
                }
               // databind();
            }
            GridView1.Attributes.Add("style", "table-layout:fixed");
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
        void databind()
        {
            DataBaseAccess db = new DataBaseAccess();
            string teamname = DropDownList1.SelectedValue;
            DataTable da = db.read("select  playernumber,playerorder,playername,idnumber,gender,CONVERT(varchar(100),datebirth,5) datebirth from teamplayer where teamname='" + teamname + "'", CommandType.Text).Tables[0];
            DataView dv = da.DefaultView;
            GridView1.DataKeyNames = new string[] { "playerorder" };
            GridView1.DataSource = dv;
            GridView1.DataBind();
            GridView1.Columns[0].Visible = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            databind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState
                    == DataControlRowState.Alternate)
                {
                    ((Label)e.Row.FindControl("gender")).Text = drv["gender"].ToString();
                }
                if (e.Row.RowState == DataControlRowState.Edit)
                {
                    DropDownList ddl = (DropDownList)e.Row.FindControl("DropAttri");
                    ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(drv["gender"].ToString()));
                }
            }
            if ((e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate)) || (e.Row.RowState == DataControlRowState.Edit))
            {
                    TextBox curText;
                    curText = (TextBox)e.Row.Cells[1].Controls[0];
                    curText.Width = Unit.Pixel(60);
                    curText = (TextBox)e.Row.Cells[2].Controls[0];
                    curText.Width = Unit.Pixel(60);
                    curText = (TextBox)e.Row.Cells[3].Controls[0];
                    curText.Width = Unit.Pixel(120);
                    curText = (TextBox)e.Row.Cells[4].Controls[0];
                    curText.Width = Unit.Pixel(80);
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            databind();
        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            databind();
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string playerorder = GridView1.DataKeys[e.RowIndex].Value.ToString();
            string playername = ((TextBox)GridView1.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            string playernumber = ((TextBox)GridView1.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            string datebirth = ((TextBox)GridView1.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
            string IDnumber = ((TextBox)GridView1.Rows[e.RowIndex].Cells[4].Controls[0]).Text;
            string gender = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropAttri")).SelectedValue.ToString();
            string teamname = DropDownList1.SelectedValue;
            SqlParameter[] sp =
            {
                new SqlParameter("@playerorder", playerorder),
                new SqlParameter("@playername", playername),
                new SqlParameter("@playernumber", playernumber),
                new SqlParameter("@gender",gender),
                new SqlParameter("@datebirth", datebirth),
                new SqlParameter("@IDnumber", IDnumber),
                new SqlParameter("@teamname", teamname),
                new SqlParameter("@updateresult",SqlDbType.Int)
            };
            sp[7].Direction = ParameterDirection.Output;
            DataBaseAccess db = new DataBaseAccess();
            if (gender.ToString() != null)
                db.command("updateplayer", CommandType.StoredProcedure, sp);
            GridView1.EditIndex = -1;
            databind();
            if (sp[7].Value.ToString() == "0")
            {
                Response.Write("<script>alert('更新成功！');</script>");
            }
            else
            {
                Response.Write("<script>alert('更新失败！');</script>"); 
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeletePlayer")
            {
                DataBaseAccess db = new DataBaseAccess();
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).Parent.Parent;
                string teamname = DropDownList1.SelectedValue;
                int id = Convert.ToInt32(GridView1.DataKeys[gvr.RowIndex].Value);
                db.command("delete from teamplayer where playerorder="+id+"",CommandType.Text);                
                databind();
                Response.Write("<script>alert('删除成功！');</script>");
            }
        }
    }
}