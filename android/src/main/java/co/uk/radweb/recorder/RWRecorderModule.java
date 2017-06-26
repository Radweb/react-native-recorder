
package co.uk.radweb.recorder;

import android.Manifest;
import android.media.MediaRecorder;
import android.provider.MediaStore;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class RWRecorderModule extends ReactContextBaseJavaModule {

	private final ReactApplicationContext reactContext;
	private final Map<String, MediaRecorderBox> recorders;

	public RWRecorderModule(ReactApplicationContext reactContext) {
		super(reactContext);
		this.reactContext = reactContext;
		this.recorders = new HashMap<>();
	}

	@Override
	public String getName() {
		return "RWRecorder";
	}

	@ReactMethod
	public void create(Promise promise) {
		UUID id = UUID.randomUUID();

		recorders.put(id.toString(), new MediaRecorderBox());

		promise.resolve(id.toString());
	}

	@ReactMethod
	public void start(String id, String path, Promise promise) {
		MediaRecorderBox box = recorders.get(id);

		if (box != null) {
			if (box.state == RecorderState.DESTROYED) {
				promise.resolve(false);
				return;
			}

			MediaRecorder recorder = box.recorder;

			if (box.state == RecorderState.STOPPED) {
				recorder.reset();
				box.state = RecorderState.CREATED;
			}

			recorder.setOutputFile(path);

			if (box.state == RecorderState.CREATED) {
				try {
					recorder.prepare();
					box.state = RecorderState.PREPARED;
				} catch (IOException e) {
					promise.reject("Failed to record", "Failed to prepare audio recording", e);
				}
			}

			if (box.state == RecorderState.PREPARED) {
				recorder.start();
				box.state = RecorderState.STARTED;
			} else if (box.state == RecorderState.STARTED) {
				promise.resolve(false);
				return;
			}

			promise.resolve(true);
		} else {
			promise.resolve(false);
		}
	}

	@ReactMethod
	public void stop(String id, Promise promise) {
		MediaRecorderBox box = recorders.get(id);

		if (box != null) {
			if (box.state == RecorderState.DESTROYED) {
				promise.resolve(false);
				return;
			}

			if (box.state == RecorderState.STARTED) {
				box.recorder.stop();
				box.state = RecorderState.STOPPED;
				promise.resolve(true);
			} else {
				promise.resolve(false);
			}
		} else {
			promise.resolve(false);
		}
	}

	@ReactMethod
	public void release(String id, Promise promise) {
		MediaRecorderBox box = recorders.get(id);

		if (box != null) {
			MediaRecorder recorder = box.recorder;

			if (box.state == RecorderState.STARTED) {
				recorder.stop();
				box.state = RecorderState.STOPPED;
			}

			recorder.release();
			box.state = RecorderState.DESTROYED;
			recorders.remove(id);
			promise.resolve(true);
		} else {
			promise.resolve(false);
		}
	}

	private enum RecorderState {
		CREATED,
		PREPARED,
		STARTED,
		STOPPED,
		DESTROYED,
	}

	private static class MediaRecorderBox {
		final MediaRecorder recorder;
		RecorderState state;

		MediaRecorderBox() {
			recorder = new MediaRecorder();
			recorder.setAudioSource(MediaRecorder.AudioSource.MIC);
			recorder.setOutputFormat(MediaRecorder.OutputFormat.AAC_ADTS);
			recorder.setAudioEncoder(MediaRecorder.AudioEncoder.AAC);

			state = RecorderState.CREATED;
		}
	}
}