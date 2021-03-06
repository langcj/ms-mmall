<@ms.html5>
	<@ms.nav title="产品规格关联管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
			<@ms.searchFormButton>
				 <@ms.queryButton onclick="search()"/> 
			</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
					<@ms.addButton id="addProductAttributeBtn"/>
					<@ms.delButton id="delProductAttributeBtn"/>
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="productAttributeList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delProductAttribute" title="授权数据删除" >
		<@ms.modalBody>删除此授权
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认删除？"  id="deleteProductAttributeBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$(function(){
		$("#productAttributeList").bootstrapTable({
			url:"${managerPath}/mall/productAttribute/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true},
				    	{
				        	field: 'paId',
				        	title: '',
				        	width:'10',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/mall/productAttribute/form.do?paId="+row.paId;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},							    	{
				        	field: 'paProductId',
				        	title: '商品编号',
				        	width:'10',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/mall/productAttribute/form.do?paProductId="+row.paProductId;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},							    	{
				        	field: 'paCaId',
				        	title: '分类扩展属性编号',
				        	width:'10',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/mall/productAttribute/form.do?paCaId="+row.paCaId;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},							    	{
				        	field: 'paName',
				        	title: '',
				        	width:'255',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/mall/productAttribute/form.do?paName="+row.paName;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},							    	{
				        	field: 'paValue',
				        	title: '',
				        	width:'255',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/mall/productAttribute/form.do?paValue="+row.paValue;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	}			]
	    })
	})
	//增加按钮
	$("#addProductAttributeBtn").click(function(){
		location.href ="${managerPath}/mall/productAttribute/form.do"; 
	})
	//删除按钮
	$("#delProductAttributeBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#productAttributeList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delProductAttribute").modal();
		}
	})
	
	$("#deleteProductAttributeBtn").click(function(){
		var rows = $("#productAttributeList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/mall/productAttribute/delete.do",
			data: JSON.stringify(rows),
			dataType: "json",
			contentType: "application/json",
			success:function(msg) {
				if(msg.result == true) {
					<@ms.notify msg= "删除成功" type= "success" />
				}else {
					<@ms.notify msg= "删除失败" type= "fail" />
				}
				location.reload();
			}
		})
	});
	//查询功能
	function search(){
		var search = $("form[name='searchForm']").serializeJSON();
        var params = $('#productAttributeList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#productAttributeList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>