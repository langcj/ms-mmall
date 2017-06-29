/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.mingsoft.freight.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.action.BaseAction;

import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.freight.biz.IAreaBiz;
import net.mingsoft.freight.biz.IAreaDetailBiz;
import net.mingsoft.freight.entity.AreaDetailEntity;

/**
 * 运费模块的区域运费设置和修改
 * @author 上官德辉
 *
 */
@Controller
@RequestMapping("/${managerPath}/freight/areaDetail")
public class AreaDetailAction extends BaseAction {
	
	@Autowired
	private IAreaBiz freightAreaBiz;
	@Autowired
	private IAreaDetailBiz freightAreaDetailBiz;
	
	/**
	 * 加载页面显示所有区域信息
	 * @param request
	 * @return
	 */
	@RequestMapping("/index")
	private String index(HttpServletRequest request){
		//左侧列表
		List<BaseEntity> areas = freightAreaBiz.queryAll();
		request.setAttribute("areas", areas);
		return view("/freight/area_detail/index");
	}
	
	
	/**
	 * 右侧列表的快递信息
	 * @param request
	 */
	@RequestMapping("/list")
	@ResponseBody
	private void list(HttpServletResponse response,HttpServletRequest request){
		//table
		int modelId = BasicUtil.getModelCodeId(net.mingsoft.mall.constant.ModelCode.MALL_CATEGORY);
		int faId = Integer.parseInt(request.getParameter("faId"));
		if(faId != 0){
			List<AreaDetailEntity> faList = freightAreaDetailBiz.queryFreightAreaDetail(faId,modelId);
			EUListBean _list = new EUListBean(faList, faList.size());
			this.outJson(response, JSONArray.toJSONString(_list));
		}
	}
	
	/**
	 * 区域运费增加和修改
	 * @param areaDetail
	 * @param freightEntity
	 * @param response
	 * @param request
	 */
	@RequestMapping("/saveOrUpdate")
	@ResponseBody
	private void saveOrUpdate(HttpServletResponse response, HttpServletRequest request){
		String str = request.getParameter("str");
		List<AreaDetailEntity> areaDetailList = JSONArray.parseArray(str, AreaDetailEntity.class);
		for(int i=0;i<areaDetailList.size();i++){
			AreaDetailEntity areaDetailEntity = areaDetailList.get(i);
			freightAreaDetailBiz.saveOrUpdate(areaDetailEntity);
		}
	}
}