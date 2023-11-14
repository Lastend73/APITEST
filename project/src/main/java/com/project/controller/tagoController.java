package com.project.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.TagoService;

@Controller
public class tagoController {

	@Autowired
	TagoService tagosvc;

	@RequestMapping(value = "/tagoBus")
	public ModelAndView tagoBus() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("TagoBus");
		return mav;
	}

	@RequestMapping(value = "/getTagoSttnList")
	public @ResponseBody String getTagoSttnList(String lati, String longi) throws IOException {
		System.out.println("정류소 목록 조회 요청 - /getTagoSttnList 요청");
		System.out.println(lati + ":" + longi);

		String result = tagosvc.getBusSttnList(lati, longi);

		return result;
	}

	@RequestMapping(value = "/getTagoArrList")
	public @ResponseBody String getTagoArrList(String citycode, String nodeid) throws IOException {
		System.out.println("정류소 목록 조회 요청 - /getTagoArrList 요청");
		System.out.println(citycode + " : " + nodeid);
		String result = tagosvc.getBusArrList(citycode, nodeid);

		return result;
	}

	@RequestMapping(value = "/getTagoBusNodeList")
	public @ResponseBody String getTagoBusNodeList(String citycode, String routeid) throws IOException {
		System.out.println("정류소 목록 - /getTagoBusNodeList 요청");
		System.out.println(citycode + " : " + routeid);
		String result = tagosvc.getTagoBusNodeList(citycode, routeid);

		return result;
	}
	
	@RequestMapping(value = "/getTagoBusLocList")
	public @ResponseBody String getTagoBusLocList(String citycode, String routeid) throws IOException {
		System.out.println("정류소 목록 - /getTagoBusLocList 요청");
		System.out.println(citycode + " : " + routeid);
		String result = tagosvc.getTagoBusLocList(citycode, routeid);

		return result;
	}

}
