using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace 五人制足球
{
    public class DataBaseAccess
    {
        string connstr = "data source=.;database=IndoorFootball;user id=sa;password=123;";
        /// <summary>
        /// 将查询语句传入read中
        /// </summary>
        /// <param name="sqlcommand"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public DataSet read(string sqlcommand, CommandType type)
        {
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                DataSet ds = new DataSet();
                SqlDataAdapter adapter = new SqlDataAdapter(sqlcommand, conn);
                adapter.SelectCommand.CommandType = type;
                try
                {
                    adapter.Fill(ds);
                    return ds;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        /// <summary>
        /// 可以执行类似存储过程类的方法，需要传入存储过程和数组参数
        /// </summary>
        /// <param name="sqlcommand"></param>
        /// <param name="type"></param>
        /// <param name="sp"></param>
        public void command(string sqlcommand, CommandType type, params SqlParameter[] sp)
        {
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlTransaction st = conn.BeginTransaction(IsolationLevel.Serializable);
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = sqlcommand;
                    cmd.CommandType = type;
                    cmd.Parameters.AddRange(sp);
                    cmd.Transaction = st;
                    int i = cmd.ExecuteNonQuery();
                    st.Commit();
                }
                catch (Exception ex)
                {
                    try
                    {
                        st.Rollback();
                        throw ex;
                    }
                    catch (Exception e)
                    { throw e; }
                }
            }
        }
        /// <summary>
        /// 用于执行sql中update、insert类语句
        /// </summary>
        /// <param name="sqlcommand"></param>
        /// <param name="type"></param>
        public void command(string sqlcommand, CommandType type)
        {
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                conn.Open();
                SqlTransaction st = conn.BeginTransaction(IsolationLevel.Serializable);
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = sqlcommand;
                    cmd.CommandType = type;
                    cmd.Transaction = st;
                    int i = cmd.ExecuteNonQuery();
                    st.Commit();
                }
                catch (Exception ex)
                {
                    try { st.Rollback(); throw ex; }
                    catch (Exception e) { throw e; }
                }
            }
        }
    }
}