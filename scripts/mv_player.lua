local self = require('openmw.self')
local types = require('openmw.types')
local core = require('openmw.core')
local postprocessing = require('openmw.postprocessing')
local shader_sobel = postprocessing.load('invisible_chameleon_eff')
local shader_blur = postprocessing.load('paralyze_blind_eff')
local shader_elemental = postprocessing.load('elemental_eff')
local shader_tele = postprocessing.load('telekinesis_eff')
local time = require('openmw_aux.time')

local invisibility
local chameleon
local blind
local paralyze
local firedmg
local frostdmg
local shockdmg
local poisondmg
local telekinesis

local stopFn = time.runRepeatedly(function() 

	chameleon = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Chameleon).magnitude
	invisibility = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Invisibility).magnitude
	blind = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Blind).magnitude
	paralyze = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Paralyze).magnitude
	firedmg = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.FireDamage).magnitude
	frostdmg = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.FrostDamage).magnitude
	shockdmg = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.ShockDamage).magnitude
	poisondmg = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Poison).magnitude
	telekinesis = types.Actor.activeEffects(self):getEffect(core.magic.EFFECT_TYPE.Telekinesis).magnitude
	
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

	if firedmg > 0 then
		shader_elemental:enable()
		shader_elemental:setVec3('effectRGB', 1.0, 0.0, 0.0)
	elseif frostdmg > 0 then
		shader_elemental:enable()
		shader_elemental:setVec3('effectRGB', 0.0, 0.0, 1.0)
	elseif shockdmg > 0 then
		shader_elemental:enable()
		shader_elemental:setVec3('effectRGB', 0.0, 0.0, 1.0)
	elseif poisondmg > 0 then
		shader_elemental:enable()
		shader_elemental:setVec3('effectRGB', 0.0, 1.0, 0.0)
	else
		shader_elemental:disable()
	end
	
	if telekinesis > 0 then
		print(telekinesis)
		shader_tele:enable()
		shader_tele:setFloat('teleDist', telekinesis*29)
	else
		shader_tele:disable()
	end
	
end, 0.5 * time.second)