-----------------------------------
-- Area: Gustav Tunnel
--   NM: Guivre
-----------------------------------

local path1 =
{
116.625,0,32,
113.089,0.424,11.67,
111.115,-0.024,-10.963,
113.12,0.766,-30.586,
111.947,0.486,-45.043,
101.94,-1.608,-54.858,
91.386,-5.385,-59.574,
76.035,-9.27,-59.727,
64.718,-8.827,-62.261,
62.659,-9.074,-74.419,
59.644,-8.966,-88.864,
56.401,-9.35,-97.01,
47.164,-8.807,-99.231,
34.939,-7.75,-98.353,
25.438,-4.164,-97.243,
8.086,0.141,-89.226,
-3.67,0,-83.803,
-8.984,-0.28,-71.827,
-16.88,-0.032,-62.268,
-29.55,0.184,-50.366,
-38.684,0,-41.992,
-43.139,0.949,-26.377,
-49.357,0.392,-4.972,
-47.961,-0.419,6.441,
-37.956,0,37.011,
-31.557,-0.166,47.542,
-21.319,0,58.245,
-1.024,0,78.453,
0.411,0,85.876,
2.694,-0.02,112.788,
5.828,0.171,127.039,
16.875,0.02,136.797,
29.52,0.142,148.644,
41.322,-0.129,155.971,
54.842,-0.67,147.573,
69.975,-5.752,140.893,
86.467,-8.947,139.546,
101.231,-9.228,138.69,
104.177,-10.048,134.43,
101.73,-8.842,124.078,
100.848,-9.268,111.793,
100.429,-9.347,96.953,
100.82,-8.732,84.597,
101.926,-5.847,70.371,
106.555,-1.135,57.088,
113.324,0.161,46.75,
117.702,0,38.08
}

local path2 = {
117.702,0,38.08,
113.324,0.161,46.75,
106.555,-1.135,57.088,
101.926,-5.847,70.371,
100.82,-8.732,84.597,
100.429,-9.347,96.953,
100.848,-9.268,111.793,
101.73,-8.842,124.078,
104.177,-10.048,134.43,
101.231,-9.228,138.69,
86.467,-8.947,139.546,
69.975,-5.752,140.893,
54.842,-0.67,147.573,
41.322,-0.129,155.971,
29.52,0.142,148.644,
16.875,0.02,136.797,
5.828,0.171,127.039,
2.694,-0.02,112.788,
0.411,0,85.876,
-1.024,0,78.453,
-21.319,0,58.245,
-31.557,-0.166,47.542,
-37.956,0,37.011,
-47.961,-0.419,6.441,
-49.357,0.392,-4.972,
-43.139,0.949,-26.377,
-38.684,0,-41.992,
-29.55,0.184,-50.366,
-16.88,-0.032,-62.268,
-8.984,-0.28,-71.827,
-3.67,0,-83.803,
8.086,0.141,-89.226,
25.438,-4.164,-97.243,
34.939,-7.75,-98.353,
47.164,-8.807,-99.231,
56.401,-9.35,-97.01,
59.644,-8.966,-88.864,
62.659,-9.074,-74.419,
64.718,-8.827,-62.261,
76.035,-9.27,-59.727,
91.386,-5.385,-59.574,
101.94,-1.608,-54.858,
111.947,0.486,-45.043,
113.12,0.766,-30.586,
111.115,-0.024,-10.963,
113.089,0.424,11.67,
116.625,0,32
}

function onMobSpawn(mob)
	local ran = math.random(1,2)
	if ran == 1 then 
		mob:pathThrough(path1)
	else
		mob:pathThrough(path2)
	end
end

function onPath(mob)
    tpz.path.patrol(mob, path1)
end

function onMobRoam(mob)
    -- move to start position if not moving
    if not mob:isFollowingPath() then
        local ran = math.random(1,2)
		if ran == 1 then 
			mob:pathThrough(path1)
		else
			mob:pathThrough(path2)
		end
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(64800, 86400)) -- 18 to 24 hours
end
