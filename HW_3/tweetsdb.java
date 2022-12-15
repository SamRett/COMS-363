package coms363;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.sql.*;

import javax.swing.*;
import javax.swing.border.LineBorder;
/**
 * Author: ComS 363 Teaching Staff
 * Examples of static queries, parameterized queries, and 
 * transactions
 * 
 * 
 * @author: Samuel Rettig
 * changed:
 */
public class JDBCTransactionTester {
	/**
	 * 	asking for a username and password to access the database.
	 *  @return the array with the username as the first element and password as the second element
	 */
	public static String[] loginDialog() {
	
		
		String result[] = new String[2];
		JPanel panel = new JPanel(new GridBagLayout());
		GridBagConstraints cs = new GridBagConstraints();

		cs.fill = GridBagConstraints.HORIZONTAL;

		JLabel lbUsername = new JLabel("Username: ");
		cs.gridx = 0;
		cs.gridy = 0;
		cs.gridwidth = 1;
		panel.add(lbUsername, cs);

		JTextField tfUsername = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 0;
		cs.gridwidth = 2;
		panel.add(tfUsername, cs);

		JLabel lbPassword = new JLabel("Password: ");
		cs.gridx = 0;
		cs.gridy = 1;
		cs.gridwidth = 1;
		panel.add(lbPassword, cs);

		JPasswordField pfPassword = new JPasswordField(20);
		cs.gridx = 1;
		cs.gridy = 1;
		cs.gridwidth = 2;
		panel.add(pfPassword, cs);
		panel.setBorder(new LineBorder(Color.GRAY));

		String[] options = new String[] { "OK", "Cancel" };
		int ioption = JOptionPane.showOptionDialog(null, panel, "Login", JOptionPane.OK_OPTION,
				JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
		
		// store the username in the first element of the array.
		// store the password in the second element of the same array.
		
		if (ioption == 0) // pressing the OK button
		{
			result[0] = tfUsername.getText();
			result[1] = new String(pfPassword.getPassword());
		}
		return result;
	}

	/**
	 * @param stmt
	 * @param sqlQuery
	 * @throws SQLException
	 * 
	 *  Run the given static SQL query. 
	 *  
	 */
	
	private static void runQuery(Statement stmt, String sqlQuery) throws SQLException {
		// ResultSet is used to store the data returned by DBMS when issuing a static query
		
		ResultSet rs;
		
		// ResultSetMetaData is used to find meta data about the data returned
		ResultSetMetaData rsMetaData;
		String toShow;
		
		
		// Send the SQL query to the DBMS
		rs = stmt.executeQuery(sqlQuery);
		
		// get information about the returned result such as the number of columns
		rsMetaData = rs.getMetaData();
		System.out.println(sqlQuery);
		
		// toShow is to build the string to output
		toShow = "";
		
		// iterate through each item in the returned result
		while (rs.next()) {
			// i+1 indicates the position of the column to obtain the output
			// getString(1) means getting the value of the column 1.
			// concatenate the columns in each row
			for (int i = 0; i < rsMetaData.getColumnCount(); i++) {
			
				toShow += rs.getString(i + 1) + ", ";
			}
			toShow += "\n";
		}
		// show the dialog box with the returned result by DBMS
		JOptionPane.showMessageDialog(null, toShow);
		
		// release the resultSet resource
		rs.close();
	}
	
	/**
	 * Show an example of a transaction
	 * @param conn Valid database connection
	 * 		  fname: Name of a food to check
	 * 
	 * Description: 
	 *      Insert a new food into the food table, giving a new fid value automatically to be 
	 *      the largest fid value in the table + 1.
	 * 
	 */
	private static void insertFood(Connection conn, String fname) {
		
		if (conn==null || fname==null) throw new NullPointerException();
		try {
			/* we want to make sure that all SQL statements for insertion 
			   of a new food are considered as one unit.
			   That is all SQL statements between the commit and previous commit 
			   get stored permanently in the DBMS or  all the SQL statements 
			   in the same transaction are rolled back.
			
			   By default, the isolation level is TRANSACTION_REPEATABLE_READ
			   By default, each SQL statement is one transaction
			
			   conn.setAutoCommit(false) is to 
			   specify what SQL statements are in the same transaction 
			   by a developer.
			   Several SQL statements can be put in one transaction.
			*/ 
			
			conn.setAutoCommit(false);
			// full protection against interference from other transaction
			// prevent dirty read
			// prevent unrepeatable reads
			// prevent phantom reads
			conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
			
			// create a static statement
			Statement stmt = conn.createStatement();
			ResultSet rs;
			int id=0;
			
			// get the maximum id from the food table
			rs = stmt.executeQuery("select max(fid) from food");
			while (rs.next()) {
				// 1 indicates the position of the returned result we want to get
				// since the first and only column is an integer, we need to use getInt().
				// for other data types, use the appropriate get method.
				id = rs.getInt(1);
			}
			rs.close();
			stmt.close();
			// once done, close the DBMS resources
			
			/* Example of a parameterized SQL query, which has ? in the query. Each ? is to be 
			  replaced by a value obtained from a user
			*/
			PreparedStatement inststmt = conn.prepareStatement(
	                " insert into food (fid,fname) values(?,?) ");
			
			// Set the first ?  to have the new food id
			inststmt.setInt(1, id+1);
			// Set the second ? to have the food name
			inststmt.setString(2, fname);
			
			// tell DBMS to insert the food into the table
			// get the number of rows affected in return. The number of row should be one 
			// for a successful update.
			int rowcount = inststmt.executeUpdate();
			
			// show how many rows are impacted, should be one row if 
			// successful
			// if not successful, SQLException occurs.
			System.out.println("Number of rows updated:" + rowcount);
			inststmt.close();
			
			// Tell DBMS to make sure all the changes you made from 
			// the prior commit is saved to the database
			conn.commit();
			
			
		} catch (SQLException e) {
			System.out.println("Failed to insert the food " + fname);
		}

	}
	
	/* this example shows how to use a parameterized SQL query
	 @param conn: Valid connection to a dbms
	        iname: the name of the ingredient to check
	*/
	
	private static void checkIngredient(Connection conn, String iname) {
		
		if (conn==null || iname==null) throw new NullPointerException();
		try {
			
			ResultSet rs =null;
			String toShow ="";
			
			/* Another example of a parameterized query
			   Notice the use of PreparedStatement instead of Statement 
			   used in a static query.
			 * 
			 */
			PreparedStatement lstmt = conn.prepareStatement(
	           "select count(*) from ingredient where iname= ?");
			
			// clear previous parameter values
			lstmt.clearParameters();
			
			// Replace the first question mark with the value of iname
			lstmt.setString(1, iname);
			
			// execute the query; this is where the query is submitted to the DBMS backend
			rs=lstmt.executeQuery();
			
			// advance the cursor to the first record; we know that there is only one record to 
			// obtain the result
			rs.next();
			int count = rs.getInt(1);
			
			
			System.out.println("count=" + count);
			
			if (count > 0) {
				toShow = "The ingredient " + iname + " exists";
			}
			else toShow = "The ingredient " + iname + " does not exist";
			
			JOptionPane.showMessageDialog(null, toShow);
			// release resources
			lstmt.close();
			rs.close();
			
		} catch (SQLException e) {}

	}
	
	/* this example shows how to use a parameterized SQL query
	 @param conn: Valid connection to a dbms
	        fname: the name of the food to add
	  Example to show how to call a stored procedure.
	  Assume that the stored procedure exists
	*/
	
	private static void callStoredProcedure(Connection conn, String fname) {
		
		if (conn==null || fname==null) throw new NullPointerException();
		
		// 0 means false for this variable success
		Integer success = 0;
		try {
			
			conn.setAutoCommit(false);
			conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

			CallableStatement cstmt =conn.prepareCall("{CALL insertFood(?,?)}"); //call the procedure
			
			cstmt.setString(1, fname);   //input parameter is the give month
			cstmt.registerOutParameter(2,Types.INTEGER); //output parameter
	
			cstmt.executeUpdate();
			
			success = cstmt.getInt(2);
			System.out.println("status \n" + success);
			
			if (success == 1) {
				System.out.println("Successful insertion of " + fname );
				conn.commit();
			}
			cstmt.close();
			
		} catch (SQLException e) {
			
			System.out.println("Failed insertion of " + fname );
			System.out.println("Check for duplicates food name or the existence of the insertFood stored procedure");
			
			// e.printStackTrace();
			// used to obtain debugging error
			// 
			
		} 

	}

	public static void main(String[] args) {
		/*
			useSSL=false means plain text allowed
			
			String dbServer = "jdbc:mysql://localhost:3306/fooddb?useSSL=false";
			localhost is same as 127.0.0.1
			
			
			Change localhost if you want to use a DBMS on a different computer.
			Change the port number from 3306 if you install your DBMS server on a different port number.
			Change fooddb_ex to the database name you want to use.
			useSSL=true; data are encrypted when sending between DBMS and this program
			
		 * 
		 */
		
		String dbServer = "jdbc:mysql://localhost:3306/fooddb_ex?useSSL=true";
		String userName = "";
		String password = "";

		// show the login dialog box
		String result[] = loginDialog();
		
		// only use this for debugging
		// String result[] = {"coms363", "XXXX"};
		
		// pass the dialog box to get the result set.
		
		userName = result[0];
		password = result[1];

		Connection conn=null;
		
		// Statement class is for static SQL queries.
		Statement stmt=null;
		
		
		if (result[0]==null || result[1]==null) {
			System.out.println("Terminating: No username nor password is given");
			return;
		}
		try {
			// load JDBC driver
			// must be in the try-catch-block
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// establish a database connection with the given userName and password
			conn = DriverManager.getConnection(dbServer, userName, password);
			
			// create a static statement
			
			stmt = conn.createStatement();
			String sqlQuery = "";

			// Menu options
			String option = "";
			String instruction = "Enter 1: Find all food with chicken as ingredient." + "\n"
					+ "Enter 2: For each food, list food name, total number of ingredients, and total amount of ingredients (gram)."
					+ "\n" + "Enter 3: Find all food without green onion as ingredient." + "\n"
					+ "Enter 4: Find all ingredients and amount of each ingredient of BBQ Chicken" + "\n"
					+ "Enter 5: Enter new food" + "\n"
					+ "Enter 6: Check whether an ingredient exists" + "\n"
					+ "Enter 7: Insert a new food using the stored procedure insertFood" + "\n"
					+ "Enter 8 or other key to Quit Program";

			while (true) {
				// show the above menu options
				option = JOptionPane.showInputDialog(instruction);
				// Reset the autocommit to commit per SQL statement
				// This is for the other SQL queries to be one independently treated as one unit.
				// set the default isolation level to the default.
				
				conn.setAutoCommit(true);
				conn.setTransactionIsolation(Connection.TRANSACTION_REPEATABLE_READ);
				
				if (option.equals("1")) {
					sqlQuery = "select distinct f.fname from food f inner join recipe r on r.fid = f.fid inner join ingredient i on i.iid = r.iid where i.iname = 'Chicken'";
					runQuery(stmt, sqlQuery);
				} else if (option.equals("2")) {
					sqlQuery = "select f.fname, count(r.iid), sum(r.amount) from food f inner join recipe r on r.fid = f.fid inner join ingredient i on i.iid = r.iid group by f.fname";
					runQuery(stmt, sqlQuery);
				} else if (option.equals("3")) {
					sqlQuery = "select f.fname from food f where f.fid not in (select r.fid from recipe r inner join ingredient i on i.iid = r.iid where i.iname = 'Green Onion');";
					runQuery(stmt, sqlQuery);
				} else if (option.equals("4")) {
					sqlQuery = "select i.iname, r.amount from food f inner join recipe r on r.fid = f.fid inner join ingredient i on i.iid = r.iid where f.fname = 'BBQ Chicken'";
					runQuery(stmt, sqlQuery);
				} else if (option.equals("5")) {
					String fname=JOptionPane.showInputDialog("Enter food name:");
					insertFood(conn, fname);
				} else if (option.equals("6")) {
					String iname=JOptionPane.showInputDialog("Enter exact name of the ingredient to check:");
					checkIngredient(conn, iname);
				} else if (option.equals("7")) {
					String fname=JOptionPane.showInputDialog("Enter food name:");
					callStoredProcedure(conn, fname);
				}
				else {
					break;
				}
			}
			// close the statement
			if (stmt != null) stmt.close();
			// close the connection
			if (conn != null) conn.close();
		} catch (Exception e) {
			
			System.out.println("Program terminates due to errors or user cancelation");
			// e.printStackTrace(); // enable this to see the debugging errors
		}
	}

}
