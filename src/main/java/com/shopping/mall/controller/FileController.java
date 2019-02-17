package com.shopping.mall.controller;

import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.*;
import java.util.UUID;

/**
 * @author yuyufeng
 * @date 2018/11/29.
 */
@Controller
public class FileController {

    /**
     * 上传图片
     *
     * @param file
     * @throws IOException
     */
	

	
    @RequestMapping(value = "/file/upload", method = RequestMethod.POST)
    @ResponseBody
    public String upload(@RequestParam("file") MultipartFile file, HttpSession session)  {
        String fileName = UUID.randomUUID().toString();
        String ext = StringUtils.getFilenameExtension(file.getOriginalFilename());
        if (StringUtils.isEmpty(ext)) {
            ext = "png";
        }
        
        String filePath = "upload/" + fileName + "." + ext;
        //System.out.println("会话路径： " + session.getServletContext().getContextPath());
        String uploadSessionPath = session.getServletContext().getRealPath("/");

        System.out.println("上传路径： " + uploadSessionPath);
        try {
			file.transferTo(new File(uploadSessionPath + filePath));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("文件传输失败");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("文件传输失败");
		}
       
        return filePath;
    }

    
    @RequestMapping("/act/worldcup_schedule_time/imgdownload")
    @ResponseBody
    public String scheduleDownload(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        response.setCharacterEncoding("UTF-8");
        String downLoadName = "worldcup.jpg";
        InputStream input = null;
//        try {
//            request.setCharacterEncoding("UTF-8");
//            //获取文件的路径
//            String url = session.getServletContext().getRealPath("/") + "resources\\images\\act\\worldcup_merge\\worldcup720.png";
//            String url = session.getServletContext().getRealPath("/") + "resources/images/act/worldcup_merge/worldcup720.png";
//            System.out.println(url);
//            File file = new File(url);
// 
// 
//            input = FileUtils.openInputStream(file);
//            byte[] data = IOUtils.toByteArray(input);
// 
// 
//            //System.out.println("文件名:"+downLoadName);
//            response.reset();
//            //设置响应的报头信息(中文问题解决办法)
//            response.setHeader("content-disposition", "attachment;fileName=" + URLEncoder.encode(downLoadName, "UTF-8"));
//            response.addHeader("Content-Length", "" + data.length);
//            response.setContentType("image/png; charset=UTF-8");
// 
// 
//            IOUtils.write(data, response.getOutputStream());
//        } catch (Exception e) {
//            logger.error("下载图片出错");
//            if (input != null) {
//                IOUtils.closeQuietly(input);
//            }
//        }
        return null;
    }
    
    @RequestMapping(value = "/cancelupload", method = RequestMethod.POST)
    public String cancelupload(@RequestParam("file") MultipartFile file) throws IOException {
        String fileName = UUID.randomUUID().toString();
        String ext = StringUtils.getFilenameExtension(file.getOriginalFilename());
        if (StringUtils.isEmpty(ext)) {
            ext = "png";
        }
        file.transferTo(new File("f://test/" + fileName + "." + ext));
        return "asfaf";
    }

    /**
     * 文件流
     *
     * @param response
     * @return
     */
    @RequestMapping(value = "stream/{fileName}/{ext}", method = RequestMethod.GET)
    public String thumbnail(HttpServletResponse response, @PathVariable("fileName") String fileName, @PathVariable("ext") String ext) {
        try {
            InputStream inputStream = new FileInputStream("g://test/" + fileName + "." + ext);
            OutputStream os = response.getOutputStream();
            byte[] b = new byte[1024];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                os.write(b, 0, length);
            }
            // 这里主要关闭。
            os.close();
            inputStream.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
