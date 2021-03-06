function getNA6Actions(no)
  if(no < 0)then return {};
  elseif(no == 0)then
    return {'42650','43265','45462','45529','47476','47528','47568','48266','48707','49020','49143','49184','49998','50842','51271','57330','77575','96268','108194','115989','123693','130735','152279','152280','61999','48792','119975','108196','48743','I5512','45477'};
  elseif(no == 1)then
    return {'42650','45462','45477','45529','47476','47528','47541','47568','48263','48707','48743','48792','48982','49028','49039','49222','49998','50842','55233','57330','77575','108194','114866','119975','152280','56222','61999','108196','108200','I5512'};
  elseif(no == 2)then
    return {'42650','43265','45462','45529','47476','47528','47568','48266','48707','49020','49143','49184','50842','51271','57330','77575','96268','108194','115989','123693','130735','152279','152280','NA_ChagetTarget','61999','49998','48792','119975','108196','48743','I5512','45477'};
  elseif(no == 3)then
    return {'42650','43265','45462','45477','45529','46584','47476','47528','47541','47568','48265','48707','49206','50842','55090','57330','63560','77575','85948','96268','108194','115989','123693','130736','152279','152280','NA_ChagetTarget','61999'};
  end
  return {};
end

NA6ProfileNames = {[0]='Two-Handed Frost',[1]='Blood',[2]='Dual-Wield Frost',[3]='Unholy',};

function NA6Dps()
  W_Log(1,"死亡骑士 dps");
  
	local hasBoneshield=not(NA_ProfileNo == 1) or W_HasBuff(NA_Player, 49222, true);  --白骨之盾
	
	
	
	
  if(W_IsInCombat())then
    if(W_TargetCanAttack()) then
      -- 保命施法
      if(NA_ProfileNo < 0)then return false;
      elseif(NA_ProfileNo == 0)then --Two-Handed Frost
        
        if(false
					or NA_Fire(NA_checkHP(2), '49998', NA_Target) --灵界打击
					or NA_Fire(NA_checkHP(2), '48707', NA_Player) --反魔法护罩
					or NA_Fire(NA_checkHP(0), '48792', NA_Player) --冰封之韧
					or NA_Fire(NA_isUsableTalentSpell(5,3) and NA_checkHP(0), '119975', NA_Player) --符能转换
					or NA_Fire(NA_isUsableTalentSpell(5,2) and NA_checkHP(0), '108196', NA_Player) --死亡虹吸
					or NA_Fire(NA_isUsableTalentSpell(5,1) and NA_checkHP(0), '48743', NA_Player) --天灾契约
					or NA_Fire(NA_checkHP(1), 'I5512', NA_Player) --I5512

        )then return true; end
      elseif(NA_ProfileNo == 1)then --Blood
        
        if(false
					or NA_Fire(NA_checkHP(2), '49998', NA_Target) --灵界打击
					or NA_Fire(NA_checkHP(2), '48707', NA_Player) --反魔法护罩
					or NA_Fire(NA_checkHP(0), '48792', NA_Player) --冰封之韧
					or NA_Fire(NA_isUsableTalentSpell(5,3) and NA_checkHP(0), '119975', NA_Player) --符能转换
					or NA_Fire(NA_isUsableTalentSpell(5,2) and NA_checkHP(0), '108196', NA_Player) --死亡虹吸
					or NA_Fire(NA_isUsableTalentSpell(2,1) and NA_checkHP(0), '49039', NA_Player) --巫妖之躯
					or NA_Fire(NA_isUsableTalentSpell(2,1) and NA_checkHP(0) and W_RetainBuff(NA_Player, 49039, true), '47541', NA_Player) --凋零缠绕
					or NA_Fire(NA_checkHP(0), '55233', NA_Player) --吸血鬼之血
					or NA_Fire(NA_isUsableTalentSpell(5,1) and NA_checkHP(0), '48743', NA_Player) --天灾契约
					or NA_Fire(not hasBoneshield, '49222', NA_Player) --白骨之盾
					or NA_Fire(NA_isUsableTalentSpell(6,2), '108200', NA_Player) --冷酷严冬
					or NA_Fire(NA_checkHP(1), 'I5512', NA_Player) --I5512

        )then return true; end
      elseif(NA_ProfileNo == 2)then --Dual-Wield Frost
        
        if(false
					or NA_Fire(NA_checkHP(2), '49998', NA_Target) --灵界打击
					or NA_Fire(NA_checkHP(2), '48707', NA_Player) --反魔法护罩
					or NA_Fire(NA_checkHP(0), '48792', NA_Player) --冰封之韧
					or NA_Fire(NA_isUsableTalentSpell(5,3) and NA_checkHP(0), '119975', NA_Player) --符能转换
					or NA_Fire(NA_isUsableTalentSpell(5,2) and NA_checkHP(0), '108196', NA_Player) --死亡虹吸
					or NA_Fire(NA_isUsableTalentSpell(5,1) and NA_checkHP(0), '48743', NA_Player) --天灾契约
					or NA_Fire(NA_checkHP(1), 'I5512', NA_Player) --I5512

        )then return true; end
      elseif(NA_ProfileNo == 3)then --Unholy
        
        if(false

        )then return true; end
      end

      if(NA_ProfileNo < 0)then return false;
      elseif(NA_ProfileNo == 0)then --Two-Handed Frost
        
				
        
        if(not NA_IsAOE and (false

          or NA_fireByOvale()
        ))then return true; end
  
        if(NA_IsAOE and (false

          or NA_fireByOvale()
        ))then return true; end
      elseif(NA_ProfileNo == 1)then --Blood
        local notTanking = not NA_IsSolo and not W_isTanking();
				
				
        
        if(not NA_IsAOE and (false
					or NA_Fire(notTanking, '56222', NA_Target) --黑暗命令
					or NA_Fire(notTanking, '45477', NA_Target) --冰冷触摸
					or NA_Fire(notTanking and W_PowerLevel(NA_Player)>0.6, '47541', NA_Target) --凋零缠绕

          or NA_fireByOvale()
        ))then return true; end
  
        if(NA_IsAOE and (false
					or NA_Fire(notTanking, '56222', NA_Target) --黑暗命令
					or NA_Fire(notTanking, '45477', NA_Target) --冰冷触摸
					or NA_Fire(notTanking and W_PowerLevel(NA_Player)>0.6, '47541', NA_Target) --凋零缠绕

          or NA_fireByOvale()
        ))then return true; end
      elseif(NA_ProfileNo == 2)then --Dual-Wield Frost
        
				
        
        if(not NA_IsAOE and (false
					or NA_Fire(W_HPlevel(NA_Target)<=0 or UnitName(NA_Target)==nil, 'NA_ChagetTarget', NA_Target) --NA_ChagetTarget

          or NA_fireByOvale()
        ))then return true; end
  
        if(NA_IsAOE and (false

          or NA_fireByOvale()
        ))then return true; end
      elseif(NA_ProfileNo == 3)then --Unholy
        
				
        
        if(not NA_IsAOE and (false
					or NA_Fire(W_HPlevel(NA_Target)<=0 or UnitName(NA_Target)==nil, 'NA_ChagetTarget', NA_Target) --NA_ChagetTarget

          or NA_fireByOvale()
        ))then return true; end
  
        if(NA_IsAOE and (false

          or NA_fireByOvale()
        ))then return true; end
      end
    elseif(UnitCanAssist(NA_Player, NA_Target))then
      if(NA_ProfileNo < 0)then return false;
      elseif(NA_ProfileNo == 0)then --Two-Handed Frost
        
				
        if(false
					or NA_Fire(UnitIsDead(NA_Target), '61999', NA_Target) --复活盟友

        )then return true; end
      elseif(NA_ProfileNo == 1)then --Blood
        
				
        if(false
					or NA_Fire(UnitIsDead(NA_Target), '61999', NA_Target) --复活盟友

        )then return true; end
      elseif(NA_ProfileNo == 2)then --Dual-Wield Frost
        
				
        if(false
					or NA_Fire(UnitIsDead(NA_Target), '61999', NA_Target) --复活盟友

        )then return true; end
      elseif(NA_ProfileNo == 3)then --Unholy
        
				
        if(false
					or NA_Fire(UnitIsDead(NA_Target), '61999', NA_Target) --复活盟友

        )then return true; end
      end
      return false;
    elseif(NA_IsSolo)then
      return NA_ChagetTarget();      
    end
  else    
    if(NA_ProfileNo < 0)then return false;
    elseif(NA_ProfileNo == 0)then --Two-Handed Frost
      
      if(false
					or NA_Fire(select(3,UnitStat(NA_Player,1))==0, '57330', NA_Player) --寒冬号角
					or NA_Fire(NA_isUsableTalentSpell(5,3) and W_HPlevel(NA_Player) < 0.7, '119975', NA_Player) --符能转换
					or NA_Fire(W_TargetCanAttack(), '45477', NA_Target) --冰冷触摸

      )then return true; end
    elseif(NA_ProfileNo == 1)then --Blood
      
      if(false
					or NA_Fire(not W_HasBuff(NA_Player, 57330, true), '57330', NA_Player) --寒冬号角
					or NA_Fire(not hasBoneshield, '49222', NA_Player) --白骨之盾
					or NA_Fire(NA_IsSolo and W_TargetCanAttack(), '45477', NA_Target) --冰冷触摸

      )then return true; end
    elseif(NA_ProfileNo == 2)then --Dual-Wield Frost
      
      if(false
					or NA_Fire(not W_HasBuff(NA_Player, 57330, true), '57330', NA_Player) --寒冬号角
					or NA_Fire(NA_IsSolo and NA_isUsableTalentSpell(5,3) and W_HPlevel(NA_Player) < 0.7, '119975', NA_Player) --符能转换
					or NA_Fire(NA_IsSolo and W_TargetCanAttack(), '45477', NA_Target) --冰冷触摸

      )then return true; end
    elseif(NA_ProfileNo == 3)then --Unholy
      
      if(false

      )then return true; end
    end
  end
  return false;
end
