extends Golem

func check_state(distance: float):
	if distance < self.SLAM_RANGE:
		self.state = GolemState.START_SLAM
	elif distance > self.CHARGED_SLAM_RANGE && self.can_charged_slam:
		self.state = GolemState.START_CHARGED_SLAM
