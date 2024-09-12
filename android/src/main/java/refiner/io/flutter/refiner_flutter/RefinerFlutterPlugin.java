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
import kotlin.Unit;
import kotlinx.serialization.json.Json;
import kotlinx.serialization.json.JsonObject;

public class RefinerFlutterPlugin implements FlutterPlugin, MethodCallHandler {

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
        HashMap<String, Object> args = (HashMap<String, Object>) call.arguments;

        switch (call.method) {
            case "initialize":
                initialize(args.get("projectId").toString(), (boolean) args.get("debugMode"));
                success(result);
                break;
            case "setProject":
                setProject(args.get("projectId").toString());
                break;
            case "identifyUser":
                identifyUser(args.get("userId").toString(), (HashMap) args.get("userTraits"), (String) args.get("locale"), (String) args.get("signature"));
                success(result);
                break;
            case "setUser":
                setUser(args.get("userId").toString(), (HashMap) args.get("userTraits"), (String) args.get("locale"), (String) args.get("signature"));
                success(result);
                break;
            case "resetUser":
                resetUser();
                success(result);
                break;
            case "trackEvent":
                trackEvent(args.get("eventName").toString());
                success(result);
                break;
            case "trackScreen":
                trackScreen(args.get("screenName").toString());
                success(result);
                break;
            case "ping":
                ping();
                success(result);
                break;
            case "showForm":
                showForm(args.get("formUuid").toString(), (boolean) args.get("force"));
                success(result);
                break;
            case "dismissForm":
                dismissForm(args.get("formUuid").toString());
                success(result);
                break;
            case "closeForm":
                closeForm(args.get("formUuid").toString());
                success(result);
                break;
            case "addToResponse":
                addToResponse(args);
                success(result);
                break;
            case "startSession":
                startSession();
                success(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void success(Result result) {
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

    public void initialize(String projectId, Boolean debugMode) {
        if (projectId != null) {
            Refiner.INSTANCE.initialize(context, projectId, debugMode);
            registerCallbacks();
        }
    }

    public void setProject(String projectId) {
        if (projectId != null) {
            Refiner.INSTANCE.setProject(projectId);
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

    public void setUser(String userId, HashMap userTraits, String locale, String signature) {
        LinkedHashMap<String, Object> userTraitsMap = new LinkedHashMap<>();
        for (Object e : userTraits.keySet()) {
            userTraitsMap.put(e.toString(), userTraits.get(e.toString()));
        }
        if (userId != null) {
            Refiner.INSTANCE.setUser(userId, userTraitsMap, locale, signature);
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

    public void dismissForm(String formUuid) {
        if (formUuid != null) {
            Refiner.INSTANCE.dismissForm(formUuid);
        }
    }

    public void closeForm(String formUuid) {
        if (formUuid != null) {
            Refiner.INSTANCE.closeForm(formUuid);
        }
    }

    public void addToResponse(HashMap contextualData) {
        HashMap<String, Object> contextualDataMap = null;
        if (contextualData != null) {
            contextualDataMap = contextualData;
        }
        Refiner.INSTANCE.addToResponse(contextualDataMap);
    }

    public void startSession() {
        Refiner.INSTANCE.startSession();
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
