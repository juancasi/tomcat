package org.software.jaas;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;

import org.software.category.Category;
import org.software.util.DBUtil;
import org.software.util.DataBase;

public class SoftwareLoginModule implements LoginModule {

	private CallbackHandler handler;
	private Subject subject;
	private UserPrincipal userPrincipal;
	private RolePrincipal rolePrincipal;
	private String login;
	private List<String> userGroups;

	@Override
	public void initialize(Subject subject, CallbackHandler callbackHandler,
			Map<String, ?> sharedState, Map<String, ?> options) {

		handler = callbackHandler;
		this.subject = subject;
	}

	
	public String getEncriptedPassword(String plainPassword) {
		String encriptedPassword = "";
		
		MessageDigest md;
		try {
			byte[] bytesOfMessage = plainPassword.getBytes("UTF-8");
			
			md = MessageDigest.getInstance("MD5");

			encriptedPassword = Base64.getEncoder().encodeToString(md.digest(bytesOfMessage));
			
		} catch (Exception e) {
			System.out.println("Error: " + e.toString());
		}
		
		return encriptedPassword;
	}
	
	
	public List<String> getProfiles(String username) {
		List<String> userGroups = new ArrayList<String>();

		DataBase database = new DataBase();
		Connection connection1 = null;
		PreparedStatement preparedStatement1 = null;
		ResultSet rs1 = null;
		
		String sql = "";
		
		try {
			connection1 = database.getConnection("admin");
			
			sql = "select profiles.profile from users, user_profiles, profiles";
			sql += " where users.id = user_profiles.user_id";
			sql += " and user_profiles.profile_id = profiles.id";
			sql += " and username = ?";

			preparedStatement1 = connection1.prepareStatement(sql);
			preparedStatement1.setString(1, username);
			rs1 = preparedStatement1.executeQuery();
						
			while (rs1.next()) {
				String profile = rs1.getString("profile");
				userGroups.add(profile);
			}
		} catch (Exception e) {
			System.out.println("Error: " + e.toString());
		} finally {
			database.closeObject(rs1);
			database.closeObject(preparedStatement1);
			database.closeObject(connection1);
		}
		
		return userGroups;
	}
	
	
	public String getDBPassword(String username) {
		String dbPassword = "";
		
		DataBase database = new DataBase();
		Connection connection1 = null;
		PreparedStatement preparedStatement1 = null;
		ResultSet rs1 = null;
		String sql = "";
		try {
			connection1 = database.getConnection("admin");
			
			sql = "SELECT password from users";
			sql += " where username = ?";
			
			preparedStatement1 = connection1.prepareStatement(sql);
			preparedStatement1.setString(1, username);
			rs1 = preparedStatement1.executeQuery();

			while (rs1.next()) {
				dbPassword = rs1.getString("password");

			}
		} catch (Exception e) {
			System.out.println("Error: " + e.toString());
		}
		finally {
			database.closeObject(rs1);
			database.closeObject(preparedStatement1);
			database.closeObject(connection1);
		}
		
		return dbPassword;
	}
	
	
	@Override
	public boolean login() throws LoginException {

		Callback[] callbacks = new Callback[2];
		callbacks[0] = new NameCallback("login");
		callbacks[1] = new PasswordCallback("password", true);

		try {
			handler.handle(callbacks);
			String name = ((NameCallback) callbacks[0]).getName();
			String password = String.valueOf(((PasswordCallback) callbacks[1])
					.getPassword());

			// Here we validate the credentials against a
			// Database authentication/authorization provider.
			
			String encriptedPassword = getEncriptedPassword(password);
			String dbPassword = getDBPassword(name);
			
			if (name != null && password != null
					&& encriptedPassword.equals(dbPassword)) {
				login = name;
			
				userGroups = getProfiles(name);
			
				return true;
			}
			
			// If credentials are NOT OK we throw a LoginException
			throw new LoginException("Authentication failed");

		} catch (IOException e) {
			throw new LoginException(e.getMessage());
		} catch (UnsupportedCallbackException e) {
			throw new LoginException(e.getMessage());
		}

	}

	@Override
	public boolean commit() throws LoginException {

		userPrincipal = new UserPrincipal(login);
		subject.getPrincipals().add(userPrincipal);

		if (userGroups != null && userGroups.size() > 0) {
			for (String groupName : userGroups) {
				rolePrincipal = new RolePrincipal(groupName);
				subject.getPrincipals().add(rolePrincipal);
			}
		}

		return true;
	}

	@Override
	public boolean abort() throws LoginException {
		return false;
	}

	@Override
	public boolean logout() throws LoginException {
		subject.getPrincipals().remove(userPrincipal);
		subject.getPrincipals().remove(rolePrincipal);
		return true;
	}

}
