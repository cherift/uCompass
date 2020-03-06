package com.example.u_compass

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.FrameLayout
import io.indoorlocation.core.IndoorLocation
import io.indoorlocation.manual.ManualIndoorLocationProvider
import io.mapwize.mapwizeui.MapwizeFragment
import io.mapwize.mapwizeui.MapwizeFragmentUISettings
import io.mapwize.mapwizesdk.api.Floor
import io.mapwize.mapwizesdk.api.MapwizeObject
import io.mapwize.mapwizesdk.api.Place
import io.mapwize.mapwizesdk.map.MapOptions
import io.mapwize.mapwizesdk.map.MapwizeMap
import androidx.core.content.ContextCompat.getSystemService
import android.icu.lang.UCharacter.GraphemeClusterBreak.T
import android.location.Location
import android.location.LocationListener
import android.os.Looper
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.gms.location.*
import com.mapbox.android.core.location.LocationEngine
import com.mapbox.android.core.permissions.PermissionsManager
import com.mapbox.mapboxsdk.maps.Style
import io.mapwize.mapwizesdk.api.DirectionPoint
import java.security.Permission
import java.security.Permissions


class MapActivity : AppCompatActivity(), MapwizeFragment.OnFragmentInteractionListener {

    private var mapwizeFragment: MapwizeFragment? = null
    private var mapwizeMap: MapwizeMap? = null
    private var locationProvider: ManualIndoorLocationProvider? = null
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var permissionManager: PermissionsManager;
    private lateinit var originLocation: Location;
    private lateinit var locationCallback: LocationCallback

    private var locationEngine: LocationEngine? = null;
   // private var locationLayerPlugin: LocationLayerPlugin? = null;
    private var latitude:Double = 70.0
    private var  longitude:Double = 70.0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_map_wize)

        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        // Uncomment and fill place holder to test MapwizeUI on your venue
        val opts = MapOptions.Builder()
                //.restrictContentToOrganization("YOUR_ORGANIZATION_ID")
                //.restrictContentToVenue("YOUR_VENUE_ID")
                .centerOnVenue("5e3deebd43b78c001679afc1")
                //.centerOnPlace("YOUR_PLACE_ID")
                .build()

        // Uncomment and change value to test different settings configuration
        val uiSettings = MapwizeFragmentUISettings.Builder()
                //.menuButtonHidden(true)
                .followUserButtonHidden(false)
                .floorControllerHidden(false)
                //.compassHidden(true)
                .build()
        mapwizeFragment = MapwizeFragment.newInstance(opts, uiSettings)
        val frameLayout = findViewById<FrameLayout>(R.id.fragmentContainer)
        val fm = supportFragmentManager
        val ft = fm.beginTransaction()
        ft.add(frameLayout.id, mapwizeFragment!!)
        ft.commit()

        setupPermissions()
        makeRequest()
        obtieneLocalizacion()
        System.out.println("YAYAYA")
        
    }

    private fun setupPermissions() {
        val permission = ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION)

        if (permission != PackageManager.PERMISSION_GRANTED) {
            System.out.println("autorise")
        }
    }

    private fun makeRequest() {
        ActivityCompat.requestPermissions(this,
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION,Manifest.permission.ACCESS_FINE_LOCATION),
                101)
    }

    @SuppressLint("MissingPermission")
    private fun obtieneLocalizacion(){
        System.out.println("YAYAYA")

        fusedLocationClient.lastLocation.addOnCompleteListener(this){ task ->
                var location: Location? = task.result;
                    System.out.println("LAST LOCATION"+location.toString())
                    if(location!=null) {
                        latitude = location.latitude
                        longitude = location.longitude
                    }
                }

    }

    /**
     * Fragment listener
     */
    override fun onFragmentReady(mapwizeMap: MapwizeMap) {
        this.mapwizeMap = mapwizeMap
        this.locationProvider = ManualIndoorLocationProvider()
        mapwizeMap.setIndoorLocationProvider(this.locationProvider!!)


            fusedLocationClient.lastLocation.addOnSuccessListener { location: Location? ->
                        System.out.println("LAST LOCATION"+location.toString())
                        if(location!=null) {
                            latitude = location.latitude
                            longitude = location.longitude
                        }
                    }

            val il = IndoorLocation("manual", latitude,
                    longitude,
                    0.0,
                    System.currentTimeMillis())
            this.locationProvider?.setIndoorLocation(il)

        locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult?) {
                locationResult ?: return
                for (location in locationResult.locations){
                    // Update UI with location data
                    // ...
                }
            }
        }

    }

    override fun onMenuButtonClick() {

    }

    override fun onInformationButtonClick(mapwizeObject: MapwizeObject?) {

    }

    override fun onFollowUserButtonClickWithoutLocation() {
        Log.i("Debug", "onFollowUserButtonClickWithoutLocation")
    }

    override fun shouldDisplayInformationButton(mapwizeObject: MapwizeObject?): Boolean {
        Log.i("Debug", "shouldDisplayInformationButton")
        when (mapwizeObject) {
            is Place -> return true
        }
        return false
    }

    override fun shouldDisplayFloorController(floors: MutableList<Floor>?): Boolean {
        Log.i("Debug", "shouldDisplayFloorController")
        if (floors == null || floors.size <= 1) {
            return false
        }
        return true
    }

}