var shopApi = (function ($, win, doc) {
    var shop_key = 'linker_shop';

    /**
     * @description 보유 포인트 조회
     * @param callback(code, data, res)
     **/
    var balance = function (param, callback) {
        var defaults = {service_id: '', coin_id: ''}
        tms.ajaxGetHelper(properties.apiHostShop() + "/coin/" + properties.apiVersionShop + "/Balance", returnParam(param, defaults),{urlChk: false},function (res) {
            var code = res.response_code;
            var data = (code === 0)?res.value.coin_amount:'';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }


    /**
     * @description 상점 아이템 판매 목록을 조회한다.
     * @param callback(code, res)
     **/
    var shopItemList = function(param, callback){
        var defaults = {shop_key: shop_key, item_type: '', deduct_type: '', page_size: '100', page_no:'1'}
        tms.ajaxGetHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/ShopItemList", returnParam(param, defaults), null,function (res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * @description 상점 아이템 판매 상세정보를 조회한다.
     * @param callback(code, res)
     **/
    var shopItemInfo = function(param, callback){
        var defaults = {shop_key: shop_key, shop_item_id: ''}
        tms.ajaxGetHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/ShopItemInfo", returnParam(param, defaults), null,function (res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * @description 상점 구매(충전)내역을 조회한다.
     * @param callback(code, res)
     **/
    var shopPurchaseList = function(param, callback){
        var defaults = {shop_key: shop_key, start_dt: '', end_dt: '', page_size: 10, page_no: ''}
        tms.ajaxGetHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/ShopPurchaseList", returnParam(param, defaults),null,function (res) {
            var code = res.response_code;
            var list = res.value.purchase_list;
            var paging = res.value;

            if(typeof callback === "function") {
                callback(code, list, paging, res);
            }
        });
    }

    /**
     * @description 상점 아이템을 구매한다. (결제전 주문번호 생성)
     * @param callback(code, res)
     **/
    var paymentOrder = function(param, callback){
        var defaults = {shop_key: shop_key, os_code: '', timestamp:new Date().getTime(), pg_code: properties.pgcode, pay_method: ''
            , payment_item_list: []}
        tms.ajaxPostHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/PaymentOrder", JSON.stringify(returnParam(param, defaults)),null,function (res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * @description 상점 아이템을 구매한다. (결제전 주문번호 생성)
     * @param callback(code, res)
     **/
    var paymentComplete = function(param, callback){
        var defaults = {imp_uid: '', shop_payment_tran_id: ''}
        tms.ajaxPostHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/PaymentComplete", JSON.stringify(returnParam(param, defaults)),null,function (res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * @description PG결제를 취소한다.
     * @param callback(code, res)
     **/
    var pgCancel = function(param, callback) {
        var defaults = { imp_uid: '', shop_payment_tran_id: ''};
        tms.ajaxPostHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/PgCancel", JSON.stringify(returnParam(param, defaults)), null, function(res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * @description 코인을 차감한다.
     * @param callback(code, res)
     **/
    var purchaseCoin = function(param, callback) {
        var defaultExtraData = { reason_id : '', reason_value : ''};
        var defaults = { service_id: '', coin_id: '', purchase_coin: '', purchase_extra_data: defaultExtraData, transaction_id: '' };
        tms.ajaxPostHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/PurchaseCoin", JSON.stringify(returnParam(param, defaults)), null, function(res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }
    
    /**
     * @description 첫 결제 쿠폰 전송
     * */
    var sendCouponForFirstOrder = function() {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/sendCouponForFirstOrder", null, {urlChk:false}, null);
    }
    
    /**
     * @description 오픈톡 댓글 이벤트
     * @param talkNo
     * @param callback
     * */
    var opentalkReplyEvent = function(param, callback) {
    	console.log('api in');
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/opentalkReplyEvent", JSON.stringify(param), null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * @description 멘토 칼럼 이벤트
     * */
    var sendEventCouponForMentorColumn = function () {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/sendEventCouponForMentorColumn", null, null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * @description 비즈상품의 브랜드 목록 조회
     * @param param
     * @param callback
     * */
    var getBizBrandList = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/getBizBrandList", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.brandList : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * @description 비즈상품 검색
     * @param param
     * @param callback
     * */
    var searchBizGoods = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/searchBizGoods", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.goodsList : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }

    /**
     * @description 비즈상품 조회
     * @param param
     * @param callback
     * */
    var getBizGoods = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/getBizGoods", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.goods : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * @description 쿠폰 상세 정보 조회
     * @param param
     * @param callback
     * */
    var bizCoupons = function(param, option, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/bizCoupons", param, option, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.coupons : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * @description 쿠폰 발송 요청
     * @param param
     * @param callback
     * */
    var bizSendCoupon = function(param, callback) {
    	var defaults = { mmsMsg : '링커에서 구매한 포인트 상품입니다.', mmsTitle: '링커에서 구매한 포인트 상품입니다.', callbackNo : '07041170815', userId : 'linkerdream@naver.com', gubun : 'I'};
    	tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/bizSendCoupon" , JSON.stringify(returnParam(param, defaults)), null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.coupon : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    /**
     * @description 쿠폰 취소 요청
     * @param param
     * @param callback
     * */
    var bizCancelCoupon = function(param, callback) {
    	var defaults = {userId : 'linkerdream@naver.com'};
    	tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/bizCancelCoupon", JSON.stringify(returnParam(param, defaults)), null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * @description 상점 구매(충전)내역을 조회한다.
     * @param callback(code, res)
     **/
    var shopPurchaseList2 = function(param, options, callback){
        var defaults = {shop_key: shop_key, start_dt: '', end_dt: '', page_size: 100, page_no: ''}
        tms.ajaxGetHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/ShopPurchaseList", returnParam(param, defaults),options,function (res) {
            var code = res.response_code;
            var list = res.value.purchase_list;
            var paging = res.value;

            if(typeof callback === "function") {
                callback(code, list, paging, res);
            }
        });
    }
    
    /**
     * @description 멘토칼럼 후원
     * @param param
     * @param callback
     * */
    var donateMentorColumn = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/donateMentorColumn", JSON.stringify(param), null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * @description 멘토칼럼 후원 NEW
     * @param param
     * @param callback
     * */
    var donateMentorVoiceColumn = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/donateMentorVoiceColumn", JSON.stringify(param), null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    /**
     * @description 멘토칼럼 후원 가능여부 체크
     * @param param
     * @param callback
     * */
    var voiceColumnCountCheck = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/voiceColumnCountCheck",param, null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * @description 스페셜패키지 상점 조회
     * @param param
     * @param callback
     * */
    var shopProductList = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/shopProductList", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * @description 스페셜패키지 상점에서 패키지를 구매
     * @param param
     * @param callback
     * */
    var purchaseShopProduct = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost()  + "/consult/svc/purchaseShopProduct", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * @description 멘티 자신이 구매한 생기부 목록을 가져온다
     * @param param
     * @param callback
     * */
    var retrievePurchaseList = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() +"/sr/svc/retrievePurchaseList", JSON.stringify(param), null, function (res) {
    		 var code = res.resultCode;
    		 var data = (code === 0) ? res.result : '';
    		 
    		 if(typeof callback === "function") {
    			 callback(code, data, res);
    		 }
		});
    }
    
    /**
     * 비밀톡 등록 시, 포인트 차감 및 매칭
     * @param param
     * @param callback
     * */
    var askQuestionWithPay = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/askQuestionWithPay", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		
    		if(typeof callback === "function") {
    			callback(code, res);
    		}
    		
    	});
    }
    
    /**
     * 비밀톡 답변채택, 포인트 차감롤백 및 상품구매
     * @param param
     * @param callback
     * */
    var adoptAnswerWithPay = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/adoptAnswerWithPay", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		
    		if(typeof callback === "function") {
    			callback(code, res);
    		}
    	});
    }

    /**
     * @description 상점 아이템 판매 목록을 조회한다. (모지 사전판매 전용)
     * @param callback(code, res)
     **/
    var getMojiShopItemList = function(param, callback){
        var defaults = {shop_key: shop_key, item_type: '', deduct_type: '', page_size: '100', page_no:'1'}
        tms.ajaxGetHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/ByPass/MojiShopItemList", returnParam(param, defaults), null,function (res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * @description 상점 아이템 판매 상세정보를 조회한다. (모지 사전판매 전용)
     * @param callback(code, res)
     **/
    var mojiShopItemInfo = function(param, callback){
        var defaults = {shop_key: shop_key, shop_item_id: ''}
        tms.ajaxGetHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/MojiShopItemInfo", returnParam(param, defaults), { showLoding: true },function (res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * @description 상점 아이템 판매 상세정보를 조회한다. (모지 사전판매 전용)
     * @param callback(code, res)
     **/
    var itemPurchase = function(param, option, callback){
        var defaults = {shop_key: shop_key, os_code: '', timestamp:new Date().getTime()}
        tms.ajaxPostHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/ItemPurchase", JSON.stringify(returnParam(param, defaults)), option,function (res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * @description 상점 아이템을 구매한다. (결제전 주문번호 생성) (모지 사전판매 전용)
     * @param callback(code, res)
     **/
    var mojiPaymentComplete = function(param, option, callback){
        var defaults = {imp_uid: '', shop_payment_tran_id: ''};
        tms.ajaxPostHelper(properties.apiHostShop() + "/shop/" + properties.apiVersionShop + "/MojiPaymentComplete", JSON.stringify(returnParam(param, defaults)),option,function (res) {
            var code = res.response_code;

            if(typeof callback === "function") {
                callback(code, res);
            }
        }, (err) => {
            callback(500);
        });
    }
   
    var returnParam = function(param, defaults){
        param = param || {};
        for (var prop in defaults)  {
            param[prop] = typeof param[prop] !== 'undefined' ? param[prop] : defaults[prop];
        }
        return param;
    }

    var shopErrorMsg = function(code){

        var msg = "에러가 발생하였습니다.\n잠시후 다시 시도해주세요.";
        if(code === 500){
            msg = "예외 상황이 발생 했습니다.";
        } else if(code === 501){
            msg = "데이터를 찾을 수 없습니다.";
        } else if(code === 502){
            msg = "잘못된 파라미터를 입력했습니다.";
        } else if(code === 515){
            msg = "잘못된 AccessToken 입니다.";
        } else if(code === 516){
            msg = "토큰의 유효기간이 만료 되었습니다.";
        } else if(code === 1000){
            msg = "상점Key가 존재하지 않습니다.";
        } else if(code === 1004){
            msg = "중복된 트랜잭션ID 요청입니다.";
        } else if(code === 1101){
            msg = "유효하지 않은 주문입니다.";
        } else if(code === 1102){
            msg = "유효하지 않은 아이템입니다.";
        } else if(code === 1103){
            msg = "유효하지 않은 상점 구매 트랜잭션ID 입니다.";
        } else if(code === 1104){
            msg = "IMP 토큰이 유효하지 않습니다.";
        } else if(code === 1105){
            msg = "유효하지 않은 IMP_UID입니다.";
        } else if(code === 1106){
            msg = "청구 금액과 주문 금액이 일치하지 않습니다.";
        } else if(code === 1107){
            msg = "주문한 캐시타입이 하나이상입니다.";
        } else if(code === 1108){
            msg = "판매프로모션이 유효하지 않습니다.";
        } else if(code === 1109){
            msg = "인벤토리 지급 오류입니다.";
        }

        return msg;
    }

    return {
        shopErrorMsg: shopErrorMsg,
        balance: balance,
        shopItemList: shopItemList,
        shopItemInfo: shopItemInfo,
        shopPurchaseList: shopPurchaseList,
        paymentOrder: paymentOrder,
        paymentComplete: paymentComplete,
        pgCancel: pgCancel,
        purchaseCoin: purchaseCoin,
        sendCouponForFirstOrder:sendCouponForFirstOrder,
        opentalkReplyEvent: opentalkReplyEvent,
        sendEventCouponForMentorColumn: sendEventCouponForMentorColumn,
        getBizBrandList:getBizBrandList,
        searchBizGoods:searchBizGoods,
        getBizGoods:getBizGoods,
        bizCoupons:bizCoupons,
        bizSendCoupon:bizSendCoupon,
        bizCancelCoupon:bizCancelCoupon,
        shopPurchaseList2:shopPurchaseList2,
        donateMentorColumn:donateMentorColumn,
        donateMentorVoiceColumn:donateMentorVoiceColumn,
        voiceColumnCountCheck:voiceColumnCountCheck,
        shopProductList:shopProductList,
        purchaseShopProduct:purchaseShopProduct,
        retrievePurchaseList:retrievePurchaseList,
        askQuestionWithPay:askQuestionWithPay,
        adoptAnswerWithPay:adoptAnswerWithPay,
        getMojiShopItemList:getMojiShopItemList,
        mojiShopItemInfo:mojiShopItemInfo,
        itemPurchase:itemPurchase,
        mojiPaymentComplete:mojiPaymentComplete
    }
}(jQuery, window, document));


