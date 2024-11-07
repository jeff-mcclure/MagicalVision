local self = require('openmw.self')
local types = require('openmw.types')
local core = require('openmw.core')
local postprocessing = require('openmw.postprocessing')
local shader_sobel = postprocessing.load('invisible_chameleon_eff')
local shader_blur = postprocessing.load('paralyze_blind_eff')
local time = require('openmw_aux.time')

local invisibility
local chameleon
local blind
local paralyze

local stopFn = time.runRepeatedly(function() 

	chameleon = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Chameleon).magnitude
	invisibility = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Invisibility).magnitude
	blind = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Blind).magnitude
	paralyze = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Paralyze).magnitude
	
	if paralyze == 1 then
		shader_blur:enable()
		shader_blur:setFloat('uStrength', -0.8)
		shader_blur:setFloat('uBlurR', 2.0)
	elseif blind > 0 then
		shader_blur:enable()
		shader_blur:setFloat('uStrength', 0.8)
		shader_blur:setFloat('uBlurR', blind/15)
	else
		shader_blur:disable()
	end
	
	if invisibility == 1 then
		shader_sobel:enable()
		shader_sobel:setFloat('uBlend', 1.0)
	elseif chameleon > 0 then
		shader_sobel:enable()
		shader_sobel:setFloat('uBlend', chameleon/100)
	else
		shader_sobel:disable()
	end
	
end,0.5 * time.second)