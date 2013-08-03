package com.tjxjh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.po.School;

@Service
public class CommonService extends BaseService
{
	public List<School> schools()
	{
		return dao.findAll(School.class);
	}
	public School school(Integer id)
	{
		return dao.findById(School.class,id);
	}
}
