package com.pushmote.android.phonegap;

import android.app.NotificationManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;

import com.pushmote.android.Pushmote;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;

public class PushmotePlugin extends CordovaPlugin {

    public static final String LOG_TAG = "PushmotePlugin";

    private static CallbackContext pushContext;

    /**
     * Gets the application context from cordova's main activity.
     * @return the application context
     */
    private Context getApplicationContext() {
        return this.cordova.getActivity().getApplicationContext();
    }

    @Override
    public boolean execute(final String action, final JSONArray data, final CallbackContext callbackContext) {
        Log.v(LOG_TAG, "execute: action=" + action);

        if ("startWithApplicationId".equals(action)) {
            pushContext = callbackContext;
            try {
                String appId = data.getJSONObject(0).getString("appId");
                Pushmote.start(Pushmote.HWProvider.ESTIMOTE,this.cordova.getActivity(),appId);
                JSONObject json = new JSONObject().put("message", "pushmote started");
                Log.v(LOG_TAG, "onRegistered: " + json.toString());
                PushmotePlugin.sendEvent(json);
            } catch (Exception e) {
                Log.e(LOG_TAG, "execute: Got Exception " + e.getMessage());
                callbackContext.error(e.getMessage());
            }
        } else {
            Log.e(LOG_TAG, "Invalid action : " + action);
            callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.INVALID_ACTION));
            return false;
        }

        return true;
    }

    public static void sendEvent(JSONObject _json) {
        PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, _json);
        pluginResult.setKeepCallback(true);
        if (pushContext != null) {
            pushContext.sendPluginResult(pluginResult);
        }
    }

    public static void sendError(String message) {
        PluginResult pluginResult = new PluginResult(PluginResult.Status.ERROR, message);
        pluginResult.setKeepCallback(true);
        if (pushContext != null) {
            pushContext.sendPluginResult(pluginResult);
        }
    }

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }

    @Override
    public void onPause(boolean multitasking) {
        super.onPause(multitasking);
        Pushmote.sendToBackground();
    }

    @Override
    public void onResume(boolean multitasking) {
        super.onResume(multitasking);
        Pushmote.bringToForeground();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }
}
