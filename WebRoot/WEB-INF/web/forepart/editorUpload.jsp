<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page import="org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper"%>
<%@ page import="org.json.simple.*"%>
<%
        //文件保存目录路径    img_upload是服务器存储上传图片的目录名
        String savePath = request.getSession().getServletContext().getRealPath("/") + "UpLoadfile/";
        //文件保存目录URL
        String saveUrl = request.getContextPath() + "/UpLoadfile/";
        //定义允许上传的文件扩展名
        HashMap<String, String> extMap = new HashMap<String, String>();
        extMap.put("image", "gif,jpg,jpeg,png,bmp");
        extMap.put("flash", "swf,flv");
        extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
        extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");
        //允许最大上传文件大小
        long maxSize = 2048000;
        //Struts2 请求 包装过滤器
        MultiPartRequestWrapper wrapper = (MultiPartRequestWrapper) request;
        //获得上传的文件名
        String fileName = wrapper.getFileNames("imgFile")[0];
        //获得文件过滤器
        File file = wrapper.getFiles("imgFile")[0];
        //得到上传文件的扩展名
        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        //获得文件上传的类型
        String dirName = request.getParameter("dir");
        if (dirName == null) {
                dirName = "image";
        }
        if(!extMap.containsKey(dirName)){
                out.println(getError("目录名不正确。"));
                return;
        }
        //创建文件夹
        savePath += dirName + "/";
        saveUrl += dirName + "/";
        File saveDirFile = new File(savePath);
        if (!saveDirFile.exists()) {
                saveDirFile.mkdirs();
        }
        //检查扩展名
        if (!Arrays.<String> asList(extMap.get(dirName).split(",")).contains(fileExt)) {
                out.println(getError("上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。"));
                return;
        }
        //检查文件大小
        if (file.length() > maxSize) {
                out.println(getError("上传文件大小超过限制，上传的文件不能超过2M。"));
                return;
        } 
        //检查目录
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    String dir = sdf.format(new Date());
        File uploadDir = new File(savePath + dir);
        uploadDir.mkdirs();
        if (!uploadDir.isDirectory()) {
                out.println(getError("上传目录不存在 。"));
                return;
        }
        //检查目录写入权限
        if (!uploadDir.canWrite()) {
                out.println(getError("上传目录没有写入权限。"));
                return;
        }
        //重构上传图片的名称 
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String newImgName = df.format(new Date()) + "_"
                        + new Random().nextInt(1000) + "." + fileExt;
        //设置 KE 中的图片文件地址
        String newFileName = request.getScheme() + "://"
                        + request.getServerName() + ":" + request.getServerPort()
                        + saveUrl + dir + "/" + newImgName;
        byte[] buffer = new byte[1024];
        //获取文件输出流
        FileOutputStream fos = new FileOutputStream(savePath + dir + "/" + newImgName);
        //获取内存中当前文件输入流
        InputStream in = new FileInputStream(file);
        try {
                int num = 0;
                while ((num = in.read(buffer)) > 0) {
                        fos.write(buffer, 0, num);
                }
        } catch (Exception e) {
                e.printStackTrace(System.err);
        } finally {
                in.close();
                fos.close();
        }
        //发送给 KE 
        JSONObject obj = new JSONObject();
        obj.put("error", 0);
        obj.put("url", saveUrl + dir + "/" + newImgName);
        out.println(obj.toJSONString());
%>
<%!private String getError(String message) {
        JSONObject obj = new JSONObject();
        obj.put("error", 1);
        obj.put("message", message);
        return obj.toJSONString();
}
%>