using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

namespace TestWebFormApplication
{
    public partial class Employee : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["abc"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
          if(!IsPostBack)
            {
                EmpGender();
                Department();
                Education();
                Hobby();
                GetEmployee();
            }
        }
        public string myhobby()
        {
            string hobby = "";
            for (int i = 0; i < checkboxlist1.Items.Count; i++)
            {
                if (checkboxlist1.Items[i].Selected == true)
                {
                    hobby += checkboxlist1.Items[i].Text + ",";
                }
            }
            hobby = hobby.TrimEnd(',');

            return hobby;
        }
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            string hobby = myhobby();

            if (btnInsert.Text == "Submit")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("AddUpdateEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Emp_Id", -1);
                cmd.Parameters.AddWithValue("@Emp_Name", txtEmp_Name.Text);
                cmd.Parameters.AddWithValue("@Emp_Email", txtEmp_Email.Text);
                cmd.Parameters.AddWithValue("@Contact_Number", Convert.ToInt32(txtContact_Number.Text));
                cmd.Parameters.AddWithValue("@Emp_Address", txtEmp_Address.Text);
                cmd.Parameters.AddWithValue("@Experience", float.Parse(txtExperiences.Value));
                cmd.Parameters.AddWithValue("@Genderid", rblEmp_Gender.SelectedValue);
                cmd.Parameters.AddWithValue("@Departmentid", ddlDepartment.SelectedValue);
                cmd.Parameters.AddWithValue("@Educationid", ddlEducation.SelectedValue);
                cmd.Parameters.AddWithValue("@Hobby", hobby);
                cmd.ExecuteNonQuery();
                con.Close();
                Clear();
            }
            else if (btnInsert.Text == "Update")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("AddUpdateEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Emp_id", Convert.ToInt32(ViewState["id"]));
                //cmd.Parameters.AddWithValue("@Emp_Id", -1);
                cmd.Parameters.AddWithValue("@Emp_Name", txtEmp_Name.Text);
                cmd.Parameters.AddWithValue("@Emp_Email", txtEmp_Email.Text);
                cmd.Parameters.AddWithValue("@Contact_Number", Convert.ToInt32(txtContact_Number.Text));
                cmd.Parameters.AddWithValue("@Emp_Address", txtEmp_Address.Text);
                cmd.Parameters.AddWithValue("@Experience", float.Parse(txtExperiences.Value));
                cmd.Parameters.AddWithValue("@Genderid", rblEmp_Gender.SelectedValue);
                cmd.Parameters.AddWithValue("@Departmentid", ddlDepartment.SelectedValue);
                cmd.Parameters.AddWithValue("@Educationid", ddlEducation.SelectedValue);
                cmd.Parameters.AddWithValue("@Hobby", hobby);
                cmd.ExecuteNonQuery();
                con.Close();
                Clear();
            }
            GetEmployee();
            Clear();
        }
        public void EmpGender()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("GetGender", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            if(dt.Rows.Count>0)
            {
                rblEmp_Gender.DataSource= dt;
                rblEmp_Gender.DataValueField = "Gen_id";
                rblEmp_Gender.DataTextField = "Gender_Name";
                rblEmp_Gender.DataBind();
            }
        }
        public void Department()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("GetDepartment", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                ddlDepartment.DataSource = dt;
                ddlDepartment.DataValueField= "Did";
                ddlDepartment.DataTextField = "Dname";
                ddlDepartment.DataBind();
                ddlDepartment.Items.Insert(0, "--select--");
            }
        }
        public void Education()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("GetEducation", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                ddlEducation.DataSource = dt;
                ddlEducation.DataValueField = "Eid";
                ddlEducation.DataTextField = "Education_Name";
                ddlEducation.DataBind();
                ddlEducation.Items.Insert(0, "--select--");
            }
        }
        public void Hobby()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("GetHobby", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                checkboxlist1.DataSource = dt;
                checkboxlist1.DataValueField = "Hobby_id";
                checkboxlist1.DataTextField = "Hobby_Name";
                checkboxlist1.DataBind();
            }
        }
        public void Clear()
        {
            txtEmp_Name.Text = "";
            txtEmp_Email.Text = "";
            txtEmp_Address.Text = "";
            txtContact_Number.Text = "";
            txtExperiences.Value = "";
            ddlDepartment.SelectedIndex = 0;
            ddlEducation.SelectedIndex = 0;
            checkboxlist1.ClearSelection();
            rblEmp_Gender.ClearSelection();
            btnInsert.Text = "Submit";
        }
        protected void grvEmployee_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditData")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("GetEmployeeEditRecord", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("Emp_id", e.CommandArgument);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                cmd.ExecuteReader();
                con.Close();

                if (dt.Rows.Count > 0)
                {
                    ViewState["id"] = e.CommandArgument;
                    txtEmp_Name.Text = dt.Rows[0]["Emp_Name"].ToString();
                    txtEmp_Email.Text = dt.Rows[0]["Emp_Email"].ToString();
                    rblEmp_Gender.Text = dt.Rows[0]["Genderid"].ToString();
                    txtEmp_Address.Text = dt.Rows[0]["Emp_Address"].ToString();
                    txtContact_Number.Text = dt.Rows[0]["Contact_Number"].ToString();
                    ddlDepartment.Text = dt.Rows[0]["Departmentid"].ToString();
                    ddlEducation.Text = dt.Rows[0]["Educationid"].ToString();
                    txtExperiences.Value = dt.Rows[0]["Experience"].ToString();

                    string[] list = dt.Rows[0]["Hobby"].ToString().Split(',');
                    checkboxlist1.ClearSelection();
                    for (int i = 0; i < checkboxlist1.Items.Count; i++)
                    {
                        for (int j = 0; j < list.Length; j++)
                        {
                            if (list[j].ToString() == checkboxlist1.Items[i].ToString())
                            {
                                checkboxlist1.Items[i].Selected = true;
                            }
                        }
                    }
                    btnInsert.Text = "Update";
                }
            }
            else if (e.CommandName == "DeleteData")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("DeleteEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DeleteEmp", e.CommandArgument);
                cmd.ExecuteReader();
                con.Close();
                GetEmployee();
            }
        }
        public void GetEmployee()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("GetEmployee_Record", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cmd.ExecuteReader();
            con.Close();
            if (dt.Rows.Count > 0)
            {
                grvEmployee.DataSource = dt;
                grvEmployee.DataBind();
            }
            else
            {
                grvEmployee.DataSource = dt;
                grvEmployee.DataBind();
            }
        }
    }
}