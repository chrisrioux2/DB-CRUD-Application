package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EmployeeDbDAO implements EmployeeDAO {
	private static final String DRIVER_CLASS_NAME = "com.mysql.jdbc.Driver";
	private final static String URL = "jdbc:mysql://localhost:3306/companydb";
	
	@Override
	public Employee getEmployeeByLastName(String query) {
		Employee emp = null;
		String sql = "SELECT id, firstname, lastname, gender, hiredate, salary, department_id, job_id, address, city, state, zipcode FROM employees WHERE lastname LIKE " + "'" + query + "'";
		
		try {
			Class.forName(DRIVER_CLASS_NAME);
			Connection conn = DriverManager.getConnection(URL, "student", "student");
			Statement statement = conn.createStatement();
			ResultSet rs = statement.executeQuery(sql);
			
			if (rs.next()) {
				emp = new Employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12));
			}
			
			rs.close();
			statement.close();
			conn.close();
		}
		catch (Exception e) {
			System.out.println(e);
		}
		
		return emp;
	}
	
	@Override
	public List<Employee> getEmployees() {
		ArrayList<Employee> emps = new ArrayList<>();
		
		try {
			Class.forName(DRIVER_CLASS_NAME);
			Connection conn = DriverManager.getConnection(URL, "student", "student");
			Statement statement = conn.createStatement();
			
			// get all employees in table
			String sql = "SELECT id, firstname, lastname, gender, hiredate, salary, department_id, job_id, address, city, state, zipcode FROM employees ORDER BY lastname";
			ResultSet rs = statement.executeQuery(sql);
			
			// create arraylist of employees in order to display them in drop down on index.jsp
			while (rs.next()) {	
				Employee e = new Employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12));
				emps.add(e);
			}
			
			rs.close();
			statement.close();
			conn.close();
			
		} catch (Exception e) {
			System.err.println(e);		
		}		
		return emps;
	}
	
	@Override
	public Demographics getDemographics() {
		Demographics d = new Demographics();
				
		try {
			Class.forName(DRIVER_CLASS_NAME);
			Connection conn = DriverManager.getConnection(URL, "student", "student");
			Statement statement = conn.createStatement();
			
			// get gender counts in employees table
			String sql = "SELECT gender, COUNT(*) FROM employees GROUP BY gender";
			ResultSet rs = statement.executeQuery(sql);
			
			HashMap<String, Integer> genderCounts = new HashMap<>();
			while (rs.next()) {	
				switch (rs.getString(1)) {
				case "F":
					genderCounts.put("Female", rs.getInt(2));
					break;
				case "M":
					genderCounts.put("Male", rs.getInt(2));
					break;
				default:
					genderCounts.put(rs.getString(1), rs.getInt(2));
					break;
				}
			}
			d.setGenderCount(genderCounts);
			
		} catch (Exception e) {
			System.err.println(e);
		}
		return d;
	}
	
	@Override
	public List<String> getEmployeesHeaders(String query) {
		List<String> empHeaders = new ArrayList<String>();
		String sql = "SELECT id, firstname, lastname, gender, hiredate, salary, department_id, job_id, address, city, state, zipcode FROM employees WHERE lastname LIKE " + "'" + query + "'";

		try {
			Class.forName(DRIVER_CLASS_NAME);
			Connection conn = DriverManager.getConnection(URL, "student", "student");
			Statement statement = conn.createStatement();
			ResultSet rs = statement.executeQuery(sql);
			
			// get headers and add to ListList
			ResultSetMetaData rsmd = rs.getMetaData();
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
				empHeaders.add(rsmd.getColumnName(i));
			}
			
			rs.close();
			statement.close();
			conn.close();
		}
		catch (Exception e) {
			System.err.println(e);
		}
		return empHeaders;
	}
	
	@Override
	public List<List<String>> getEmployeesResults(String query) {
		List<List<String>> empData = new ArrayList<List<String>>();
		String sql = "SELECT id, firstname, lastname, gender, hiredate, salary, department_id, job_id, address, city, state, zipcode FROM employees WHERE lastname LIKE " + "'" + query + "'";
		
		try {
			Class.forName(DRIVER_CLASS_NAME);
			Connection conn = DriverManager.getConnection(URL, "student", "student");
			Statement statement = conn.createStatement();
			ResultSet rs = statement.executeQuery(sql);
			
			// get column values and add to ListList
			ResultSetMetaData rsmd = rs.getMetaData();
			while (rs.next()) {
				List<String> allValues = new ArrayList<String>();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					allValues.add(rs.getString(i));
				}
				empData.add(allValues);
			}
			
			rs.close();
			statement.close();
			conn.close();
		}
		catch (Exception e) {
			System.err.println(e);
		}
		return empData;
	}

}