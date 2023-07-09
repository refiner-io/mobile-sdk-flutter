package refiner.io.flutter.refiner_flutter;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.LinkedHashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.refiner.Refiner;
import io.refiner.RefinerConfigs;
import kotlin.Unit;
import kotlinx.serialization.json.Json;
import kotlinx.serialization.json.JsonObject;

/**
 * RefinerFlutterPlugin
 */
public class RefinerFlutterPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "refiner_flutter");
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        System.out.println(call.method);
        HashMap<String, Object> args = (HashMap<String, Object>) call.arguments;

        switch (call.method) {
            case "test":
                result.success("test return success");
                break;
            case "initialize":
                initialize(args.get("projectId").toString(), (boolean) args.get("enableDebugMode"));
                break;
            case "identifyUser":
                identifyUser(args.get("userId").toString(), (HashMap) args.get("userTraits"), (String) args.get("locale"), (String) args.get("signature"));
                break;
            case "resetUser":
                resetUser();
                break;
            case "trackEvent":
                trackEvent(args.get("eventName").toString());
                break;
            case "trackScreen":
                trackScreen(args.get("screenName").toString());
                break;
            case "ping":
                ping();
                break;
            case "showForm":
                showForm(args.get("formUuid").toString(), (boolean) args.get("force"));
                break;
            case "addToResponse":
                addToResponse(args);
                break;
            default:
                result.notImplemented();
                break;
        }
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                result.success(null);
            }
        });
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    public void initialize(String projectId, Boolean enableDebugMode) {
        if (projectId != null) {
            Refiner.INSTANCE.initialize(context, new RefinerConfigs(projectId, enableDebugMode));
            registerCallbacks();
        }
    }


    public void identifyUser(String userId, HashMap userTraits, String locale, String signature) {
        LinkedHashMap<String, Object> userTraitsMap = new LinkedHashMap<>();
        for (Object e : userTraits.keySet()) {
            userTraitsMap.put(e.toString(), userTraits.get(e.toString()));
        }
        if (userId != null) {
            Refiner.INSTANCE.identifyUser(userId, userTraitsMap, locale, signature);
        }
    }


    public void resetUser() {
        Refiner.INSTANCE.resetUser();
    }


    public void trackEvent(String eventName) {
        if (eventName != null) {
            Refiner.INSTANCE.trackEvent(eventName);
        }
    }


    public void trackScreen(String screenName) {
        if (screenName != null) {
            Refiner.INSTANCE.trackScreen(screenName);
        }
    }


    public void ping() {
        Refiner.INSTANCE.ping();
    }


    public void showForm(String formUuid, boolean force) {
        if (formUuid != null) {
            Refiner.INSTANCE.showForm(formUuid, force);
        }
    }


    public void addToResponse(HashMap contextualData) {
        HashMap<String, Object> contextualDataMap = null;
        if (contextualData != null) {
            contextualDataMap = contextualData;
        }
        Refiner.INSTANCE.addToResponse(contextualDataMap);
    }


    public void addListener(String eventName) {
        // Keep: Required for RN built in Event Emitter Calls.
    }


    public void removeListeners(Integer count) {
        // Keep: Required for RN built in Event Emitter Calls.
    }

    private void registerCallbacks() {
        Refiner.INSTANCE.onBeforeShow((formId, formConfig) -> {
            String config = Json.Default.encodeToString(JsonObject.Companion.serializer(), (JsonObject) formConfig);
            HashMap<String, Object> map = new HashMap();
            map.put("formId", formId);
            map.put("formConfig", config);
            sendEvent("onBeforeShow", map);
            return null;
        });

        Refiner.INSTANCE.onShow((formId) -> {
            HashMap map = new HashMap();
            map.put("formId", formId.toString());
            sendEvent("onShow", map);
            return null;

        });

        Refiner.INSTANCE.onClose((formId) -> {
            HashMap map = new HashMap();
            map.put("formId", formId.toString());
            sendEvent("onClose", map);
            return null;

        });

        Refiner.INSTANCE.onDismiss((formId) -> {
            HashMap map = new HashMap();
            map.put("formId", formId.toString());
            sendEvent("onDismiss", map);
            return null;

        });

        Refiner.INSTANCE.onComplete((formId, formData) -> {
            String data = Json.Default.encodeToString(JsonObject.Companion.serializer(), (JsonObject) formData);
            HashMap map = new HashMap();
            map.put("formId", formId.toString());
            map.put("formData", data);
            sendEvent("onComplete", map);
            return null;

        });

        Refiner.INSTANCE.onNavigation((formId, formElement, progress) -> {
            String element = Json.Default.encodeToString(JsonObject.Companion.serializer(), (JsonObject) formElement);
            String pro = Json.Default.encodeToString(JsonObject.Companion.serializer(), (JsonObject) progress);

            HashMap map = new HashMap();
            map.put("formId", formId);
            map.put("formElement", element);
            map.put("progress", pro);
            sendEvent("onNavigation", map);
            return null;

        });
    }

    private void sendEvent(String eventName, HashMap params) {
        try {
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    channel.invokeMethod(eventName, params);
                }
            });
//            Log.d(TAG, "Sending event " + eventName);
        } catch (Throwable t) {
            Log.e("sendEvent", t.getLocalizedMessage());
        }
    }
}
