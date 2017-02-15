package dbtLab3;

import java.sql.*;
import java.util.*;

/**
 * Database is a class that specifies the interface to the movie database. Uses
 * JDBC.
 */
public class Database {

	/**
	 * The database connection.
	 */
	private Connection conn;

	/**
	 * Create the database interface object. Connection to the database is
	 * performed later.
	 */
	public Database() {
		conn = null;
	}

	/**
	 * Open a connection to the database, using the specified user name and
	 * password.
	 */
	public boolean openConnection(String filename) {
		try {
			Class.forName("org.sqlite.JDBC");
			conn = DriverManager.getConnection("jdbc:sqlite:" + filename);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * Close the connection to the database.
	 */
	public void closeConnection() {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Check if the connection to the database has been established
	 * 
	 * @return true if the connection has been established
	 */
	public boolean isConnected() {
		return conn != null;
	}

	/* --- insert own code here --- */
	public boolean login(String username) {
		String sql = "SELECT username FROM Users WHERE username = ?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			return ps.executeQuery().next(); // Finns användarnamnet?
		} catch (SQLException e) {
			return false; // No login atm
		}
	}

	public List<String> getMovies() {
		String sql = "SELECT name FROM Movies";
		List<String> movies = new LinkedList<String>();
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next())
				movies.add(rs.getString("name"));
		} catch (SQLException e) {
			e.printStackTrace();
		} // No movies added
		return movies;
	}

	public List<String> getDates(String movieName) {
		String sql = "SELECT date FROM Performances WHERE movie_name = ?";
		List<String> dates = new LinkedList<String>();
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, movieName);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				dates.add(rs.getString("date"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dates;
	}

	public Performance getPerformance(String movieName, String date) {
		Performance perf = null;
		String sql = "SELECT * FROM Performances WHERE movie_name = ? AND date = ?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, movieName);
			ps.setString(2, date);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				perf = new Performance(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return perf;
	}

	public int makeReservation(String movieName, String date) {
		int nbr = -1;
		String sqlFetchSeats = "SELECT free_seat, theater_name\n" +
					 "FROM Performances\n" +
					 "WHERE movie_name = ?\n" +
					 "AND 	date = ?\n";
		
		String sqlBook = "INSERT INTO Reservations VALUES(NULL,?,?,?,?)";
		
		String sqlUpdateSeats = "UPDATE Performances SET free_seat = free_seat - 1 WHERE movie_name = ? AND date = ?";
		
		try{
			conn.setAutoCommit(false); //transaction start
			PreparedStatement ps = conn.prepareStatement(sqlFetchSeats);
			ps.setString(1, movieName);
			ps.setString(2, date);
			ResultSet rs = ps.executeQuery();
			if(rs.next() && rs.getInt("free_seat") > 0) {
				PreparedStatement bookStmt = conn.prepareStatement(sqlBook, PreparedStatement.RETURN_GENERATED_KEYS);
				bookStmt.setString(1, CurrentUser.instance().getCurrentUserId());
				bookStmt.setString(2, movieName);
				bookStmt.setString(3, date);
				bookStmt.setString(4, rs.getString("theater_name"));
				bookStmt.executeUpdate();
				
				PreparedStatement updateStmt = conn.prepareStatement(sqlUpdateSeats);
				updateStmt.setString(1, movieName);
				updateStmt.setString(2, date);
				updateStmt.executeUpdate();
				ResultSet bookNbr = bookStmt.getGeneratedKeys();
				if(bookNbr.next()) {
					nbr = bookNbr.getInt(1);
				} else {
					conn.rollback();
					nbr = -1;
				}
				conn.commit(); //transaction end ok
			} else {
				conn.rollback(); // rollback release
			}
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {}
			nbr = -1;
		}
		return nbr;
	}
}
