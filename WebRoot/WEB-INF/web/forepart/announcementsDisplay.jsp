<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
			<ul class="letter_list">
				<s:iterator value="#request.myAnnouncements" status="status">
					<li class="letter_box cf">
						<div class="lette_box_right shadow_l_3">
							<div>
								<s:a href="personalLetter?letter.id=%{id}" class="showLetter">
									<p class="letter_content">
										<s:property value="title" />
										<s:date name="datetime" format="MM/dd HH:mm" />
									</p>
								</s:a>
								<p class="m10"><s:property value="text" /></p>
							</div>
							<div>
								<span class="letter_name">
									<span>
										<s:a href="deleteLetter?letter.id=%{id}">删除</s:a>
									</span>
								</span>
								<span class="letter_state">
									<s:property value="status.name" />
								</span>
							</div>
						</div>
					</li>
				</s:iterator>
			</ul>