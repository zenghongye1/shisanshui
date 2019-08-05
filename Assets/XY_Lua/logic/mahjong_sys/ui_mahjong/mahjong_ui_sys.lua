--[[--
 * @Description: 麻将UI 控制层
 * @Author:      ShushingWong
 * @FileName:    mahjong_ui_sys.lua
 * @DateTime:    2017-06-20 15:59:13
 ]]



mahjong_ui_sys = {}

require("logic/voteQuit/vote_quit_ui")

local this = mahjong_ui_sys

local gvbl = room_usersdata_center.GetViewSeatByLogicSeat
local gvbln = room_usersdata_center.GetViewSeatByLogicSeatNum
local gmls = room_usersdata_center.GetMyLogicSeat


local function UpdatePlayerEnter(tbl,callback)
	local viewSeat = gvbl(tbl["_src"])
	local logicSeat = room_usersdata_center.GetLogicSeatByStr(tbl["_src"])
	local uid = tbl["_para"]["_uid"]
	local coin = tbl["_para"]["score"]["coin"]

	--waiting_ui.Show()
	local param={["uid"]=uid,["type"]=1}
	http_request_interface.getGameInfo(param,function (code,m,str) 
			local s=string.gsub(str,"\\/","/")
	        local t=ParseJsonStr(s)

	        local userdata = room_usersdata.New()
	        userdata.zhengzhoumj = t["data"]
	        userdata.uid = uid
			userdata.name = t["data"].nickname
			userdata.coin = coin
			userdata.vip  = 0

			http_request_interface.getImage({tbl["_para"]["_uid"]},function(code2,m2,str2)
				print(tostring(str2))
				local s2=string.gsub(str2,"\\/","/")
	        	local t2=ParseJsonStr(s2)

	        	if t2["data"][1].imagetype == 1 then
	        		userdata.headurl = "http://img.qq1234.org/uploads/allimg/150612/8_150612153203_7.jpg"
	        	elseif t2["data"][1].imagetype == 2 then
					userdata.headurl = t2["data"][1].imageurl--"http://img.qq1234.org/uploads/allimg/150612/8_150612153203_7.jpg"
				end
				room_usersdata_center.AddUser(logicSeat,userdata)
				
				mahjong_ui.SetPlayerInfo( viewSeat, userdata)
				--waiting_ui.Hide()
				if callback~=nil then
					callback()
				end
				end)
	    end)
end


local function OnPlayerEnter( tbl )
	print(GetTblData(tbl))

	local viewSeat = gvbl(tbl["_src"])
	UpdatePlayerEnter(tbl,function()
		Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_ENTER_GAME)
	end)

	ui_sound_mgr.PlaySoundClip("common/sitdown")

	--金币场不显示，以后处理
	if viewSeat == 1 then
		local str = ""
		if roomdata_center.gamesetting~=nil then
			for i,v in pairs(roomdata_center.gamesetting) do
				local s = MahjongGameSetting[i]
				if s~=nil and v then
					str = str..s.." "
				end
			end
		end
		roomdata_center.gameRuleStr = str

		local roomnum = 0
		if not roomdata_center.IsCoinRoom() then
			roomnum = roomdata_center.roomnumber
			mahjong_ui.SetGameInfo(roomnum)
		end
		
	--	mahjong_ui.SetGameInfo(roomdata_center.roomnumber)
	--	roomdata_center.leftCard = mode_manager.GetCurrentMode().config.MahjongTotalCount
    --	mahjong_ui.SetLeftCard(roomdata_center.leftCard)
	    if not roomdata_center.isRoundStart then
	    	mahjong_ui.ShowReadyBtns()
	    end

	end

	--print("OnPlayerEnter-----------------------------------------------------")
	--Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_ENTER_GAME)
end

local function OnPlayerReady( tbl )
	local logicSeat = tbl["_src"]
	local viewSeat = gvbl(logicSeat)

	if viewSeat == 1 then
		mahjong_ui.ResetAll()
		mahjong_ui.SetReadyBtnVisible(false)

	end

	mahjong_ui.SetPlayerReady(viewSeat, true)
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_READY)
end

local function OnGameStart(tbl)


	roomdata_center.isStart = true
	roomdata_center.isRoundStart = true
	ui_sound_mgr.PlaySoundClip("common/duijukaishi")

	mahjong_ui.ResetAll()
	mahjong_ui.HideAllReadyBtns()
	roomdata_center.ClearData()

	for i=1,roomdata_center.MaxPlayer() do
		mahjong_ui.SetPlayerReady(i, false)
	end

	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_START)
end


------河南相关------------------

local function OnGoXiaPao( tbl )
	mahjong_ui.ShowXiaPaoBtn()

	ui_sound_mgr.PlaySoundClip("common/xiapao")
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_GOXIAPAO)
end

local function OnPlayerXiaPao( tbl )
	local viewSeat = gvbl(tbl["_src"])

	if viewSeat == 1 then
		mahjong_ui.HideXiaPaoBtn()
	end

	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_XIAPAO)
end

local function OnALLPlayerXiaPao( tbl )
	mahjong_ui.HideXiaPaoBtn()

	if tbl["_para"]["p4"]~=nil then
		mahjong_ui.SetXiaoPao(gvbl("p4"),tbl["_para"]["p4"])
	end
	if tbl["_para"]["p3"]~=nil then
		mahjong_ui.SetXiaoPao(gvbl("p3"),tbl["_para"]["p3"])
	end
	if tbl["_para"]["p2"]~=nil then
		mahjong_ui.SetXiaoPao(gvbl("p2"),tbl["_para"]["p2"])
	end
	if tbl["_para"]["p1"]~=nil then
		mahjong_ui.SetXiaoPao(gvbl("p1"),tbl["_para"]["p1"])
	end

	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_XIAPAO)
end

local function OnGameLaiZi( tbl )
	--print(GetTblData(tbl))
	ui_sound_mgr.PlaySoundClip("common/laizi")
	mahjong_ui.ShowHunPai(tbl["_para"]["laizi"][1])
end

-----------------------------------



local function OnGameBanker( tbl )
	local viewSeat = gvbln(tbl["_para"]["banker"])
	roomdata_center.zhuang_viewSeat = viewSeat
	mahjong_ui.SetBanker(viewSeat)

	ui_sound_mgr.PlaySoundClip("common/zhuang")
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_BANKER)
end

local function OnPlayStart( tbl )
	-- 播放动画
    
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_PLAYSTART)
end

local function OnGameDeal( tbl )
	--print(GetTblData(tbl))
	mahjong_ui.HideOperTips()
	roomdata_center.SetRoomLeftCard(mode_manager.GetCurrentMode().config.MahjongTotalCount)
	roomdata_center.nCurrJu = tbl._para.subRound
	mahjong_ui.SetGameInfoVisible(true)
	mahjong_ui.SetRoundInfo(tbl._para.subRound, roomdata_center.nJuNum)
	--Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_DEAL)
end





--[[--
 * @Description: 操作类型
 *   MahjongOperTipsEnum = {
    None                = 0x0001,
    GiveUp              = 0x0002,--过,
    Collect             = 0x0003,--吃,
    Triplet             = 0x0004,--碰,
    Quadruplet          = 0x0005,--杠,
    Ting                = 0x0006,--听,
    Hu                  = 0x0007,--胡,
}
 ]]
local function OnGameAskBlock( tbl )
	print(GetTblData(tbl))

	operatorcachedata.ClearOperTipsList()

	--
	local lastPlayViewSeat = gvbln(tbl._para.lastPlay)


	--胡牌
	local bCanWin = tbl._para.bCanWin
	if bCanWin then
		if tbl._para.nWinFalg == 0 then
			local operData = operatorTipsData:New(MahjongOperTipsEnum.Hu,tbl._para.cardWin)
			operatorcachedata.AddOperTips(operData)
		else
			--抢金
			local operData = operatorTipsData:New(MahjongOperTipsEnum.Qiang,tbl._para.cardWin)
			operatorcachedata.AddOperTips(operData)
		end
	end


	--听牌
	local bCanTing = tbl._para.bCanTing
	if bCanTing then
		local operData = operatorTipsData:New(MahjongOperTipsEnum.Ting,tbl._para.cardTing)
		operatorcachedata.AddOperTips(operData)
	end

	--杠牌
	local bCanQuadruplet = tbl._para.bCanQuadruplet
	if bCanQuadruplet then
		local operData = operatorTipsData:New(MahjongOperTipsEnum.Quadruplet,tbl._para.cardQuadruplet)
		operatorcachedata.AddOperTips(operData)
	end


	--碰牌
	local bCanTriplet = tbl._para.bCanTriplet
	if bCanTriplet then
		local operData = operatorTipsData:New(MahjongOperTipsEnum.Triplet,tbl._para.cardTriplet)
		operatorcachedata.AddOperTips(operData)
	end


	-- 吃牌 	最后一次打牌的人 吃谁的 碰谁的 杠谁的 胡谁的
	local bCanCollect = tbl._para.bCanCollect
	if bCanCollect then
		local operData = operatorTipsData:New(MahjongOperTipsEnum.Collect,tbl._para.cardCollect)
		operatorcachedata.AddOperTips(operData)
	end

	if bCanCollect or bCanTriplet or bCanQuadruplet or bCanTing or bCanWin then
		local operData = operatorTipsData:New(MahjongOperTipsEnum.GiveUp,nil)
		operatorcachedata.AddOperTips(operData)

		mahjong_ui.ShowOperTips()

		ui_sound_mgr.PlaySoundClip("common/audio_tip_operate")
	end
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_ASKBLOCK)
end

local function OnPlayCard( tbl )
	local operPlayViewSeat = gvbl(tbl._src)
	if operPlayViewSeat ==1 then
		mahjong_ui.HideOperTips()

		-- 听牌相关处理
		local paiValue = tbl._para.cards[1]
		roomdata_center.CheckTingWhenGiveCard(paiValue)
		mahjong_ui.cardShowView:ShowHuBtn(roomdata_center.isTing)
	end
end

local function OnGiveCard( tbl )
	mahjong_ui.HideOperTips()
end

--[[--
 * @Description: 吃碰杠胡效果
 * animations_sys.PlayAnimation(this.gameObject.transform,"majhong_special_card_type","gang1",100,100,function() 
		print("PlayComPlete111111")
	end)  
 ]]

local function OnTriplet( tbl )
	local operPlayViewSeat = gvbl(tbl._src)
	--if operPlayViewSeat ==1 then
		mahjong_ui.HideOperTips()
	--end
	animations_sys.PlayAnimation(mahjong_ui.playerList[operPlayViewSeat].operPos,"majhong_special_card_type","peng1",100,100,false,function(  )
		--callback
	end)
end

local function OnQuadruplet( tbl )
	local operPlayViewSeat = gvbl(tbl._src)
	--if operPlayViewSeat ==1 then
		mahjong_ui.HideOperTips()
	--end
	animations_sys.PlayAnimation(mahjong_ui.playerList[operPlayViewSeat].operPos,"majhong_special_card_type","gang1",100,100,false,function(  )
		--callback
	end)
end

local function OnCollect( tbl )
	local operPlayViewSeat = gvbl(tbl._src)
	--if operPlayViewSeat ==1 then
		mahjong_ui.HideOperTips()
	--end
	animations_sys.PlayAnimation(mahjong_ui.playerList[operPlayViewSeat].operPos,"majhong_special_card_type","chi1",100,100,false,function(  )
		--callback
	end)
end

-- local function OnTing(tbl )
-- 	roomdata_center.SetHintInfoMap(tbl)
-- 	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_TING)
-- end

local function OnGameWin( tbl )
	print(GetTblData(tbl))

	local winner = tbl._para.stWinList[1].winner
	local win_type = tbl._para.stWinList[1].winType
	local win_viewSeat = gvbln(winner)

	 if win_type == "huangpai" then
 		mahjong_ui.ShowHuang(function()
 			Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_WIN)
 		end)
 	else
 		local typeName = "hu1"
 		local soundName = "hu"
 		if win_type == "gunwin" then
 			typeName = "hu1"
 			soundName = "hu"
 		elseif win_type == "robgangwin" then
 			typeName = "qianggang_1"
 			soundName = "hu"
 		elseif win_type == "selfdraw" then
 			typeName = "zimo1"
 			soundName = "zimo"
 		elseif win_type == "robgoldwin" then
 			typeName = "qiangjin_1"
 			soundName = "qiangjin"
 		end

 		ui_sound_mgr.PlaySoundClip("man/"..soundName)

 		animations_sys.PlayAnimationByScreenPosition(
 			mahjong_ui.playerList[win_viewSeat].operPos,0,0,
 			"majhong_special_card_type",
 			typeName,
 			100,
 			100,
 			false,
 			function()
 				Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_WIN)
 			end)
 	end
end

local function OnGameRewards( tbl )
	print(GetTblData(tbl))

	mahjong_ui.HideOperTips()


	local para = tbl._para
	local banker = para.banker
	local curr_ju = para.curr_ju
	local ju_num = para.ju_num
	local dice = para.dice
	local rewards = para.rewards --包含4个玩家信息的table
	local who_win = para.who_win[1]
	local win_type = para.win_type
	local rid = para.rid
	--判断是否为大结算
	local isBigReward = false
	if curr_ju >= ju_num then
		require ("logic/mahjong_sys/ui_mahjong/bigSettlement_ui")
		isBigReward = true
	end

	local win_viewSeat = 0
 	if who_win~=nil and who_win>0 and who_win<5 then
 		win_viewSeat = gvbln(who_win)
 	end

 	local rewardsTbl = {}

 	for i=1,roomdata_center.MaxPlayer() do
 		local t= {}
 		local viewSeat = gvbln(i)
 		t.name = room_usersdata_center.GetUserByLogicSeat(i).name
 		t.point = rewards[i].all_score
 		if i==banker then
 			t.isBanker = true
 		else
 			t.isBanker = false
 		end
 		t.url = room_usersdata_center.GetUserByLogicSeat(i).headurl
 		t.scoreItem = {}

 		if win_type ~= "huangpai" then
 			local double = 1
 			if win_type == "selfdraw" or win_type == "robgoldwin" then
 				double = 2
 			end

 			if rewards[i].win_info.nFanDetailInfo~=nil then
		 		for i,v in ipairs(rewards[i].win_info.nFanDetailInfo) do
		 			local item1 = {}
		 			local win_des = mode_manager.GetCurrentMode().config.byFanType[v.byFanType]
		 			item1.des = win_des or ""
			 		item1.num = ""..v.byFanNumber.."番"
			 		item1.p = MahjongTools.GetPosDes(viewSeat,win_viewSeat)
			 		table.insert(t.scoreItem,item1)
		 		end
		 	end

	 		if rewards[i].lianZhuangFan>0 then
		 		local item2 = {}
		 		item2.des = "连庄加番"
		 		item2.num = ""..rewards[i].lianZhuangFan*double.."番"
		 		item2.p = "本家"
		 		table.insert(t.scoreItem,item2)
		 	end

		 	if rewards[i].gangFan > 0 then
		 		local item3 = {}
		 		item3.des = "杠番"
		 		item3.num = ""..rewards[i].gangFan*double.."番"
		 		item3.p = "本家"
		 		table.insert(t.scoreItem,item3)
		 	end

		 	if rewards[i].flowerFan > 0 then
		 		local item4 = {}
		 		item4.des = "花番"
		 		item4.num = ""..rewards[i].flowerFan*double.."番"
		 		item4.p = "本家"
		 		table.insert(t.scoreItem,item4)
		 	end

		 	if rewards[i].laizi_count > 0 then
		 		local item5 = {}
		 		item5.des = "金牌数"
		 		item5.num = ""..rewards[i].laizi_count*double.."番"
		 		item5.p = "本家"
		 		table.insert(t.scoreItem,item5)
		 	end
	 	end
 		rewardsTbl[viewSeat] = t
 	end

 	local byFanNumber = 0
	local byFanType = 0
 	if who_win~=nil and who_win>0 and who_win<5 then
	 	local fanInfo = rewards[who_win].win_info.nFanDetailInfo
	 	for i,v in ipairs(fanInfo) do
	 		if v.byFanType > byFanType then
	 			if v.byFanNumber > byFanNumber then
	 				byFanNumber = v.byFanNumber
	 				byFanType = v.byFanType
	 			end
	 		end
	 	end
 	end

 	-- local win_type = para.win_type
 	-- 胡牌类型：huangpai(荒局), gunwin(点炮胡), robgangwin(抢杠胡 算点炮), selfdraw(自摸), robgoldwin(抢金胡 算自摸)

 	if win_type == "huangpai" then
		mahjong_ui.SetRewards(rewardsTbl,win_viewSeat,isBigReward,rid)
 	else
 		
		if byFanType>0 then
			print("byFanType-----"..byFanType)
			local fanTypeName = ""
			if byFanType == 32 then
	 			fanTypeName = "wuhuawugang_1"
	 		elseif byFanType == 33 then
	 			fanTypeName = "yizhanghua_1"
	 		elseif byFanType == 34 then
	 			fanTypeName = "jinque_1"
	 			ui_sound_mgr.PlaySoundClip("man/jinque")
	 		elseif byFanType == 35 then
	 			fanTypeName = "jinlong_1"
	 			ui_sound_mgr.PlaySoundClip("man/jinlong")
	 		elseif byFanType == 36 then
	 			fanTypeName = "banqingyise_1"
	 			ui_sound_mgr.PlaySoundClip("man/hunyise")
	 		elseif byFanType == 37 then
	 			fanTypeName = "quanqingyise_1"
	 			ui_sound_mgr.PlaySoundClip("man/qingyise")
	 		elseif byFanType == 38 then
	 			fanTypeName = "xianjin_1"
	 		elseif byFanType == 39 then
	 			fanTypeName = "sanjindao_1"
	 			ui_sound_mgr.PlaySoundClip("man/sanjindao")
	 		elseif byFanType == 16 then 
	 			fanTypeName = "tianhu_1"
	 			ui_sound_mgr.PlaySoundClip("man/tianhu")
	 		elseif byFanType == 17 then 
	 			fanTypeName = ""
	 		end

	 		if fanTypeName == "" then
				mahjong_ui.SetRewards(rewardsTbl,win_viewSeat,isBigReward,rid)
			else
				animations_sys.PlayAnimationByScreenPosition(
	 			mahjong_ui.playerList[win_viewSeat].transform.parent,0,0,
	 			"majhong_special_card_type",
	 			fanTypeName,
	 			100,
	 			100,
	 			false,function()
	 				print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					mahjong_ui.SetRewards(rewardsTbl,win_viewSeat,isBigReward,rid)
	 			end)
			end
 		else
			mahjong_ui.SetRewards(rewardsTbl,win_viewSeat,isBigReward,rid)
		end
		
 	end

	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_REWARDS)
end

local function OnPointsRefresh( tbl )
	print(GetTblData(tbl))

	local viewSeat = gvbl(tbl["_src"])

	mahjong_ui.SetPlayerCoin(viewSeat, tbl["_para"][1].coin)

	if viewSeat == 1 then
		Notifier.dispatchCmd(cmdName.MSG_COIN_REFRESH, tbl["_para"][1].coin)	
	end

	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_POINTS_REFRESH)
end

local function OnGameEnd( tbl )
	
	roomdata_center.isStart = false
	mahjong_ui.GameEnd()
	roomdata_center.ClearData()
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_END)
	if this.headEff ~= nil then
		animations_sys.StopPlayAnimationToCache(this.headEff, "anim_head_eff")
        this.headEff = nil
	end
end

local function OnAskReady( tbl )
	if not roomdata_center.isRoundStart then
		mahjong_ui.ShowReadyBtns()
	end
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_ASK_READY)
end

local function OnSyncBegin( tbl )
	print(GetTblData(tbl))
	print("重连同步开始")
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_SYNC_BEGIN)
end

local function OnSyncTable( tbl )
	print("重连同步表")
	print(GetTblData(tbl))

	--[[
		game_state:
		prepare     
		deal        
		laizi       
		xiapao      
		round       
		reward      
		gameend  
		]]

	local ePara = tbl._para
	--[[--
	 * @Description: game_state
	 * ["game_state"]="round";  
	 ]]
	local game_state = ePara.game_state 		-- 游戏阶段
	--[[--
	 * @Description: dealer
	 * ["dealer"]="p1";  
	 ]]
	local dealer = ePara.dealer 				-- 庄家
	--[[--
	 * @Description: dice
	 * ["dice"]={
			[1]=3;[2]=5;
		};  
	 ]]
	local dice = ePara.dice 					-- 骰子
	--[[--
	 * @Description: laizi
	 * ["laizi"]={
			["laizi"]={				[1]=9;			};
			["sit"]={				[1]=14;			};
			["card"]={				[1]=8;			};
		};  
	 ]]
	local laizi = ePara.laizi 					-- 癞子
	--[[--
	 * @Description: player_state
	 * ["player_state"]={
			[1]=2;[2]=2;[3]=2;[4]=2;
		};  
	 ]]
	local player_state = ePara.player_state 	-- 玩家状态
	--[[--
	 * @Description: tileCount
	 * ["tileCount"]={
			[1]=13;[2]=13;[3]=13;[4]=14;
		};  
	 ]]
	local tileCount = ePara.tileCount 			-- 各玩家手牌数
	--[[--
	 * @Description: tileLeft
	 * ["tileLeft"]=60;  
	 ]]
	local tileLeft = ePara.tileLeft 			-- 剩余牌子
	--[[--
	 * @Description: tileList
	 * ["tileList"]={
			[1]=8;[2]=17;[3]=33;[4]=35;[5]=23;[6]=18;[7]=23;[8]=28;[9]=28;[10]=21;[11]=35;[12]=36;[13]=23;
		};  
	 ]]
	local tileList = ePara.tileList 			-- 玩家手牌值
	local combineTile = ePara.combineTile 		-- 各玩家吃碰杠
	--[[--
	 * @Description: xiapao
	 * ["xiapao"]={
			[1]=0;[2]=1;[3]=3;[4]=2;
		};  
	 ]]
	local xiapao = ePara.xiapao 				-- 下跑
	local winTile = ePara.winTile 				-- 各家所赢
	--[[--
	 * @Description: discardTile
	 * ["discardTile"]={
			[1]={
				[1]=13;[2]=28;[3]=29;[4]=7;[5]=3;[6]=4;
			};[2]={
				[1]=22;[2]=9;[3]=23;[4]=21;[5]=4;[6]=7;
			};[3]={
				[1]=14;[2]=19;[3]=32;[4]=28;[5]=1;[6]=2;
			};[4]={
				[1]=3;[2]=29;[3]=27;[4]=14;[5]=1;
			};
		};  
	 ]]
	local discardTile = ePara.discardTile 		-- 各玩家出的牌
	--[[--
	 * @Description: whoisOnTurn
	 * ["whoisOnTurn"]=4  
	 ]]
	local whoisOnTurn = ePara.whoisOnTurn 		-- 谁的回合
	--[[--
	 * @Description: nleftTime
	 * ["nleftTime"]=0;  
	 ]]
	local nleftTime = ePara.nleftTime 			-- 
	--local cardLastDraw = ePara.cardLastDraw 		-- 


	local state = MahjongSyncGameState[game_state]
	if state == nil then
		state = 0 
	end

	if state >= 510 then
		mahjong_ui.SetAllHuaPointVisible(true)
	else
		mahjong_ui.SetAllHuaPointVisible(false)
	end

	if state >= 600 then
		mahjong_ui.SetAllScoreVisible(true)
	else
		mahjong_ui.SetAllScoreVisible(false)
	end

	if game_state == "prepare" then  		--准备阶段
		--显示准备提示准备

		for i=1,roomdata_center.MaxPlayer() do
			local viewSeat = gvbln(i)
			local state = player_state[i]
			if state ~= nil then
				if state == 2 then
					mahjong_ui.SetPlayerReady(viewSeat, true)
					if viewSeat == 1 then
						mahjong_ui.SetReadyBtnVisible(false)
					end
				elseif state == 1 then
					if viewSeat == 1 then
						mahjong_ui.ShowReadyBtns()
					end
				end
			end
		end
	elseif game_state == "xiapao" then 		--下跑阶段
		roomdata_center.isStart = true
		mahjong_ui.HideAllReadyBtns()
		--定庄

		this.OnResetDealer( dealer )
		--提示下跑
		local myLogicSeat = gmls()
		if xiapao[myLogicSeat] == -1 then
			mahjong_ui.ShowXiaPaoBtn()
		end
	elseif game_state == "deal" then 		--发牌阶段
		roomdata_center.isStart = true
		mahjong_ui.HideAllReadyBtns()
		--定庄
		this.OnResetDealer( dealer )
		--显示下跑
		if xiapao~=nil then
			this.OnResetXiaPao( xiapao )
		end
	elseif game_state == "laizi" then 		--癞子阶段

		roomdata_center.isStart = true
		mahjong_ui.HideAllReadyBtns()
		--定庄
		this.OnResetDealer( dealer )
		--显示下跑
		if xiapao~=nil then
			this.OnResetXiaPao( xiapao )
		end
	elseif game_state == "round" then 		--出牌阶段
		roomdata_center.isStart = true
		mahjong_ui.HideAllReadyBtns()
		--定庄
		this.OnResetDealer( dealer )
		--显示下跑
		if xiapao~=nil then
			this.OnResetXiaPao( xiapao )
		end
		--显示癞子
		if laizi~=nil and laizi.laizi[1]~=nil then
			mahjong_ui.ShowHunPai(laizi.laizi[1])
		end

		if this.headEff ~= nil then
        	animations_sys.StopPlayAnimationToCache(this.headEff, "anim_head_eff")
        	this.headEff = nil
    	end
		local viewSeat = gvbln(whoisOnTurn)
		if this.headEff ~= nil then
	        animations_sys.StopPlayAnimationToCache(this.headEff, "anim_head_eff")
	        this.headEff = nil
	    end
		if viewSeat ~= 1 then
	    	this.headEff = mahjong_ui.ShowHeadEffect(viewSeat)
	    end
		this.OnResetRoundAndLeftCard( ePara.subRound,ePara.roundWind,ePara.tileLeft )
		--roomdata_center.leftCard = tileLeft

	elseif game_state == "reward" then 		--结算阶段
		--todo
	elseif game_state == "gameend" then 	--结束阶段
		--todo
	end

	local gameStart = game_state ~= "reward" and game_state ~= "prepare" and game_state ~= "reward" 

	if gameStart then
        for i=1,roomdata_center.MaxPlayer() do
            mahjong_ui.SetPlayerReady(i, false)
        end
        mahjong_ui.HideAllReadyBtns()
    end

	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_SYNC_TABLE)
end

function this.OnResetRoundAndLeftCard( curRound,totalRound,leftCard )
	
end

function this.OnResetDealer( dealer )
	--定庄
	local banker_viewSeat = gvbl(dealer)
	roomdata_center.zhuang_viewSeat = banker_viewSeat
	mahjong_ui.SetBanker(banker_viewSeat)
end

function this.OnResetXiaPao( xiapao )
	--显示下跑
	for i=1,roomdata_center.MaxPlayer() do
		local viewSeat = gvbln(i)
		mahjong_ui.SetXiaoPao(viewSeat,xiapao[i])
	end
end

local function OnSyncEnd( tbl )
	print(GetTblData(tbl))
	print("重连同步结束")

	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_SYNC_END)
end

local function OnLeaveEnd( tbl )
	print(GetTblData(tbl))
	local viewSeat = gvbl(tbl._src)
	if roomdata_center.isStart == true then
		mahjong_ui.SetPlayerMachine(viewSeat, true)
	else
		mahjong_ui.HidePlayer(viewSeat)
	end
	
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_LEAVE)
end

local function OnPlayerOffline( tbl )
	print(GetTblData(tbl))
	
	local viewSeat = gvbl(tbl._src)
	if tbl._para.reason~=nil and tbl._para.reason == 0 and tbl._para.active == nil  then
		if tbl._para.ingame == 1 or roomdata_center.isStart == true then
			--mahjong_ui.SetPlayerMachine(viewSeat, true)
		else
			mahjong_ui.HidePlayer(viewSeat)
		end
	elseif tbl._para.reason~=nil and tbl._para.reason == 1 and tbl._para.active ~= nil and tbl._para.active == 1 then
		mahjong_ui.SetPlayerLineState(viewSeat, false)
	elseif tbl._para.active ~= nil and tbl._para.active == 0 then
		UpdatePlayerEnter(tbl)
		--[[
		local userdata = room_usersdata.New()
		userdata.name = tbl["_para"]["_uid"]
		userdata.coin = tbl["_para"]["score"]["coin"]
		userdata.vip  = 0
		userdata.headurl = "http://img.qq1234.org/uploads/allimg/150612/8_150612153203_7.jpg"
		room_usersdata_center.AddUser(room_usersdata_center.GetLogicSeatByStr(viewSeat,userdata)) 
		mahjong_ui.SetPlayerInfo(viewSeat,userdata)]]
	else
		mahjong_ui.SetPlayerLineState(viewSeat, false)
	end

	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_OFFLINE)
end

local function OnPlayerChat( tbl )
	print(GetTblData(tbl))

	local viewSeat = gvbl(tbl._src)
	local contentType = tbl["_para"]["contenttype"]
	local content = tbl["_para"]["content"]
	local givewho = gvbl(tbl["_para"]["givewho"])

	if roomdata_center.isStart == true then		
	else		
	end
	mahjong_ui.DealChat(viewSeat,contentType,content,givewho)

	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_GAME_CHAT)
end

local function OnAutoPlay( tbl )
	print(GetTblData(tbl))

	local viewSeat = gvbl(tbl._src)
	local state = tbl["_para"]["setStatus"]

	if roomdata_center.isStart == true then		
	else		
	end
	--mahjong_ui.SetPlayerMachine(viewSeat, state)
	
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_AutoPlay)
end



local function OnChangeFlower(tbl)
	mahjong_ui.SetAllHuaPointVisible(true)
	-- local flowerCounts = tbl._para["nTotalFlowerCard"]
	-- local viewSeat = gvbln(tbl._para[nFlowerWho])

end

local function OnOpenGold()

end

local function OnRobGold( tbl )
	print(GetTblData(tbl))
	
	--Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F3_ROB_GOLD)
end

local function OnLeftCardUpdate(leftCard)
	mahjong_ui.SetLeftCard(leftCard)
end

local function OnPlayerHuaCardUpdate(tbl)
	-- logError(viewSeat, cardNum)
	mahjong_ui.SetFlowerCardNum(tbl[1], tbl[2])
end

local function OnVoteDraw(tbl)
	local viewSeat = gvbl(tbl["_src"])
	vote_quit_ui.AddVote(tbl._para.accept, viewSeat)
	mahjong_ui.voteView:AddVote(tbl._para.accept, viewSeat)
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_VOTE_DRAW)
end

local function OnVoteStart(tbl)
	local viewSeat = gvbln(tbl["_para"].who)
	local time = tbl._para.timeout
	local name = room_usersdata_center.GetUserByViewSeat(viewSeat).name
	if viewSeat ~= 1 then
		vote_quit_ui.Show(name, function(value) 
			mahjong_play_sys.VoteDrawReq(value)
		 end, roomdata_center.MaxPlayer(), time)
	end
	mahjong_ui.voteView:Show(roomdata_center.MaxPlayer())
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_VOTE_START)
end

local function OnVoteEnd()

	vote_quit_ui.Hide()
	mahjong_ui.voteView:Hide()
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F1_VOTE_END)
end


local function OnAskPlay(tbl)
	local viewSeat = gvbl(tbl._src)
	if this.headEff ~= nil then
        animations_sys.StopPlayAnimationToCache(this.headEff, "anim_head_eff")
        this.headEff = nil
    end
    if viewSeat ~= 1 then
    	this.headEff = mahjong_ui.ShowHeadEffect(viewSeat)
    end

    if roomdata_center.zhuang_viewSeat == 1 and roomdata_center.beginSendCard == false then
    	mahjong_ui.ShowZhuanTips()
    	roomdata_center.beginSendCard = true
   	end
end

-- 玩家分数更新
local function OnAccountUpadte(tbl)
	local scores = tbl._para.totalscore
	for i = 1, #scores do
		local viewSeat = gvbln(i)
		mahjong_ui.SetPlayerScore(viewSeat, scores[i])
	end
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F3_ACCOUNT)
end

local function OnStartFlag(tbl)
	roomdata_center.isRoundStart = tbl._para.flag == 1
	Notifier.dispatchCmd(cmdName.MSG_HANDLE_DONE, cmdName.F3_START_FLAG)
end

function this.Init()
	print("-----------Start Regist Event UI ---------------!!!!!!!!!!")
	Notifier.regist(cmdName.F1_ENTER_GAME, OnPlayerEnter)--玩家进入
	Notifier.regist(cmdName.F1_GAME_READY, OnPlayerReady)--玩家准备
	Notifier.regist(cmdName.F1_GAME_START,OnGameStart)--游戏开始
	Notifier.regist(cmdName.F1_GAME_BANKER,OnGameBanker)--定庄
	Notifier.regist(cmdName.F1_GAME_GOXIAPAO,OnGoXiaPao)--通知下跑
	Notifier.regist(cmdName.F1_GAME_XIAPAO,OnPlayerXiaPao)--玩家下跑
	Notifier.regist(cmdName.F1_GAME_ALLXIAPAO,OnALLPlayerXiaPao)--所有玩家下跑
	
	Notifier.regist(cmdName.F1_GAME_PLAYSTART,OnPlayStart)--打牌开始
	Notifier.regist(cmdName.F1_GAME_DEAL,OnGameDeal)--发牌
	Notifier.regist(cmdName.F1_GAME_LAIZI,OnGameLaiZi)--定赖

	Notifier.regist(cmdName.F1_GAME_GIVECARD,OnGiveCard)--摸牌
	Notifier.regist(cmdName.F1_GAME_PLAY,OnPlayCard)--出牌

	Notifier.regist(cmdName.F1_GAME_ASKBLOCK,OnGameAskBlock)--提示吃碰杠胡操作
	Notifier.regist(cmdName.F1_GAME_TRIPLET,OnTriplet)--碰牌
    Notifier.regist(cmdName.F1_GAME_QUADRUPLET,OnQuadruplet)--杠牌
	Notifier.regist(cmdName.F1_GAME_COLLECT,OnCollect)--吃牌
    
	Notifier.regist(cmdName.F1_GAME_WIN,OnGameWin)--胡
	Notifier.regist(cmdName.F1_GAME_REWARDS,OnGameRewards)--结算
	Notifier.regist(cmdName.F1_POINTS_REFRESH,OnPointsRefresh)--玩家金币更新
	Notifier.regist(cmdName.F1_GAME_END,OnGameEnd)--游戏结束
	Notifier.regist(cmdName.F1_ASK_READY,OnAskReady)--通知准备

	Notifier.regist(cmdName.F1_SYNC_BEGIN,OnSyncBegin)--重连同步开始
	Notifier.regist(cmdName.F1_SYNC_TABLE,OnSyncTable)--重连同步表
	Notifier.regist(cmdName.F1_SYNC_END,OnSyncEnd)--重连同步结束

	Notifier.regist(cmdName.F1_GAME_LEAVE,OnLeaveEnd)--用户离开
	Notifier.regist(cmdName.F1_GAME_OFFLINE,OnPlayerOffline)--用户掉线 和 用户离开

	Notifier.regist(cmdName.F1_GAME_CHAT,OnPlayerChat)--用户聊天
	Notifier.regist(cmdName.F1_AutoPlay,OnAutoPlay)--托管


	Notifier.regist(cmdName.F3_CHANGE_FLOWER, OnChangeFlower)  -- 补花
	Notifier.regist(cmdName.F3_OPEN_GOLD, OnOpenGold) -- 开金
	Notifier.regist(cmdName.F3_ROB_GOLD, OnRobGold) -- 抢金

	Notifier.regist(cmdName.F1_VOTE_DRAW, OnVoteDraw)		--请求和局/投票
	Notifier.regist(cmdName.F1_VOTE_START, OnVoteStart)		--请求和局开始
	Notifier.regist(cmdName.F1_VOTE_END, OnVoteEnd)		--请求和局结束

	Notifier.regist(cmdName.F1_GAME_ASKPLAY, OnAskPlay)    --通知出牌

	Notifier.regist(cmdName.F3_ACCOUNT, OnAccountUpadte) -- 玩家分数刷新
	Notifier.regist(cmdName.F3_START_FLAG, OnStartFlag)		-- 游戏是否开始标记

	------------------------------游戏逻辑刷新-----------------------
	Notifier.regist(cmdName.GAME_UPDATE_ROOM_LEFT_CARD, OnLeftCardUpdate) -- 剩余牌数更新
	Notifier.regist(cmdName.GAME_UPDATE_PLAYER_HUA_CARD, OnPlayerHuaCardUpdate) -- 玩家花牌更新
end

function this.UInit()
	Notifier.remove(cmdName.F1_ENTER_GAME, OnPlayerEnter)--玩家进入
	Notifier.remove(cmdName.F1_GAME_READY,OnPlayerReady)--玩家准备
	Notifier.remove(cmdName.F1_GAME_START,OnGameStart)--游戏开始
	Notifier.remove(cmdName.F1_GAME_BANKER,OnGameBanker)--定庄
	Notifier.remove(cmdName.F1_GAME_GOXIAPAO,OnGoXiaPao)--通知下跑
	Notifier.remove(cmdName.F1_GAME_XIAPAO,OnPlayerXiaPao)--玩家下跑
	Notifier.remove(cmdName.F1_GAME_ALLXIAPAO,OnALLPlayerXiaPao)--所有玩家下跑

	Notifier.remove(cmdName.F1_GAME_PLAYSTART,OnPlayStart)--打牌开始
	Notifier.remove(cmdName.F1_GAME_DEAL,OnGameDeal)--发牌
	Notifier.remove(cmdName.F1_GAME_LAIZI,OnGameLaiZi)--定赖

	Notifier.remove(cmdName.F1_GAME_GIVECARD,OnGiveCard)--摸牌
	Notifier.remove(cmdName.F1_GAME_PLAY,OnPlayCard)--出牌

	Notifier.remove(cmdName.F1_GAME_ASKBLOCK,OnGameAskBlock)--提示吃碰杠胡操作
	Notifier.remove(cmdName.F1_GAME_TRIPLET,OnTriplet)--碰牌
    Notifier.remove(cmdName.F1_GAME_QUADRUPLET,OnQuadruplet)--杠牌
    Notifier.remove(cmdName.F1_GAME_COLLECT,OnCollect)--吃牌

    Notifier.remove(cmdName.F1_GAME_WIN,OnGameWin)--胡
	Notifier.remove(cmdName.F1_GAME_REWARDS,OnGameRewards)--结算
	Notifier.remove(cmdName.F1_POINTS_REFRESH,OnPointsRefresh)--玩家金币更新
	Notifier.remove(cmdName.F1_GAME_END,OnGameEnd)--游戏结束
	Notifier.remove(cmdName.F1_ASK_READY,OnAskReady)--通知准备

	Notifier.remove(cmdName.F1_SYNC_BEGIN,OnSyncBegin)--重连同步开始
	Notifier.remove(cmdName.F1_SYNC_TABLE,OnSyncTable)--重连同步表
	Notifier.remove(cmdName.F1_SYNC_END,OnSyncEnd)--重连同步结束

	Notifier.remove(cmdName.F1_GAME_LEAVE,OnLeaveEnd)--用户离开
	Notifier.remove(cmdName.F1_GAME_OFFLINE,OnPlayerOffline)--用户掉线

	Notifier.remove(cmdName.F1_GAME_CHAT,OnPlayerChat)--用户聊天
	Notifier.remove(cmdName.F1_AutoPlay,OnAutoPlay)--托管


	Notifier.remove(cmdName.F3_CHANGE_FLOWER, OnChangeFlower)  -- 补花
	Notifier.remove(cmdName.F3_OPEN_GOLD, OnOpenGold) -- 开金
	Notifier.remove(cmdName.F3_ROB_GOLD, OnRobGold) -- 抢金

	Notifier.remove(cmdName.F1_VOTE_DRAW, OnVoteDraw)		--请求和局/投票
	Notifier.remove(cmdName.F1_VOTE_START, OnVoteStart)		--请求和局开始
	Notifier.remove(cmdName.F1_VOTE_END, OnVoteEnd)		--请求和局结束

	Notifier.remove(cmdName.F1_GAME_ASKPLAY, OnAskPlay)    --通知出牌

	Notifier.remove(cmdName.F3_ACCOUNT, OnAccountUpadte) -- 玩家分数刷新

	Notifier.remove(cmdName.F3_START_FLAG, OnStartFlag)		-- 游戏是否开始标记

	------------------------------游戏逻辑刷新-----------------------
	Notifier.remove(cmdName.GAME_UPDATE_ROOM_LEFT_CARD, OnLeftCardUpdate) -- 剩余牌数更新
	Notifier.remove(cmdName.GAME_UPDATE_PLAYER_HUA_CARD, OnPlayerHuaCardUpdate) -- 玩家花牌更新
end

function this.GetHeadPic(textureComp, url )
	print("GetHeadPic "..url)

	DownloadCachesMgr.Instance:LoadImage(url,function( code,texture )
		--print("!!!!!!!!!state:"..tostring(state))
		textureComp.mainTexture = texture 
	end)

end
