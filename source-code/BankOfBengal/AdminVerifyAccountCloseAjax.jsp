<%@ page language="java" contentType="application/x-www-form-urlencoded; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@	page import="java.sql.Connection ,
				     java.sql.DriverManager ,
					 java.sql.PreparedStatement ,
					 java.sql.ResultSet ,
					 java.sql.SQLException"
%>
<%

String qString=request.getParameter("w");
String Q="";
String status="closing";
int SIZE=100;
String[] S=new String[SIZE];
int count=0;

Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String sql=null;
int i=0;
try
{
	
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bobdatabase","root","nirmallya");

	sql="select accountno,cid,email,branchcode from customeraccount where status=?";
	pst=con.prepareStatement(sql);
	pst.setString(1,status);
	rs=pst.executeQuery();
	i=0;
	while(rs.next())
	{
		i=i+1;
		String accountno=rs.getString(1);
		String cid=rs.getString(2);
		String email=rs.getString(3);
		String branchcode=rs.getString(4);

		S[i]=accountno+"|"+cid+"|"+email+"|"+branchcode+"=";
	}
	count=i;
	
	for(int j=1;j<=count;j++)
	{
		Q+=S[j];
		
	}

	if(Q.length()<2)
	{
		Q="x";
	}
	
}
catch(ClassNotFoundException e)
{
	e.printStackTrace();
}
catch(SQLException e)
{
	e.printStackTrace();

}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{

	try
	{
		if(con!=null)
			con.close();

	}
	catch(SQLException e)
	{
		e.printStackTrace();
	}
}

%>
<%=Q %>