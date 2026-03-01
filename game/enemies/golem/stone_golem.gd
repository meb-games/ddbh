extends Golem

func check_state(distance: float):
	if distance < self.SLAM_RANGE:
		self.state = GolemState.START_SLAM
