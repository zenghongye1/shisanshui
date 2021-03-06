local base = require "logic/framework/ui/uibase/ui_view_base"
local ClubListViewWithGrid = class("ClubListViewWithGrid", base)
local ClubItem = require "logic/club_sys/View/new/ClubSelfItemView"
local addClickCallbackSelf = addClickCallbackSelf

function ClubListViewWithGrid:InitView()
	self.model = ClubModel
	self.itemGo = child(self.gameObject, "container/scrollview/ui_wrapcontent/item")
	self.scroll = subComponentGet(self.transform, "container/scrollview", typeof(UIScrollView))
	self.itemList = {}
	local item = ClubItem:create(self.itemGo)
	self.itemList[1] = item
	self.itemList[1]:SetCallback(self.OnItemClick, self)

	self.grid = subComponentGet(self.transform, "container/scrollview/ui_wrapcontent", typeof(UIGrid))
	
	local closeBtn = child(self.gameObject, "closeBtn")
	addClickCallbackSelf(child(self.gameObject, "closeBtn"), self.OnCloseClick, self)
	local chgClubBtn = child(self.gameObject,"chgClubBtn")
	if chgClubBtn then
	 	addClickCallbackSelf(chgClubBtn, self.ChgClubBtnClick, self)
	end
end

function ClubListViewWithGrid:OnCloseClick(item)
	log("ClubListView:OnCloseClick")
	self.gameObject:SetActive(false)
end

function ClubListViewWithGrid:ChgClubBtnClick(obj)
	self:OnCloseClick()
	ui_sound_mgr.PlaySoundClip("common/audio_button_click")
	UI_Manager:Instance():ShowUiForms("join_ui_new")
end

function ClubListViewWithGrid:UpdateList(force)
	local lastCount = 0
	if self.clubList ~= nil then
		lastCount = #self.clubList
	end
	self.clubList = self.model.unofficalClubList 
	local count = 0
	if self.clubList ~= nil then
		count = #self.clubList 
	end

	if count == 0 then
		self:OnClose()
	end
	self:RefreshItemCount(self.clubList)

	local index = self:GetCurIndex()
	if self.itemList[index] == nil then
		index = 1
	end

	self:Select(self.itemList[index])

	if not force and (lastCount == #self.clubList or count == 0 )then
		return
	end

	self.scroll:ResetPosition()

	if count <= 4 then
		return
	end

	if index + 4 > count then
		index = count - 4 + 1
	end

	--self.scroll:MoveRelative(Vector3(0, 95 * (index - 1), 0))
end

function ClubListViewWithGrid:ResPosition()
	if self and self.grid then
		self.grid:Reposition()
	end
end

function ClubListViewWithGrid:GetCurIndex()
	if self.model.currentClubInfo == nil then
		return 1
	end
	for i = 1, #self.clubList do
		if self.clubList[i].cid == self.model.currentClubInfo.cid then
			return i 
		end
	end
	return 1
end


function ClubListViewWithGrid:RefreshItemCount(dataList)
	local count = 0
	if dataList == nil then
		count = 0
	else
		count = #dataList
	end

	if #self.itemList < count then
		for i = #self.itemList + 1, count do
			local go = newobject(self.itemGo)
			local item = ClubItem:create(go)
			go.transform:SetParent(self.itemGo.transform.parent, false)
			item:SetCallback(self.OnItemClick, self)
			table.insert(self.itemList, item)
		end
	end

	for i = 1, count do
		self.itemList[i]:SetActive(true)
		self.itemList[i]:SetInfo(dataList[i])
	end

	if #self.itemList > count then
		for i = count + 1, #self.itemList do
			self.itemList[i]:SetActive(false)
		end
	end

	self.grid:Reposition()
end



function ClubListViewWithGrid:OnItemClick(item)
	ui_sound_mgr.PlayButtonClick()
	if item.clubInfo.cid == self.curCid then
		log("相同俱乐部")
		return
	end
	self:Select(item)
	self.model:SetCurrentClubInfo(item.clubInfo, true)
end

function ClubListViewWithGrid:Select(item)
	if item == self.currentItem then
		return
	end
	if self.currentItem ~= nil then
		self.currentItem:SetSelected(false)
		self.currentItem = nil
	end
	self.currentItem = item
	self.currentItem:SetSelected(true)
end



function ClubListViewWithGrid:OnClose()
	if self.currentItem ~= nil then
		self.currentItem:SetSelected(false)
		self.currentItem = nil
	end
end


return ClubListViewWithGrid