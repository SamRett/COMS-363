package coms363;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.sql.*;

import javax.swing.*;
import javax.swing.border.LineBorder;

/**
 * Author: ComS 363 Teaching Staff Examples of static queries, parameterized
 * queries, and transactions
 * 
 * Author: Samuel Rettig Netid: sgrettig
 * 
 * I removed a fewv bits of java code that were simply taking up space Updates
 * to file otherwise: mostFollowedUsers, findMostPopularUsers,insertUser and
 * deleteUser method as well as input in the main
 * 
 * 
 */
public class tweetsdb {
	/**
	 * asking for a username and password to access the database.
	 * 
	 * @return the array with the username as the first element and password as the
	 *         second element
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
	 * @param conn  connection parameter
	 * @param users amount of users passed back
	 * @throws party string passed to identify party
	 * 
	 *               Sends query to SQL which utilizes the procedure to give output
	 *               back regarding the most followed users
	 * 
	 */

	private static void mostFollowedusers(Connection conn, Integer users, String party) throws SQLException {
		if (party == null || users == null || conn == null)
			throw new NullPointerException();

		// creating call to SQL
		CallableStatement cmst = conn.prepareCall("{CALL mostFollowedUsers(?,?)}"); // call the procedure

		// setting call parameters
		cmst.setInt(1, users);
		cmst.setString(2, party);

		String show = "";
		ResultSet r = cmst.executeQuery();
		ResultSetMetaData meta;
		meta = r.getMetaData();

		// iterate through each item in the returned result
		while (r.next()) {
			// i+1 indicates the position of the column to obtain the output
			// getString(1) means getting the value of the column 1.
			// concatenate the columns in each row
			for (int i = 0; i < meta.getColumnCount(); i++) {
				show += r.getString(i + 1) + " ";
			}
			show += "\n";
		}
		System.out.println(show);
		// show the dialog box with the returned result by DBMS
		JOptionPane.showMessageDialog(null, show);

		// release the resultSet resource
		r.close();
		// release the CallableStatement resource
		cmst.close();

	}

	/**
	 * @param conn connection parameter
	 * @param k    how much data requested
	 * @throws year what year you want
	 * 
	 *              Sends query to SQL which utilizes the procedure to give output
	 *              back regarding the most popular Hash-tags
	 * 
	 */

	private static void findMostPopularHashTags(Connection conn, Integer k, Integer year) throws SQLException {
		if (year == null || k == null || conn == null)
			throw new NullPointerException();

		// creating call to SQL
		CallableStatement cmst = conn.prepareCall("{CALL findPopularHashTags(?,?)}"); // call the procedure

		// setting call parameters
		cmst.setInt(1, k);
		cmst.setInt(2, year);

		String show = "";
		ResultSet r = cmst.executeQuery();
		ResultSetMetaData meta;
		meta = r.getMetaData();

		// iterate through each item in the returned result
		while (r.next()) {
			// i+1 indicates the position of the column to obtain the output
			// getString(1) means getting the value of the column 1.
			// concatenate the columns in each row
			for (int i = 0; i < meta.getColumnCount(); i++) {
				show += r.getString(i + 1) + " ";
			}
			show += "\n";
		}
		System.out.println(show);
		// show the dialog box with the returned result by DBMS

		// System.out.println(r);
		JOptionPane.showMessageDialog(null, show);

		// release the resultSet resource
		r.close();
		// release the CallableStatement resource
		cmst.close();

	}

	/**
	 * 
	 * @param conn          connection attribute
	 * @param screen_names  screen_name parameter passed to SQL
	 * @param user_names    user name parameter passed to SQL
	 * @param categorys     category parameter passed to SQL
	 * @param sub_categorys sub category parameter passed to SQL
	 * @param states        states parameter passed to SQL
	 * @param numFollowss   number of following people
	 * @param numFollowings number of following people
	 * @throws SQLException sql exception
	 * 
	 *                      Inserts user into database
	 */
	private static void insertUser(Connection conn, String screen_names, String user_names, String categorys,
			String sub_categorys, String states, Integer numFollowss, Integer numFollowings) throws SQLException {
		if (screen_names == null || conn == null || numFollowss == null || numFollowings == null)
			throw new NullPointerException();

		// creating call to SQL
		CallableStatement cmst = conn.prepareCall("{CALL insertUser(?,?,?,?,?,?,?,?)}"); // call the procedure

		// setting call parameters
		cmst.setString(1, screen_names);
		cmst.setString(2, user_names);
		cmst.setString(3, categorys);
		cmst.setString(4, sub_categorys);
		cmst.setString(5, states);
		cmst.setInt(6, numFollowss);
		cmst.setInt(7, numFollowings);
		cmst.registerOutParameter(8, Types.INTEGER);

//		System.out.println(cmst);

		// executing operation
		cmst.executeUpdate();

		JOptionPane.showMessageDialog(null, cmst.getInt(8));

		cmst.close();

	}

	/**
	 * 
	 * @param conn  connection parameter
	 * @param input user that is to be deleted
	 * @throws SQLException exception if called
	 * 
	 *                      Deletes user from database
	 */
	private static void deleteUser(Connection conn, String input) throws SQLException {
		if (input == null || conn == null)
			throw new NullPointerException();

		// creating call to SQL
		CallableStatement cmst = conn.prepareCall("{CALL deleteUser(?,?)}"); // call the procedure

		// setting call parameters
		cmst.setString(1, input);
		cmst.registerOutParameter(2, Types.INTEGER);

		// executing operation

		cmst.executeUpdate();

		JOptionPane.showMessageDialog(null, cmst.getInt(2));

		// release the CallableStatement resource
		cmst.close();

	}

	public static void main(String[] args) {

		String users;
		String party = "";
		Integer num = 0;
		Integer k = 0;
		/*
		 * useSSL=false means plain text allowed
		 * 
		 * String dbServer = "jdbc:mysql://localhost:3306/fooddb?useSSL=false";
		 * localhost is same as 127.0.0.1
		 * 
		 * 
		 * Change localhost if you want to use a DBMS on a different computer. Change
		 * the port number from 3306 if you install your DBMS server on a different port
		 * number. Change fooddb_ex to the database name you want to use. useSSL=true;
		 * data are encrypted when sending between DBMS and this program
		 * 
		 * 
		 */

		String dbServer = "jdbc:mysql://localhost:3306/practice?useSSL=true";
		String userName = "coms363";
		String password = "363F2022";

		// show the login dialog box
		// String result[] = loginDialog();

		// only use this for debugging
		// String result[] = {"coms363", "XXXX"};

		// pass the dialog box to get the result set.

		userName = "coms363";
		password = "363F2022";

		Connection conn = null;

		// Statement class is for static SQL queries.
		Statement stmt = null;

//		if (result[0] == null || result[1] == null) {
//			System.out.println("Terminating: No username nor password is given");
//			return;
//		}
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
			String instruction = "Enter a: to use the findPopularHashTags procedure" + "\n"
					+ "Enter b: this does the mostFollowedUsers procedure" + "\n"
					+ "Enter c: This calls the insertUser procedure" + "\n"
					+ "Enter d: remove a user, please input who " + "\n" + "Enter e to end program" + "\n";

			while (true) {
				// show the above menu options
				option = JOptionPane.showInputDialog(instruction);
				// Reset the autocommit to commit per SQL statement
				// This is for the other SQL queries to be one independently treated as one
				// unit.
				// set the default isolation level to the default.

				conn.setAutoCommit(true);
				conn.setTransactionIsolation(Connection.TRANSACTION_REPEATABLE_READ);

				if (option.equals("a")) {
					users = JOptionPane.showInputDialog("Please enter amount of desired output");
					if (!users.isEmpty()) {
						k = Integer.parseInt(users);
					}
					party = JOptionPane.showInputDialog("Please enter what year you desire");
					if (!users.isEmpty()) {
						num = Integer.parseInt(party);
					}
					findMostPopularHashTags(conn, k, num);
				} else if (option.equals("b")) {
					users = JOptionPane.showInputDialog("Please enter amount of users");
					if (!users.isEmpty()) {
						num = Integer.parseInt(users);
					}
					party = JOptionPane.showInputDialog("Please enter the party name");
					if (party.isEmpty()) {
						party = null;
					}
					mostFollowedusers(conn, num, party);
				} else if (option.equals("c")) {
					// input
					String numFollows_input;
					String numFollowing_input;

					// storing input

					String screen_name = null;
					String user_name = null;
					String category = null;
					String sub_category = null;
					String state = null;
					Integer numFollows = null;
					Integer numFollowing = null;

					screen_name = JOptionPane.showInputDialog("Please enter screen name");
					if (screen_name.isEmpty()) {
						screen_name = null;
					}
					user_name = JOptionPane.showInputDialog("Please enter username");
					if (user_name.isEmpty()) {
						user_name = null;
					}
					category = JOptionPane.showInputDialog("Please enter category");
					if (category.isEmpty()) {
						category = null;
					}
					sub_category = JOptionPane.showInputDialog("Please enter sub-category");
					if (sub_category.isEmpty()) {
						sub_category = null;
					}
					state = JOptionPane.showInputDialog("Please enter the state");
					if (state.isEmpty()) {
						state = null;
					}
					numFollows_input = JOptionPane.showInputDialog("Please enter the amount of followers");
					if (!numFollows_input.isEmpty()) {
						numFollows = Integer.parseInt(numFollows_input);
					}
					numFollowing_input = JOptionPane.showInputDialog("Please enter the amount of following accounts");
					if (!numFollowing_input.isEmpty()) {
						numFollowing = Integer.parseInt(numFollowing_input);
					}

//					System.out.println(screen_name);
//					System.out.println(user_name);
//					System.out.println(category);
//					System.out.println(sub_category);
//					System.out.println(state);
//					System.out.println(numFollows);
//					System.out.println(numFollowing);
//					System.out.println(success);

					insertUser(conn, screen_name, user_name, category, sub_category, state, numFollows, numFollowing);

				} else if (option.equals("d")) {
					String input = "";

					input = JOptionPane.showInputDialog("Please enter screen name of user you wish to delete");
					if (input.isEmpty()) {
						input = null;
					}
					System.out.println(input);

					deleteUser(conn, input);
				}


				else {
					break;
				}
			}
			// close the statement
			if (stmt != null)
				stmt.close();
			// close the connection
			if (conn != null)
				conn.close();
		} catch (Exception e) {

			System.out.println("Program terminates due to errors or user cancelation");
			// e.printStackTrace(); // enable this to see the debugging errors
		}
	}

}
