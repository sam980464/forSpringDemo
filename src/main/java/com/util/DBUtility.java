package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.NamingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DBUtility {
	private static final Logger logger = LoggerFactory
			.getLogger(DBUtility.class);

	public static Connection getConnection() throws NamingException,
			SQLException, Exception {
		logger.info("Inside DBUtility :: getConnection()");
		System.out.println("System log");
		/*
		 * Connection conn = null; DataSource dataSource = null; Context
		 * initContext = null; Context envContext = null; initContext = new
		 * InitialContext(); envContext =
		 * (Context)initContext.lookup("java:/comp/env"); dataSource =
		 * (DataSource) envContext.lookup("jdbc/rtechDB");
		 */
		logger.info("Getting Database Connection");
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/newrtechdb", "root", "root");
		logger.info("Return Database Connection");
		return conn;
	}

	public static void closeConnection(Connection conn,
			PreparedStatement pstmt, ResultSet rs) {
		logger.info("Inside DBUtility :: closeConnection()");
		if (rs != null) {
			rs = null;
		}
		try {
			if (conn != null) {
				conn.close();
				logger.info("Database Connection closed");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("Error :: Closing Database Connection");
			e.printStackTrace();
		}
		try {
			if (pstmt != null) {
				pstmt.close();
				logger.info("PrepareStatement closed");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("Error :: Closing PrepareStatement");
			e.printStackTrace();
		}
	}

	public static void closeConnection(Connection conn, Statement pstmt,
			ResultSet rs) {
		logger.info("Inside DBUtility :: closeConnection()");
		if (rs != null) {
			rs = null;
		}
		try {
			if (conn != null) {
				conn.close();
				logger.info("Database Connection closed");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("Error :: Closing Database Connection");
			e.printStackTrace();
		}
		try {
			if (pstmt != null) {
				pstmt.close();
				logger.info("PrepareStatement closed");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			logger.error("Error :: Closing PrepareStatement");
			e.printStackTrace();
		}
	}
}
