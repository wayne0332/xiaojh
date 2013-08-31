<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<table>
		<tr>
			<td>标题</td>
			<td>时间</td>
			<td>内容</td>
		</tr>
		<s:iterator value="#request.myAnnouncements">
			<tr>
				<td><s:property value="title" /></td>
				<td><s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" /></td>
				<td><s:property value="text" /></td>
			</tr>
		</s:iterator>
	</table>