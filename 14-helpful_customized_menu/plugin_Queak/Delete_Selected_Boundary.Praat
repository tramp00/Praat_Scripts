# This Praat script will delete all boundaries between the selection when annotating TextGrid
# 
# This script is distributed under the GNU General Public License.
# Copyright 2019.03.15 feelins[feipengshao@163.com]

name$ = selected$("TextGrid", 1)

editor: "TextGrid " + name$
	startTime = Get start of selection
	endTime = Get end of selection
	midTime = startTime + (endTime - startTime) / 2
endeditor

selectObject: "TextGrid " + name$
totalTiers = Get number of tiers

# 在此修改需要处理的层，只处理一层
# totalTiers = 1

for targetTier from 1 to totalTiers
	selectObject: "TextGrid " + name$
	startInterval = Get interval at time: targetTier, startTime
	endInterval = Get interval at time: targetTier, endTime

	endInterval = endInterval - 1
	startInterval = startInterval + 1
	step = endInterval - startInterval

	delStartTime = Get start time of interval: targetTier, startInterval

	for i from 1 to step
		delstartInterval = Get interval at time: targetTier, delStartTime
		Remove right boundary: targetTier, delstartInterval 
	endfor

	newInterval = Get interval at time: targetTier, midTime
	Set interval text: targetTier, newInterval, ""
endfor

selectObject: "Sound " + name$
plusObject: "TextGrid " + name$
