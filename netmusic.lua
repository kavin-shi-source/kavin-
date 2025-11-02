local args = {...}

local function isDiskInv(name, wrapped)
    if peripheral.getType(name) == "netmusic:music_player" then
        return false
    end
    for slot, item in pairs(wrapped.list()) do
        if item and item.name == "netmusic:music_cd" then
            return true
        end
    end
end

local function main()
    local mode = "seq"
    if #args >= 1 then
        mode = args[1]
    end

    local music = peripheral.find("netmusic:music_player")
    local disks = peripheral.find("inventory", isDiskInv)

    if not music then
        print("Music player not found.")
        return
    end

    if not disks then
        print("Disks not found.")
        return
    end

    -- 清空唱片机
    if music.getItemDetail(1) then
        music.pushItems(peripheral.getName(disks), 1)
    end

    while true do
        local diskSlots = {}
        for slot, item in pairs(disks.list()) do
            if item and item.name == "netmusic:music_cd" then
                diskSlots[#diskSlots + 1] = slot
            end
        end

        if mode == "rand" then
			local replace = {}
			local slot = table.remove(diskSlots, math.random(#diskSlots))
			while slot do
				replace[#replace + 1] = slot
				if #diskSlots > 0 then
					slot = table.remove(diskSlots, math.random(#diskSlots))
				else
					break
				end
			end
			diskSlots = replace
        end

        -- 歌单输出
        print("Music List:")
        for i, n in ipairs(diskSlots) do
            print(i, ":", disks.getItemDetail(n).displayName)
        end

        local slot = table.remove(diskSlots, 1)
        while slot do
            -- 放入唱片
            music.pullItems(peripheral.getName(disks), slot)

            -- 短脉冲启动唱片机
            redstone.setOutput(peripheral.getName(music), true)
            sleep(0.05)
            redstone.setOutput(peripheral.getName(music), false)

            -- 等待下降沿触发切歌
            local rs_state = {}
            for i, side in ipairs(redstone.getSides()) do
                rs_state[side] = redstone.getAnalogInput(side)
            end
            repeat
                os.pullEvent("redstone")
                local closed = false
                for i, side in ipairs(redstone.getSides()) do
                    if rs_state[side] - redstone.getAnalogInput(side) > 0 then
                        closed = true
                    end
                end

                for i, side in ipairs(redstone.getSides()) do
                    rs_state[side] = redstone.getAnalogInput(side)
                end
            until closed

            -- 原唱片回收
            if music.getItemDetail(1) then
                music.pushItems(peripheral.getName(disks), 1)
            end
            slot = table.remove(diskSlots, 1)
        end
    end
end

main()
