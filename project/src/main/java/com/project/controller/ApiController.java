package com.project.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.dto.bus;
import com.project.service.ApiService;

@Controller
public class ApiController {

	@Autowired
	private ApiService apisvc;

	@RequestMapping(value = "/busapi")
	public ModelAndView busapi() throws Exception {
		System.out.println("버스 도착 정보 페이지 이동요청 - /busapi");
		ModelAndView mav = new ModelAndView();

		// 1. 버스 도착 정보 조회

		ArrayList<bus> result = apisvc.getBusArrive();
		mav.addObject("busList", result);

		// 2.버스 도착정보 페이지
		mav.setViewName("BusList");
		return mav;
	}

	@RequestMapping(value = "/busapi_ajax")
	public ModelAndView busapi_ajax() {
		System.out.println("버스 도착 정보 페이지 이동요청 - busapi_ajax 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("BusArriveInfo");
		return mav;
	}

	@RequestMapping(value = "/getBusArr")
	public @ResponseBody String getBusArr(String nodeId) throws Exception {
		System.out.println("버스 도착정보 조회 요청 - /getBusArr");
		System.out.println("nodeId : " + nodeId);

		// 1. Service - 도착정보 조회기능 호츌

		String arrInfoList = apisvc.getBusArrInfoList(nodeId);
		return arrInfoList;
	}
	
	@RequestMapping(value = "/getBusSttn")
	public @ResponseBody String getBusSttn(String lati, String longti) throws Exception {
		String sttnList = apisvc.getBusSttn(lati,longti);
		return sttnList;
	}
	
	//버스노선정보 가져오기
	@RequestMapping(value = "/getBusloc")
	public @ResponseBody String getBusloc(String node) throws Exception {
		System.out.println("버스 도착정보 조회 요청 - /getBusloc");
		String locList = apisvc.getBusloc(node);
		return locList;
	}
	
	@RequestMapping(value = "/airApi")
	public @ResponseBody ModelAndView airApi() throws IOException {
		System.out.println("항공정보 조회 - /airApi");
		ModelAndView mav = new ModelAndView();
		String result = apisvc.getAirApi();
		
		System.out.println(result);
		mav.setViewName("");
		return mav;
	}

}
