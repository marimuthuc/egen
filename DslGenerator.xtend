/*
 * generated by Xtext 2.23.0
 */
package org.adaptiveframework.toolsupport.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.adaptiveframework.toolsupport.dsl.AdaptationPolicy
import org.adaptiveframework.toolsupport.dsl.Decreasing_Factor
import org.adaptiveframework.toolsupport.dsl.AppState
import org.adaptiveframework.toolsupport.dsl.BatteryAwareFunction
import org.adaptiveframework.toolsupport.dsl.SensingInterval
import org.adaptiveframework.toolsupport.dsl.BatteryLevel
import org.adaptiveframework.toolsupport.dsl.Threshold_Medium
import org.adaptiveframework.toolsupport.dsl.Threshold_High
import org.adaptiveframework.toolsupport.dsl.BatteryState

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class DslGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		fsa.generateFile("MainActivity.java",
			'''
			package com.batteryaware.egen;
			import android.location.Location;
			import android.os.Bundle;
			import android.util.Log;
			import android.view.View;
			import android.widget.Toast;
			import androidx.annotation.Nullable;
			import androidx.databinding.DataBindingUtil;
			import com.batteryaware.egen.databinding.ActivityMainBinding;
			import java.text.SimpleDateFormat;
			import com.google.firebase.database.DatabaseReference;
			import com.google.firebase.database.FirebaseDatabase;
			import java.util.Date;
			public class MainActivity extends BatteryAware {
			    String loc = "";
			    private String mLatitudeLabel;
			    private String mLongitudeLabel;
			    private String mLastUpdateTimeLabel;
			    private ActivityMainBinding mBinding;
			    private Location mCurrentLocation;
			    private String mLastUpdateTime;
			    private String start_string = "Start updates button";
			    private boolean start_button = true;
			    @Override
			    protected void onCreate(@Nullable Bundle savedInstanceState)
			    {
			        super.onCreate(savedInstanceState);
			        mBinding = DataBindingUtil.setContentView(this, R.layout.activity_main);
			        mLatitudeLabel = getResources().getString(R.string.latitude_label);
			        mLongitudeLabel = getResources().getString(R.string.longitude_label);
			        mLastUpdateTimeLabel = getResources().getString(R.string.last_update_time_label);
			        mBinding.percentageLabel.setText(getCurrentBatteryLevel());
			        mCurrentLocation = getLocation();
			        mLastUpdateTime = getLastLocationUpdateTime();
			    }
			    @Override
			    public void onBatteryLevelChanged() {
			        super.onBatteryLevelChanged();
			        mBinding.percentageLabel.setText(getCurrentBatteryLevel());
			        mBinding.timeRunning.setText(getCurrentUpdateInterval());
			    }
			    @Override
			    public void updateValuesFromBundle(Bundle savedInstanceState) {
			        super.updateValuesFromBundle(savedInstanceState);
			        Log.i(TAG, "Updating values from bundle");
			        if (savedInstanceState != null) {
			            start_button = savedInstanceState.getBoolean(start_string);
			            if (start_button)
			            {
			                startButton();
			            }
			            else
			            {
			                stopButton();
			            }
			            mCurrentLocation = getLocation();
			            mLastUpdateTime = getLastLocationUpdateTime();
			            updateUI();
			        }
			    }
			    public void startUpdatesButtonHandler(View view) {
			        startLocationService();
			    }
			    public void stopUpdatesButtonHandler(View view) {
			        stopLocationUpdates();
			    }
			    void stopButton()
			    {
			        mBinding.startUpdatesButton.setEnabled(false);
			        mBinding.stopUpdatesButton.setEnabled(true);
			    }
			    void startButton()
			    {
			        mBinding.startUpdatesButton.setEnabled(true);
			        mBinding.stopUpdatesButton.setEnabled(false);
			    }
			    Double latitude1;
			    Double longitude1;
			    String lat1;
			    String long1;
			    Double latitude2;
			    Double longitude2;
			    private void updateUI() {
			        if (mCurrentLocation == null) return;
			        if (mBinding.longitudeText.getText().toString().isEmpty() || mBinding.latitudeText.getText().toString().isEmpty()) {
			            latitude1 = mCurrentLocation.getLatitude();
			            longitude1 = mCurrentLocation.getLongitude();
			        } else {
			            lat1 = mBinding.latitudeText.getText().toString().substring(10);
			            long1 = mBinding.longitudeText.getText().toString().substring(11);
			            latitude1 = Double.parseDouble(lat1);
			            longitude1 = Double.parseDouble(long1);
			        }
			        mBinding.x1.setText(String.format("%s: %f", mLatitudeLabel,
			                latitude1));
			        mBinding.y1.setText(String.format("%s: %f", mLongitudeLabel,
			                longitude1));
			        latitude2 = mCurrentLocation.getLatitude();
			        longitude2 = mCurrentLocation.getLongitude();
			        double lati1 = Math.toRadians(latitude1);
			        double longi1 = Math.toRadians(longitude1);
			        double lati2 = Math.toRadians(latitude2);
			        double longi2 = Math.toRadians(longitude2);
			        double earthRadius = 6371.01;
			        total_distance += 1000 * earthRadius * Math.acos(Math.sin(lati1) * Math.sin(lati2) + Math.cos(lati1) * Math.cos(lati2) * Math.cos(longi1 - longi2));
			        mBinding.dist.setText(Double.toString(total_distance));
			        mBinding.latitudeText.setText(String.format("%s: %f", mLatitudeLabel,
			                latitude2));
			        mBinding.longitudeText.setText(String.format("%s: %f", mLongitudeLabel,
			                longitude2));
			        mBinding.x2.setText(String.format("%s: %f", mLatitudeLabel,
			                latitude2));
			        mBinding.y2.setText(String.format("%s: %f", mLongitudeLabel,
			                longitude2));
			        mBinding.lastUpdateTimeText.setText(String.format("%s: %s", mLastUpdateTimeLabel,
			                mLastUpdateTime));
			        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/M/dd HH:mm:ss");
			        String date = sdf.format(new Date());
			        System.out.println(date);
			
			        loc += String.format("%s: %f", mLatitudeLabel,
			                latitude2) + String.format("%s: %f", mLongitudeLabel,
			                longitude2) + " dist: " + total_distance + "battery: " + mBinding.percentageLabel.getText().toString();
			        FirebaseDatabase db = FirebaseDatabase.getInstance();
			        DatabaseReference reference = db.getReference(date);
			        reference.setValue(loc);
			    }
			
			    @Override
			    public void onLocationServiceStart()
			    {
			        stopButton();
			    }
			    @Override
			    public void onLocationServiceStop()
			    {
			        startButton();
			    }
			    @Override
			    public void onLocationUpdate() {
			        mCurrentLocation = getLocation();
			        mLastUpdateTime = getLastLocationUpdateTime();
			        updateUI();
			        String location_updated_message = "Location Updated:" + getCurrentUpdateInterval() ;
			        Log.i("Update Value: " , getCurrentUpdateInterval());
			        Toast.makeText(this, location_updated_message, Toast.LENGTH_SHORT).show();
			    }
			    @Override
			    public void onSaveInstanceState(Bundle savedInstanceState)
			    {
			        super.onSaveInstanceState(savedInstanceState);
			        savedInstanceState.putBoolean(start_string,start_button);
			    }
			}
			
			'''
		)
		fsa.generateFile("BatteryAware.java",
				'''
				package com.batteryaware.egen;
				
				import android.Manifest;
				import android.app.Activity;
				import android.content.BroadcastReceiver;
				import android.content.Context;
				import android.content.DialogInterface;
				import android.content.Intent;
				import android.content.IntentFilter;
				import android.content.IntentSender;
				import android.content.pm.PackageManager;
				import android.location.Location;
				import android.os.BatteryManager;
				import android.os.Bundle;
				import android.util.Log;
				import android.widget.Toast;
				import androidx.annotation.NonNull;
				import androidx.annotation.Nullable;
				import androidx.appcompat.app.AlertDialog;
				import androidx.appcompat.app.AppCompatActivity;
				import androidx.core.app.ActivityCompat;
				import androidx.core.content.ContextCompat;
				import com.google.android.gms.common.ConnectionResult;
				import com.google.android.gms.common.GoogleApiAvailability;
				import com.google.android.gms.common.api.GoogleApiClient;
				import com.google.android.gms.common.api.PendingResult;
				import com.google.android.gms.common.api.ResultCallback;
				import com.google.android.gms.common.api.Status;
				import com.google.android.gms.location.LocationListener;
				import com.google.android.gms.location.LocationRequest;
				import com.google.android.gms.location.LocationServices;
				import com.google.android.gms.location.LocationSettingsRequest;
				import com.google.android.gms.location.LocationSettingsResult;
				import com.google.android.gms.location.LocationSettingsStatusCodes;
				import java.text.DateFormat;
				import java.util.ArrayList;
				import java.util.Date;
				public class BatteryAware extends AppCompatActivity implements GoogleApiClient.ConnectionCallbacks,
				        GoogleApiClient.OnConnectionFailedListener,
				        LocationListener {
				        
				        // Add the code from the File AdaptationUtility.java here
				        	
				        @Override
				            protected void onCreate(@Nullable Bundle savedInstanceState)
				            {
				        
				                super.onCreate(savedInstanceState);
				                mLastUpdateTime = "";
				                updateValuesFromBundle(savedInstanceState);
				                buildGoogleApiClient();
				                this.registerReceiver(this.BatteryInfoReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
				            }
				            
				        // Add the code from the File LocationUtility.java here
				        
				        @Override
				            protected void onStart() {
				                super.onStart();
				                mGoogleApiClient.connect();
				            }
				            @Override
				            public void onResume() {
				                super.onResume();
				                setUpIntervalObject.inForeGround = true;
				                isPlayServicesAvailable(this);
				                this.registerReceiver(this.BatteryInfoReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
				            }
				            @Override
				            protected void onPause() {
				                super.onPause();
				                setUpIntervalObject.inForeGround = false;
				                Log.i("Running in Background: ", getCurrentUpdateInterval());
				            }
				            @Override
				            protected void onStop() {
				                super.onStop();
				                if (!setUpIntervalObject.runInBackground)
				                {
				                    stopLocationUpdates();
				                    mGoogleApiClient.disconnect();
				                }
				        
				            }
				            @Override
				            protected void onDestroy() {
				                super.onDestroy();
				            }
				        }    
				'''
			)
			
		fsa.generateFile("AdaptationUtility.java",
				'''
				    double total_distance = 0;
				    protected static final String TAG = "location-updates-sample";
				    private static  long UPDATE_INTERVAL_IN_MILLISECONDS = 13000;
				    
				    public boolean global_button = false;
				    private final static String REQUESTING_LOCATION_UPDATES_KEY = "requesting-location-updates-key";
				    private final static String LOCATION_KEY = "location-key";
				    private final static String LAST_UPDATED_TIME_STRING_KEY = "last-updated-time-string-key";
				    
				    public static final int PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION = 1;
				    private static final int REQUEST_CHECK_SETTINGS = 10;
				    public GoogleApiClient mGoogleApiClient;
				    private LocationRequest mLocationRequest;
				    private Location mCurrentLocation;
				    private String mLastUpdateTime;
				    private String percentageLabel,timeRunning;
				    
				    protected class Interval
				    {
				        protected long MIN_INTERVAL;
				        protected long STEP;
				        protected int POLICY_NUMBER;
				        protected FunctionWrap global_wrap;
				        protected final FunctionWrap LINEAR = () ->   MIN_INTERVAL+(STEP*(100-Long.parseLong(getCurrentBatteryLevel())));
				        protected final FunctionWrap EXPONENTIAL = () -> MIN_INTERVAL+((long)(Math.exp(STEP))*(100-Long.parseLong(getCurrentBatteryLevel())));
				        protected boolean runInBackground;
				        protected long MAGNITUDE = 0;
				        protected boolean inForeGround = true;
				        protected boolean isCharging;
				        protected ArrayList<Integer> Policy_array = new ArrayList<>();
				        protected ArrayList<String> AppState_array = new ArrayList<>();
				        protected ArrayList<Integer> StepCount_array = new ArrayList<>();
				        protected ArrayList<String> BatteryAwareFunction_array = new ArrayList<>();
				        protected ArrayList<Integer> SensingInterval_array = new ArrayList<>();
				        protected ArrayList<String> BatteryLevel_array = new ArrayList<>();
				        protected ArrayList<Integer> Threshold_High_array = new ArrayList<>();
				        protected ArrayList<Integer> Threshold_Medium_array = new ArrayList<>();
				        protected ArrayList<String> BatteryState_array = new ArrayList<>();
				    
				    }
				    
				    
				    protected Interval setUpIntervalObject = new Interval();
				    protected void runAppInBackground(boolean flag,long Magnitude)
				    {
				        if(Magnitude < 1) setUpIntervalObject.MAGNITUDE = 1;
				        setUpIntervalObject.MAGNITUDE = Magnitude;
				        setUpIntervalObject.runInBackground = flag;
				    }
				    protected String setUpLocationService()
				    {
				        String[] arrOfPolicies = "'''+ resource.allContents.filter(AdaptationPolicy).map[ivalue].join(', ')
				    +'''".split(", ") ;
				        String[] arrOfStepCounts = "'''+ resource.allContents.filter(Decreasing_Factor).map[ivalue].join(', ')
				    +'''".split(", ") ;
				        String[] arrOfAppStates = "'''+ resource.allContents.filter(AppState).map[value].join(', ')
				    +'''".split(", ") ;
				        String[] arrOfBatteryAwareFunctions = "'''+ resource.allContents.filter(BatteryAwareFunction).map[value].join(', ')+'''".split(", ") ;
				        String[] arrOfSensingIntervals = "'''+ resource.allContents.filter(SensingInterval).map[ivalue].join(', ')+'''".split(", ") ;
				        String[] arrOfBatteryLevels = "'''+ resource.allContents.filter(BatteryLevel).map[value].join(', ')+'''".split(", ") ;
				        String[] arrOfMediumThresholds = "'''+ resource.allContents.filter(Threshold_Medium).map[ivalue].join(', ')+'''".split(", ") ;
				        String[] arrOfHighThresholds = "'''+ resource.allContents.filter(Threshold_High).map[ivalue].join(', ')+'''".split(", ") ;
				        String[] arrOfBatteryStates = "'''+ resource.allContents.filter(BatteryState).map[value].join(', ')+'''".split(", ") ;
				    
				        for(int i=0;i<arrOfPolicies.length;i++)
				        {
				            setUpIntervalObject.Policy_array.add(Integer.parseInt(arrOfPolicies[i]));
				            setUpIntervalObject.StepCount_array.add(Integer.parseInt(arrOfStepCounts[i]));
				            setUpIntervalObject.BatteryAwareFunction_array.add(arrOfBatteryAwareFunctions[i]);
				            setUpIntervalObject.AppState_array.add(arrOfAppStates[i]);
				            setUpIntervalObject.SensingInterval_array.add(Integer.parseInt(arrOfSensingIntervals[i]));
				            setUpIntervalObject.BatteryLevel_array.add(arrOfBatteryLevels[i]);
				            setUpIntervalObject.Threshold_Medium_array.add(Integer.parseInt(arrOfMediumThresholds[i]));
				            setUpIntervalObject.Threshold_High_array.add(Integer.parseInt(arrOfHighThresholds[i]));
				            setUpIntervalObject.BatteryState_array.add(arrOfBatteryStates[i]);
				        }
				        String BatteryState,AppState,BatteryLevel;
				    
				        if(setUpIntervalObject.isCharging)
				        {
				            BatteryState = "Charging";
				        }
				        else{
				            BatteryState = "Discharging";
				        }
				        if(setUpIntervalObject.inForeGround = true)
				        {
				            AppState = "Foreground";
				        }
				        else{
				            AppState = "Background";
				        }
				        for(int i=0;i<setUpIntervalObject.Policy_array.size();i++)
				        {
				           if(Integer.parseInt(percentageLabel) >= setUpIntervalObject.Threshold_High_array.get(i))
				            {
				                BatteryLevel = "High";
				            }
				            else if(Integer.parseInt(percentageLabel) >= setUpIntervalObject.Threshold_Medium_array.get(i))
				            {
				                BatteryLevel = "Medium";
				            }
				            else{
				                BatteryLevel = "Low";
				            }
				            if(BatteryLevel.equals(setUpIntervalObject.BatteryLevel_array.get(i)))
				            {
				                if(BatteryState.equals(setUpIntervalObject.BatteryState_array.get(i)))
				                {
				                    if(AppState.equals(setUpIntervalObject.AppState_array.get(i)))
				                    {
				                        if(setUpIntervalObject.BatteryAwareFunction_array.get(i).equals("EXPONENTIAL"))
				                        {
				                            setUpIntervalObject.global_wrap = setUpIntervalObject.EXPONENTIAL;
				                        }
				                        else{
				                            setUpIntervalObject.global_wrap = setUpIntervalObject.LINEAR;
				                        }
				                        setUpIntervalObject.MIN_INTERVAL = setUpIntervalObject.SensingInterval_array.get(i);
				                        setUpIntervalObject.STEP = setUpIntervalObject.StepCount_array.get(i);
				                        setUpIntervalObject.POLICY_NUMBER = setUpIntervalObject.Policy_array.get(i);
				                        runAppInBackground  (AppState.equals("Foreground"), setUpIntervalObject.STEP);
				                        return Long.toString(setUpIntervalObject.global_wrap.execute());
				                    }
				                }
				            }
				        }
				        return "13000";
				    }
				    interface FunctionWrap
				    {
				        long execute();
				    }
				    public void onBatteryLevelChanged()
				    {
				    
				    }
				    BroadcastReceiver BatteryInfoReceiver = new BroadcastReceiver(){
				        @Override
				        public void onReceive(Context ctxt, Intent intent) {
				            int level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, 0);
				            int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS,-1);
				            boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING || status == BatteryManager.BATTERY_STATUS_FULL;
				            setUpIntervalObject.isCharging = isCharging;
				            String val = String.valueOf(level);
				            int per = Integer.parseInt(val);
				            long rem = 100 - per;
				            percentageLabel = String.valueOf(level);
				            timeRunning = setUpLocationService();
				            Log.i("Running in Foreground: ", String.valueOf(UPDATE_INTERVAL_IN_MILLISECONDS));
				            onBatteryLevelChanged();
				            if (mGoogleApiClient.isConnected() && global_button) {
				                startLocationUpdates();
				            }
				        }
				    };
				'''			
		)
		fsa.generateFile("LocationUtility.java",
				'''
				public static String getREQUESTING_LOCATION_UPDATES_KEY(){
				        return REQUESTING_LOCATION_UPDATES_KEY;
				    }
				    public static String getLOCATION_KEY(){
				        return LOCATION_KEY;
				    }
				    public String getCurrentBatteryLevel()
				    {
				        return percentageLabel;
				    }
				    public String getCurrentUpdateInterval()
				    {
				        return timeRunning;
				    }
				
				    public void updateValuesFromBundle(Bundle savedInstanceState) {
				        Log.i(TAG, "Updating values from bundle");
				        if (savedInstanceState != null) {
				            if (savedInstanceState.keySet().contains(REQUESTING_LOCATION_UPDATES_KEY)) {
				                global_button = savedInstanceState.getBoolean(
				                        REQUESTING_LOCATION_UPDATES_KEY);
				            }
				
				            if (savedInstanceState.keySet().contains(LOCATION_KEY)) {
				                mCurrentLocation = savedInstanceState.getParcelable(LOCATION_KEY);
				            }
				            if (savedInstanceState.keySet().contains(LAST_UPDATED_TIME_STRING_KEY)) {
				                mLastUpdateTime = savedInstanceState.getString(LAST_UPDATED_TIME_STRING_KEY);
				            }
				        }
				    }
				    public Location getLocation()
				    {
				        return mCurrentLocation;
				    }
				    public String getLastLocationUpdateTime()
				    {
				        return mLastUpdateTime;
				    }
				    protected synchronized void buildGoogleApiClient() {
				        Log.i(TAG, "Building GoogleApiClient");
				        mGoogleApiClient = new GoogleApiClient.Builder(this)
				                .addConnectionCallbacks(this)
				                .addOnConnectionFailedListener(this)
				                .addApi(LocationServices.API)
				                .build();
				        createLocationRequest();
				    }
				    public void createLocationRequest()
				    {
				        mLocationRequest = new LocationRequest();
				        mLocationRequest.setInterval(UPDATE_INTERVAL_IN_MILLISECONDS/2);
				        Log.i("String:",String.valueOf(UPDATE_INTERVAL_IN_MILLISECONDS));
				        mLocationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
				    }
				    public boolean isLocationServiceOn(){
				        return global_button;
				    }
				
				    public void startLocationService() {
				        if (!isPlayServicesAvailable(this)) return;
				        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
				            startLocationUpdates();
				        }
				        else {
				            if (ActivityCompat.shouldShowRequestPermissionRationale(this, android.Manifest.permission.ACCESS_FINE_LOCATION)) {
				                showRationaleDialog();
				            } else {
				                ActivityCompat.requestPermissions(this, new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION}, PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION);
				            }
				        }
				    }
				
				    public void startLocationUpdates() {
				        Log.i(TAG, "startLocationUpdates");
				
				        LocationSettingsRequest.Builder builder = new LocationSettingsRequest.Builder()
				                .addLocationRequest(mLocationRequest);
				        PendingResult<LocationSettingsResult> result =
				                LocationServices.SettingsApi.checkLocationSettings(mGoogleApiClient, builder.build());
				        result.setResultCallback(new ResultCallback<LocationSettingsResult>() {
				            @Override
				            public void onResult(@NonNull LocationSettingsResult locationSettingsResult) {
				                final Status status = locationSettingsResult.getStatus();
				
				                switch (status.getStatusCode()) {
				                    case LocationSettingsStatusCodes.SUCCESS:
				                        if (ContextCompat.checkSelfPermission(BatteryAware.this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
				                            LocationServices.FusedLocationApi.requestLocationUpdates(mGoogleApiClient, mLocationRequest, BatteryAware.this);
				                        }
				                        break;
				                    case LocationSettingsStatusCodes.RESOLUTION_REQUIRED:
				                        try {
				                            status.startResolutionForResult(BatteryAware.this, REQUEST_CHECK_SETTINGS);
				                        } catch (IntentSender.SendIntentException e) {
				                        }
				                        break;
				                    case LocationSettingsStatusCodes.SETTINGS_CHANGE_UNAVAILABLE:
				                        break;
				                }
				            }
				        });
				        global_button = true;
				        onLocationServiceStart();
				    }
				    protected void stopLocationUpdates() {
				        Log.i(TAG, "stopLocationUpdates");
				        LocationServices.FusedLocationApi.removeLocationUpdates(mGoogleApiClient, this);
				        global_button = false;
				        onLocationServiceStop();
				    }
				    public void onLocationServiceStop()
				    {
				
				    }
				    @Override
				    public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {
				        switch (requestCode) {
				            case PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION: {
				                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
				                    startLocationUpdates();
				                } else {
				                    if (!ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission.ACCESS_FINE_LOCATION)) {
				                        global_button = false;
				                        Toast.makeText(BatteryAware.this, "To enable the function of this application, please enable the location information permission of the application from the setting screen of the terminal.", Toast.LENGTH_SHORT).show();
				                    } else {
				                        showRationaleDialog();
				                    }
				                }
				                break;
				            }
				        }
				    }
				    public void onLocationServiceStart()
				    {
				
				    }
				    public void showRationaleDialog() {
				        new AlertDialog.Builder(this)
				                .setPositiveButton("To give permission", new DialogInterface.OnClickListener() {
				                    @Override
				                    public void onClick(DialogInterface dialog, int which) {
				                        ActivityCompat.requestPermissions(BatteryAware.this,
				                                new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION}, PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION);
				
				                    }
				                })
				                .setNegativeButton("don't do", new DialogInterface.OnClickListener() {
				                    @Override
				                    public void onClick(DialogInterface dialog, int which) {
				                        Toast.makeText(BatteryAware.this,"Location permission not allowed", Toast.LENGTH_SHORT).show();
				                        global_button = false;
				                    }
				                })
				                .setCancelable(false)
				                .setMessage("This app needs to allow the use of location information.")
				                .show();
				    }
				    public static boolean isPlayServicesAvailable(Context context) {
				        int resultCode = GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(context);
				        if (resultCode != ConnectionResult.SUCCESS) {
				            GoogleApiAvailability.getInstance().getErrorDialog((Activity) context, resultCode, 2).show();
				            return false;
				        }
				        return true;
				    }
				    @Override
				    public void onActivityResult(int requestCode, int resultCode, Intent data) {
				        super.onActivityResult(requestCode, resultCode, data);
				        switch (requestCode) {
				            case REQUEST_CHECK_SETTINGS:
				                switch (resultCode) {
				                    case Activity.RESULT_OK:
				                        startLocationUpdates();
				                        break;
				                    case Activity.RESULT_CANCELED:
				                        break;
				                }
				                break;
				        }
				    }
				   
				    @Override
				    public void onConnected(@Nullable Bundle bundle) {
				        Log.i(TAG, "onConnected");
				        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
				            return;
				        }
				        if (mCurrentLocation == null) {
				            mCurrentLocation = LocationServices.FusedLocationApi.getLastLocation(mGoogleApiClient);
				            mLastUpdateTime = DateFormat.getTimeInstance().format(new Date());
				        }
				        if (global_button) {
				            startLocationUpdates();
				        }
				    }
				    @Override
				    public void onLocationChanged(Location location) {
				        Log.i(TAG, "onLocationChanged");
				        mCurrentLocation = location;
				        mLastUpdateTime = DateFormat.getTimeInstance().format(new Date());
				        onLocationUpdate();
				    }
				    public void onLocationUpdate()
				    {
				
				    }
				
				    @Override
				    public void onConnectionSuspended(int i) {
				        Log.i(TAG, "Connection suspended");
				        mGoogleApiClient.connect();
				    }
				    @Override
				    public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
				        Log.i(TAG, "Connection failed: ConnectionResult.getErrorCode() = " + connectionResult.getErrorCode());
				    }
				    public void onSaveInstanceState(Bundle savedInstanceState) {
				        savedInstanceState.putBoolean(REQUESTING_LOCATION_UPDATES_KEY, global_button);
				        savedInstanceState.putParcelable(LOCATION_KEY, mCurrentLocation);
				        savedInstanceState.putString(LAST_UPDATED_TIME_STRING_KEY, mLastUpdateTime);
				        super.onSaveInstanceState(savedInstanceState);
				    }
				    @Override
				    public boolean moveTaskToBack(boolean nonRoot)
				    {
				        return super.moveTaskToBack(setUpIntervalObject.runInBackground);
				    }
				'''			
		)
	}
}

