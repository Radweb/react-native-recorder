// @flow
import { NativeModules } from 'react-native'

const { RWRecorder } = NativeModules

export default class Recorder {
	constructor() {
		console.log(RWRecorder, NativeModules)
		this.getId = RWRecorder.create()
		this.hasReleased = false
	}

	async start(path: string) {
		if (this.hasReleased) return false

		const id = await this.getId
		return RWRecorder.start(id, path)
	}

	async stop() {
		if (this.hasReleased) return false

		const id = await this.getId
		return RWRecorder.stop(id)
	}

	async release() {
		const id = await this.getId
		this.hasReleased = await RWRecorder.release(id)
		return this.hasReleased
	}
}
