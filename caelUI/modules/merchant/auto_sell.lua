local private = unpack(select(2, ...))


local Item_Count = 0
local Sell_Value = 0

private.events:RegisterEvent("MERCHANT_SHOW", function()
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local item = GetContainerItemLink(bag, slot)
            if item then
                local Item_Value = select(11, GetItemInfo(item)) * GetItemCount(item)

                if select(3, GetItemInfo(item)) == 0 then
                    ShowMerchantSellCursor(1)
                    UseContainerItem(bag, slot)

                    Item_Count = Item_Count + GetItemCount(item)
                    Sell_Value = Sell_Value + Item_Value
                end
            end
        end
    end

    if Sell_Value > 0 then
        private.print("Merchant", format("Sold %d trash item%s for %s", Item_Count, Item_Count > 1 and "s" or "", private.FormatMoney(Sell_Value)))
        Item_Count, Sell_Value = 0, 0
    end
end)
