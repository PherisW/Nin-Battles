Raiton
    parent_type=/Projectile
Hud/Skill/Raiton
//S rank//
//A Rank//
//B Rank//
//C Rank//
//D Rank//
    Lightning_Ball
        Stat_Usage = "ninjutsu"\
        Skill_Name = "RaitonBall"
        icon_state
        Description = ""
        Rank = "C"
        UsesNeeded = 40
        Copyable = 1
        Drain = 500
        Cooldown = 10
        Seals_Needed = 1

Player/proc
    Lightning_Ball(_nin,cooldowns,var/triggered=0,_level=1,power=0)
    var/_loc = NumToAngle2(src.dir)
    _message(view(src),"[src]","Lightning Sytle: Lightning Ball Jutsu!","purple",,"purple")
    if(Target)
        _loc = GetAngleStep(Target)
    x_projectile(src,_loc,/Raiton/Lightning_Ball,50*src.ninjutsu,1)


//Objects//
Raiton 
    Lightning_Ball
        icon = 'Raikyuu.dmi'
        New()
            var/icon/I = new(src.icon)
            src.icon = I
            ..()