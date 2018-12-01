Player
	proc
		ai(var/passive=1)
			if(Target)
				if(passive)
					attackproc(0);defenseproc(0)
				else
					if(Target in oview(_range,src))
						step_towards(src, Target)
					else
						attackproc(1);defenseproc(1)
						src.Target=(null)

					//src.attackproc(Target)
					//sleep(2)
			else
				if(!Target)
					if(get_target())
						sleep(2)
					else
						if(prob(10)&&src._wanderon)
							_wander(distance)
						sleep(10)
			spawn(2) ai(passive)


		_wander(distance=5)
			var/_spot = locate(x + rand(-distance,distance),y + rand(-distance,distance),z)
			step_towards(src,_spot,3.5)
		get_target()
			for(var/Player/P in oview(3,src))
				if(P.village != src.village)
					src.Target = P
					return src.Target
			return 0
		attackproc(var/shutdown=0)
			set background = 1
			if(!shutdown)
				for(var/Player/Enemy in oview(src,5))
					if(Enemy==src.Target)
						if(get_dist(src,Enemy)<=1)
							src.Punch(); break
				spawn(5)
					src.attackproc()
			else
				return


		defenseproc(var/shutdown=0)
			set background = 1
			if(!shutdown)
				for(var/Projectile/T in oview(5))
					if(T.owner != src&&T.owner&&T.stat_dam)
						if(prob(5*_intelligence))
							_message(view(5),"Almost!")
							//add defense tech here
							//defense dialogue
							//
				spawn(5)
					src.defenseproc()
			else
				return
