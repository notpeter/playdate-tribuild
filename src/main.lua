-- Standard libs from PlayDate SDK
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/animator"
import "CoreLibs/crank"

import "bits"

local function setup()
    bits.init()
    playdate.update = bits.update
end
setup()
