--[[--
 * @Description: 地图控制器
 * @Author:      shine
 * @FileName:    map_controller.lua
 * @DateTime:    2017-05-23 17:26:30
 ]]


map_controller = {}
local this = map_controller

map_type = 
{
	NONE = "MAP_NONE",      -- 无
	HALL = "MAP_HALL",      -- 大厅
}

local mLockRequest = false
local mMapID = 0
local mCurSystem = nil
local mLoadSceneEvent = nil

local mCurrLevelConfig = nil


local mIsLoadingMap = false  -- 备注一下，这个如果是true要设置一下回调，不允许连跳
function this.SetIsLoadingMap(bIsLoading)
	--log("SetIsLoadingMap:"..tostring(bIsLoading))
	mIsLoadingMap = bIsLoading
end

local mIsWaitMap = false
function this.IsWaitingMap()
	return mIsWaitMap
end

--[[--
 * @Description: 初始化  
 ]]
function this.Initialize()
    this.RegisterEvents()
end

--[[--
 * @Description: 反初始化  
 ]]
function this.Uninitialize()
    this.UnRegisterEvents()
end

--[[--
 * @Description: 注册事件  
 ]]
function this.RegisterEvents()
	--network_mgr.regist(CS_ENTER_MAP_INFO_NOTIFY, this.OnNotifyEnterMapInfo)  --通知进入地图的信息
end

--[[--
 * @Description: 反注册事件  
 ]]
function this.UnRegisterEvents()
	--network_mgr.remove(CS_ENTER_MAP_INFO_NOTIFY, this.OnNotifyEnterMapInfo)  --通知进入地图的信息
end

--------------------------------其他功能相关--------------------
function this.IsNewGuildLevel(mapID)
	local ret = false
	return ret
end

--获取当前关卡配置
function this.GetCurMapConfig()
	return mCurrLevelConfig
end

--获取当前地图的ID
function this.GetCurMapID()
	return mMapID
end

--[[--
 * @Description: 获取当前map类型 
 ]]
function this.GetCurMapType()
	if mCurrLevelConfig ~= nil then
		if mCurrLevelConfig.MapType == 1 then  --多人
			return map_type.MULTI
		elseif mCurrLevelConfig.MapType == 2 then  --单人
			return map_type.SINGLE
		elseif mCurrLevelConfig.MapType == 3 then  --大厅
			return map_type.HALL
		else
			Fatal("error mapID".. mapID)
			return map_type.NONE
		end
	else
		Fatal("error!!!! levelconfig error,  mapID=".. mapID)
		return map_type.NONE
	end
end

--获取服务器RoomID
function this.GetSrvCopyID()
	if mCurSystem.GetSrvCopyID ~= nil then
		return mCurSystem.GetSrvCopyID()
	end
	return 0
end

--加上主动锁  防止客户端主动跳场景 非必要不要乱用
function this.Lock()
	mLockRequest = true
end
--解锁
function this.UnLock()	
	mLockRequest = false
end

function this.ResetSystem(mapID)
	if mCurrLevelConfig == nil then
		mCurrLevelConfig = config_data_center.getConfigDataByID("dataconfig_sceneconfig", "id", mapID)
	end

	if mCurrLevelConfig ~= nil then
		if mCurrLevelConfig.MapType == 1 then  --多人
			mCurSystem = level_sys_multi
			mLoadSceneEvent = this.LoadLevelScene
		elseif mCurrLevelConfig.MapType == 2 then  --单人
			mCurSystem = level_sys_single
			mLoadSceneEvent = this.LoadLevelScene
		elseif mCurrLevelConfig.MapType == 3 then  --大厅
			mCurSystem = hall_ui
			mLoadSceneEvent = this.LoadHallScene
		else
			Fatal("error mapID".. mapID)
		end
	else
		Fatal("error!!!! levelconfig error,  mapID=".. mapID)
	end
end

-----------------------------------------------------------Net------------------------------------------------------
--[[--
 * @Description: 所有请求地图跳转关卡的入口，单机联网都一样  
 ]]
function this.RequestEnterMap(mapID)
	if mLockRequest then
		FastTips.Show("当前状态不能离开场景")
		return
	end

	this.ReqEnterHallAndLevel(mapID)
end

--[[--
 * @Description: 地图跳转关卡的入口(加Loading条)
 	funcEnterMap:其他方式地图跳转（为nil是 默认在加载完成后使用RequestEnterMap 跳转）
 ]]
function this.RequestEnterMapWithLoading(mapID, funcEnterMap)
	if mapID == mMapID then
 		FastTips.Show("你已在当前地图")
	    return true
	end

	return false
end

--子节点  请求单机
function this.RequestEnterSingleModeMap(mapID)
	local currLevelConfig = config_data_center.getConfigDataByID("dataconfig_sceneconfig", "id", mapID)
end

--[[--
 * @Description: 请求进入大厅或者其他场景  
 ]]
function this.ReqEnterHallAndLevel(mapID)
	if TestMode.IsCmdSingleMode(mapID) or this.IsNewGuildLevel(mapID) then
		this.RequestEnterSingleModeMap(mapID)
	else
		this.SendRequestEnterMap(mapID)
	end
end

--[[--
 * @Description: 发请求
]]
function this.SendRequestEnterMap(mapID)
	local enterReqProto = ""
	--这里测试使用
	--network_mgr.sendPkgWaitForRsp(nil, enterReqProto, this.ResponseEnterMap)
end


function this.EnterMapHandler(mapID)

end


--[[--
 * @Description: 请求后服务器回复的空包  不做其他事情  之后会收到 OnNotifyEnterMapInfo
 ]]
function this.ResponseEnterMap(pkgData)
	netdata_rsp_handler.ParseFromString(pkgData)
end


function this.LoadMap()
	if mNotifyEnterRsp ~=nil then
		mIsWaitMap = false
		mIsLoadingMap = false
		mMapID = mNotifyEnterRsp.MapID
		mCurrLevelConfig = config_data_center.getConfigDataByID("dataconfig_sceneconfig", "id", mMapID)

		this.NotifyEnterHallAndLevel(mNotifyEnterRsp)
		mNotifyEnterRsp = nil
	end
end

--[[--
 * @Description: 子节点  进入MAP  
 ]]
function this.NotifyEnterHallAndLevel(rsp)
	this.ResetSystem(rsp.MapID)

	if game_scene.GetCurSceneID() ~= rsp.MapID then
		mLoadSceneEvent(rsp.MapID)
	elseif mCurSystem.IsInited ~= nil and mCurSystem.IsInited() then    -- 重连进来
		this.ReqEnterMapReady()
	end
end

--[[--
 * @Description: 进入场景
 ]]
function this.LoadHallScene(mapID)
	mCurrLevelConfig = config_data_center.getConfigDataByID("dataconfig_sceneconfig", "id", mapID)
	if (mCurrLevelConfig ~= nil) then
		mCurSystem = hall_ui
    	game_scene.gotoHall(mapID, mCurSystem)
	else
		Fatal("invalid config id")
    end
end

--[[--
 * @Description: 进入具体游戏场景  
 ]]
function this.LoadLevelScene(mapID, play_sys)
	if mapID == game_scene.GetCurSceneID()then
		return
	end
	
	mCurrLevelConfig = config_data_center.getConfigDataByID("dataconfig_sceneconfig", "id", mapID)	
	if (mCurrLevelConfig ~= nil) then
		log("mCurrLevelConfig.sceneType=========================="..tostring(mCurrLevelConfig.sceneType))
		if mCurrLevelConfig.sceneType == scene_type.HENANMAHJONG then
			require "logic/mahjong_sys/mahjong_play_sys"		
    		game_scene.gotoLevel(mapID, mCurrLevelConfig.sceneType, play_sys)
    	elseif mCurrLevelConfig.sceneType == scene_type.FUJIANSHISANGSHUI then
			require "logic/shisangshui_sys/shisangshui_play_sys"
			game_scene.gotoLevel(mapID, "FUJIANSHISANGSHUI", play_sys)
		end	
	else
		Fatal("invalid config id")
    end
end

function this.ReqEnterMapReady()
	map_controller.SetIsLoadingMap(false)
end

function this.OnEnterMapRespone(pkgData)
	--log("OnEnterMapRespone"..tostring(req))
end

--------------------------------系统&时序-----------------------
-- map 加载完成
function this.HandleLevelLoadComplete()
	--TODO:

end

--退出当前map
function this.ExitLevelSystem()
	--TODO:
end

--------------------------------unity相关-----------------------
--TODO: