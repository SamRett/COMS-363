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
 */
public class tweetsdb {
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
	
	private static void findPopularHashTags(Connection conn, String kVal, String year) {
		
		if (conn==null || kVal==null || year == null) throw new NullPointerException();
		
		try {
			
			conn.setAutoCommit(false);
			conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

			CallableStatement cstmt =conn.prepareCall("{CALL findPopularHashtags(?,?)}"); //call the procedure
			
			cstmt.setInt(1, Integer.parseInt(kVal)); 
			cstmt.setInt(2, Integer.parseInt(year));
			
			ResultSet rs = cstmt.executeQuery();
			ResultSetMetaData rsMetaData = rs.getMetaData();
			
			String toShow = "";
			int count = 0;
			
			// iterate through each item in the returned result
			while (rs.next()) {
				// concatenate the columns in each row
				for(int i = 0; i < rsMetaData.getColumnCount(); i++) {
					toShow += rs.getString(i + 1) + ", ";
				}
				toShow += "\n";
				count++;
			}
			if (count==0) toShow += "No retured results";
			// show the dialog box with the returned result by DBMS
			JOptionPane.showMessageDialog(null, toShow);
			rs.close();
			conn.commit();
			cstmt.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	
	private static void findMostFollowedUsers(Connection conn, String kVal, String partyName) {
		
		if (conn==null || kVal==null || partyName == null) throw new NullPointerException();
		
		try {
			
			conn.setAutoCommit(false);
			conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

			CallableStatement cstmt =conn.prepareCall("{CALL mostFollowedUsers(?,?)}"); //call the procedure
			
			cstmt.setInt(1, Integer.parseInt(kVal)); 
			cstmt.setString(2, partyName);
			
			ResultSet rs = cstmt.executeQuery();
			ResultSetMetaData rsMetaData = rs.getMetaData();
			
			String toShow = "";
			int count = 0;
			
			// iterate through each item in the returned result
			while (rs.next()) {
				// concatenate the columns in each row
				for(int i = 0; i < rsMetaData.getColumnCount(); i++) {
					toShow += rs.getString(i + 1) + ", ";
				}
				toShow += "\n";
				count++;
			}
			if (count==0) toShow += "No retured results";
			// show the dialog box with the returned result by DBMS
			JOptionPane.showMessageDialog(null, toShow);
			rs.close();
			conn.commit();
			cstmt.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	private static void insertUser(Connection conn, String screenName, String userName, String category, String subCategory, String state, String numFollowers, String numFollowing) {
		
		if (conn==null || screenName==null) throw new NullPointerException();
		
		try {
			
			conn.setAutoCommit(false);
			conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

			CallableStatement cstmt =conn.prepareCall("{CALL insertUser(?,?,?,?,?,?,?,?)}"); //call the procedure
			
			cstmt.setString(1, screenName); 
			cstmt.setString(2, userName);
			cstmt.setString(3, category);
			cstmt.setString(4, subCategory);
			cstmt.setString(5, state);
			cstmt.setInt(6, numFollowers.equals("") ? 0 : Integer.parseInt(numFollowers));
			cstmt.setInt(7, numFollowing.equals("") ? 0 : Integer.parseInt(numFollowing));
			cstmt.registerOutParameter(8,Types.INTEGER); //output parameter
			
			cstmt.executeUpdate();
			
			int success = cstmt.getInt(8);
			System.out.println("status \n" + success);
			
			if (success == 1) {
				String message = "Successful insertion of " + screenName;
				System.out.println(message);
				conn.commit();
				JOptionPane.showMessageDialog(null, message);
			}else {
				String message = "Failed insertion of " + screenName;
				System.out.println(message);
				System.out.println("Check for duplicates screen name or the existence of the insertUser stored procedure");
				JOptionPane.showMessageDialog(null, message);
			}
			cstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	
	private static void deleteUser(Connection conn, String screenName) {
		
		if (conn==null || screenName == null) throw new NullPointerException();
		
		// 0 means false for this variable success
		Integer success = 0;
		try {
			
			conn.setAutoCommit(false);
			conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

			CallableStatement cstmt =conn.prepareCall("{CALL deleteUser(?,?)}"); //call the procedure
			
			cstmt.setString(1, screenName);   //input parameter is the give month
			cstmt.registerOutParameter(2,Types.INTEGER); //output parameter
	
			cstmt.executeUpdate();
			
			success = cstmt.getInt(2);
			System.out.println("status \n" + success);
			
			if (success == 0) {
				String message = "Successful deletion of " + screenName;
				System.out.println(message);
				JOptionPane.showMessageDialog(null, message);
				conn.commit();
			}else {
				String message = "Failed deletion of " + screenName;
				System.out.println("Check for existence of screen name or the existence of the deleteUser stored procedure");
				JOptionPane.showMessageDialog(null, message);
			}
			cstmt.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
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
		
		String dbServer = "jdbc:mysql://localhost:3306/practice?useSSL=true";
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

			// Menu options
			String option = "";
			String instruction = "Enter a: Find popular hashtags." + "\n"
					+ "Enter b: Find most followed users." + "\n"
					+ "Enter c: Insert user." + "\n"
					+ "Enter d: Delete user" + "\n"
					+ "Enter e or other key to Quit Program";

			while (true) {
				// show the above menu options
				option = JOptionPane.showInputDialog(instruction);
				// Reset the autocommit to commit per SQL statement
				// This is for the other SQL queries to be one independently treated as one unit.
				// set the default isolation level to the default.
				
				conn.setAutoCommit(true);
				conn.setTransactionIsolation(Connection.TRANSACTION_REPEATABLE_READ);
				
				String inputErrorMsg = "";
				if (option.equals("a")) {
					String kVal=JOptionPane.showInputDialog("Enter k:");
					String year=JOptionPane.showInputDialog("Enter year:");
					if (kVal.equals("")) {
						inputErrorMsg = "Input error: k cannot be null";
						System.out.println(inputErrorMsg);
						JOptionPane.showMessageDialog(null, inputErrorMsg);
						continue;
					}
					if (year.equals("")) {
						inputErrorMsg = "Input error: year cannot be null";
						System.out.println(inputErrorMsg);
						JOptionPane.showMessageDialog(null, inputErrorMsg);
						continue;
					}
					findPopularHashTags(conn, kVal, year);
					
				} else if (option.equals("b")) {
					String kVal=JOptionPane.showInputDialog("Enter k:");
					String partyName=JOptionPane.showInputDialog("Enter party name:");
					if (kVal.equals("")) {
						inputErrorMsg = "Input error: k cannot be null";
						JOptionPane.showMessageDialog(null, inputErrorMsg);
						System.out.println(inputErrorMsg);
						continue;
					}
					if (partyName.equals("")) {
						inputErrorMsg = "Input error: party name cannot be null";
						JOptionPane.showMessageDialog(null, inputErrorMsg);
						System.out.println(inputErrorMsg);
						continue;
					}
					findMostFollowedUsers(conn, kVal, partyName);
				} else if (option.equals("c")) {
					String screenName = JOptionPane.showInputDialog("Enter screen name:");
					String username = JOptionPane.showInputDialog("Enter user name:");
					String category = JOptionPane.showInputDialog("Enter category:");
					String subCategory = JOptionPane.showInputDialog("Enter subcategory:");
					String state = JOptionPane.showInputDialog("Enter state:");
					String numFollowers = JOptionPane.showInputDialog("Enter the number of followers:");
					String numFollowing = JOptionPane.showInputDialog("Enter the number of followings:");
					if (screenName.equals("")) {
						inputErrorMsg = "Input error: screen name cannot be null";
						JOptionPane.showMessageDialog(null, inputErrorMsg);
						System.out.println(inputErrorMsg);
						continue;
					}
					insertUser(conn, screenName, username, category, subCategory, state, numFollowers, numFollowing);
				} else if (option.equals("d")) {
					String screenName = JOptionPane.showInputDialog("Enter screen name:");
					if (screenName.equals("")) {
						inputErrorMsg = "Input error: screen name cannot be null";
						JOptionPane.showMessageDialog(null, inputErrorMsg);
						System.out.println(inputErrorMsg);continue;
					}
					deleteUser(conn, screenName);
				}else {
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
