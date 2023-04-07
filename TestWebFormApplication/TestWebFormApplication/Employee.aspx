<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee.aspx.cs" Inherits="TestWebFormApplication.Employee" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="1" style="background-color: lightslategrey">
                <tr>
                    <td>Emp_Name:</td>
                    <td>
                        <asp:TextBox ID="txtEmp_Name" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Emp_Email:</td>
                    <td>
                        <asp:TextBox ID="txtEmp_Email" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Contact_Number:</td>
                    <td>
                        <asp:TextBox ID="txtContact_Number" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Emp_Address:</td>
                    <td>
                        <asp:TextBox ID="txtEmp_Address" runat="server"></asp:TextBox></td>
                </tr>
                <tr>

                    <td>Experiences:</td>
                    <td>
                        <input type="number" id="txtExperiences" runat="server" name="Experiences" min="0" max="10" /></td>
                </tr>
                <tr>
                    <td>Gender:</td>
                    <td>
                        <asp:RadioButtonList ID="rblEmp_Gender" runat="server" RepeatDirection="Horizontal"></asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>Department:</td>
                    <td>
                        <asp:DropDownList ID="ddlDepartment" AutoPostBack="true" runat="server" Height="16px" Width="132px"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td>Education:</td>
                    <td>
                        <asp:DropDownList ID="ddlEducation" runat="server" Height="16px" Width="132px"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td>Hobby:</td>
                    <td>
                        <asp:CheckBoxList ID="checkboxlist1" AutoPostBack="True" TextAlign="Right" runat="server"></asp:CheckBoxList></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Button ID="btnInsert" runat="server" Text="Submit" OnClick="btnInsert_Click" /></td>
                </tr>
                <asp:GridView ID="grvEmployee" runat="server" AutoGenerateColumns="false" OnRowCommand="grvEmployee_RowCommand">
                    <Columns>
                        <%--<asp:TemplateField HeaderText ="EmployeeId">
                            <ItemTemplate>
                                <%#Eval("Emp_Id") %>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="EmployeeName">
                            <ItemTemplate>
                                <%#Eval("Emp_Name") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Emp_Email">
                            <ItemTemplate>
                                <%#Eval("Emp_Email") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact_Number">
                            <ItemTemplate>
                                <%#Eval("Contact_Number") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Emp_Address">
                            <ItemTemplate>
                                <%#Eval("Emp_Address") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Experience">
                            <ItemTemplate>
                                <%#Eval("Experience") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Gender">
                            <ItemTemplate>
                                 <%#Eval("Gender_Name")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Department">
                            <ItemTemplate>
                                <%#Eval("Dname") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Education">
                            <ItemTemplate>
                                <%#Eval("Education_Name") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hobby">
                            <ItemTemplate>
                                <%#Eval("Hobby") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                         <asp:TemplateField HeaderText="Edit" >
                            <ItemTemplate >
                               <asp:LinkButton ID="lnkEdit" runat="server" CommandName="EditData" Text="Edit" CommandArgument='<%#Eval("Emp_id") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Delete" >
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteData" Text="Delete" CommandArgument='<%#Eval("Emp_id")%>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </table>
        </div>
    </form>
</body>
</html>
