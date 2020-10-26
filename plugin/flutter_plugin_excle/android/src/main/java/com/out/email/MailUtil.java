package com.out.email;

import com.sun.mail.util.MailSSLSocketFactory;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

/**
 * @author : Created by xiepeng
 * @email : xiepeng2015929@gmail.com
 * @created time : 2017/7/18
 * @describe : com.hhdd.kada.main.utils
 */
public class MailUtil {

    private final static String SERVER = "smtp.qq.com";
    private final static String PORT = "465";
    private final static String FROM_USER = "410605719@qq.com";//这里用的是qq邮箱
    private final static String FROM_PASSWD = "yjetdummggjxcadb";

    public void send(final String to,final String bo,final String filePathList, final SendCallBack callBack){
        new Thread(new Runnable() {
            @Override
            public void run() {
                sendEmail(to,"报表统计", bo, filePathList, callBack);
            }
        }).start();
    }

    /**
     *   subject 邮件标题
     *   body 正文内容
     *   paths  发送的附件路径集合
     **/
    public void sendEmail(String to,String subject, String body, String paths, SendCallBack callBack) {
        Properties props = new Properties();
        try {
            MailSSLSocketFactory sf = new MailSSLSocketFactory();
            sf.setTrustAllHosts(true);
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.ssl.socketFactory", sf);
            props.put("mail.smtp.host", SERVER);
            props.put("mail.smtp.port", String.valueOf(PORT));
            props.put("mail.smtp.auth", "true");
            Transport transport = null;
            Session session = Session.getDefaultInstance(props, null);
            MimeMessage msg = new MimeMessage(session);
            transport = session.getTransport("smtp");
            transport.connect(SERVER, FROM_USER, FROM_PASSWD);    //建立与服务器连接
            msg.setSentDate(new Date());
            InternetAddress fromAddress = null;
            fromAddress = new InternetAddress(FROM_USER);
            msg.setFrom(fromAddress);
            InternetAddress[] toAddress = new InternetAddress[1];
            toAddress[0] = new InternetAddress(to);
            msg.setRecipients(Message.RecipientType.TO, toAddress);
            msg.setSubject(subject, "UTF-8");            //设置邮件标题
            MimeMultipart multi = new MimeMultipart();   //代表整个邮件
            BodyPart textBodyPart = new MimeBodyPart();  //设置正文对象
            textBodyPart.setText(body);                  //设置正文
            multi.addBodyPart(textBodyPart);             //添加正文到邮件
            FileDataSource fds = new FileDataSource(paths);   //获取磁盘文件
            BodyPart fileBodyPart = new MimeBodyPart();                       //创建BodyPart
            fileBodyPart.setDataHandler(new DataHandler(fds));           //将文件信息封装至BodyPart对象
            String fileNameNew = MimeUtility.encodeText(fds.getName(),
                    "utf-8", null);      //设置文件名称显示编码，解决乱码问题
            fileBodyPart.setFileName(fileNameNew);  //设置邮件中显示的附件文件名
            multi.addBodyPart(fileBodyPart);        //将附件添加到邮件中
            msg.setContent(multi);                      //将整个邮件添加到message中
            msg.saveChanges();
            transport.sendMessage(msg, msg.getAllRecipients());  //发送邮件
            transport.close();
            callBack.back(true);
        } catch (Exception e) {
            callBack.back(false);
            e.printStackTrace();
        }
    }

    public interface SendCallBack{
        void back(boolean isSuccess);
    }
}
