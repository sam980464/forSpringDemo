/*
 * Decompiled with CFR 0_122.
 * 
 * Could not load the following classes:
 *  com.util.DBUtility
 */
package com.project.bean;

import com.util.DBUtility;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

public class Project
implements Serializable {
    private static final long serialVersionUID = 1;
    private String pro_name = null;
    private String id;
    private String c_name = null;
    private String site_addr = null;
    private String site_no_floors = null;
    private String site_no_units = null;
    private String site_details = null;
    private String date = null;
    private String investment_sum = null;
    private String expensed_sum = null;
    private String buyer_payment_sum = null;
    private String refund_sum = null;
    private String word_no;
    private String municipality;
    private String gar_rel;
    private String gar_name;
    private String pro_typ;
    private String Contact1;
    private String Contact2;
    private String Email1;
    private String Email2;

    public void setPro_name(String pro_name) {
        this.pro_name = pro_name;
    }

    public String getPro_name() {
        return this.pro_name;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDate() {
        return this.date;
    }

    public void setC_name(String c_name) {
        this.c_name = c_name;
    }

    public String getC_name() {
        return this.c_name;
    }

    public void setSite_addr(String site_addr) {
        this.site_addr = site_addr;
    }

    public String getSite_addr() {
        return this.site_addr;
    }

    public void setSite_details(String site_details) {
        this.site_details = site_details;
    }

    public String getSite_details() {
        return this.site_details;
    }

    public void setSite_no_floors(String site_no_floors) {
        this.site_no_floors = site_no_floors;
    }

    public String getSite_no_floors() {
        return this.site_no_floors;
    }

    public void setSite_no_units(String site_no_units) {
        this.site_no_units = site_no_units;
    }

    public String getSite_no_units() {
        return this.site_no_units;
    }

    public int getMaxId() {
        int max;
        max = 0;
        Connection con = null;
        PreparedStatement st = null;
        String sql = null;
        ResultSet res = null;
        sql = "SELECT max(project_id) max FROM `project_master` ";
        try {
            con = DBUtility.getConnection();
        }
        catch (NamingException e1) {
            e1.printStackTrace();
        }
        catch (SQLException e1) {
            e1.printStackTrace();
        }
        catch (Exception e1) {
            e1.printStackTrace();
        }
        try {
            try {
                st = con.prepareStatement(sql);
                res = st.executeQuery(sql);
                while (res.next()) {
                    max = res.getInt("max");
                }
            }
            catch (Exception e) {
                e.printStackTrace();
                DBUtility.closeConnection((Connection)con, (PreparedStatement)st, (ResultSet)res);
            }
        }
        finally {
            DBUtility.closeConnection((Connection)con, (PreparedStatement)st, (ResultSet)res);
        }
        return max;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return this.id;
    }

    public void setExpensed_sum(String expensed_sum) {
        this.expensed_sum = expensed_sum;
    }

    public String getExpensed_sum() {
        return this.expensed_sum;
    }

    public void setInvestment_sum(String investment_sum) {
        this.investment_sum = investment_sum;
    }

    public String getInvestment_sum() {
        return this.investment_sum;
    }

    public void setRefund_sum(String refund_sum) {
        this.refund_sum = refund_sum;
    }

    public String getRefund_sum() {
        return this.refund_sum;
    }

    public void setBuyer_payment_sum(String buyer_payment_sum) {
        this.buyer_payment_sum = buyer_payment_sum;
    }

    public String getBuyer_payment_sum() {
        return this.buyer_payment_sum;
    }

    public void setGar_name(String gar_name) {
        this.gar_name = gar_name;
    }

    public String getGar_name() {
        return this.gar_name;
    }

    public void setMunicipality(String municipality) {
        this.municipality = municipality;
    }

    public String getMunicipality() {
        return this.municipality;
    }

    public void setWord_no(String word_no) {
        this.word_no = word_no;
    }

    public String getWord_no() {
        return this.word_no;
    }

    public void setGar_rel(String gar_rel) {
        this.gar_rel = gar_rel;
    }

    public String getGar_rel() {
        return this.gar_rel;
    }

    public void setPro_typ(String pro_typ) {
        this.pro_typ = pro_typ;
    }

    public String getPro_typ() {
        return this.pro_typ;
    }

    public void setEmail1(String email1) {
        this.Email1 = email1;
    }

    public String getEmail1() {
        return this.Email1;
    }

    public void setContact2(String contact2) {
        this.Contact2 = contact2;
    }

    public String getContact2() {
        return this.Contact2;
    }

    public void setContact1(String contact1) {
        this.Contact1 = contact1;
    }

    public String getContact1() {
        return this.Contact1;
    }

    public void setEmail2(String email2) {
        this.Email2 = email2;
    }

    public String getEmail2() {
        return this.Email2;
    }
}
