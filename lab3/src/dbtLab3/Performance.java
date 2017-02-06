package dbtLab3;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Performance {
	public final String movieName;
	public final String date;
	public final String theaterName;
	public final int freeSeats;
	
	public Performance(ResultSet rs) throws SQLException {
		movieName = rs.getString("movie_name");
		date = rs.getString("date");
		theaterName = rs.getString("theater_name");
		freeSeats = rs.getInt("free_seat");
	}
}
