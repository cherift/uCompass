package com.example.u_compass

import android.Manifest
import android.annotation.SuppressLint
import android.content.pm.PackageManager
import android.location.Location
import android.os.Bundle
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers
import android.util.Log
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import com.mapbox.android.core.location.LocationEngine
import com.mapbox.android.core.permissions.PermissionsManager
import io.indoorlocation.core.IndoorLocation
import io.indoorlocation.manual.ManualIndoorLocationProvider
import io.mapwize.mapwizesdk.api.ApiCallback
import io.mapwize.mapwizesdk.api.Floor
import io.mapwize.mapwizesdk.api.MapwizeObject
import io.mapwize.mapwizesdk.api.Place
import io.mapwize.mapwizesdk.map.MapOptions
import io.mapwize.mapwizesdk.map.MapwizeMap
import io.mapwize.mapwizeui.MapwizeFragment
import io.mapwize.mapwizeui.MapwizeFragmentUISettings
import io.reactivex.observers.DisposableCompletableObserver


class MapActivity : AppCompatActivity(), MapwizeFragment.OnFragmentInteractionListener {

    private var mapwizeFragment: MapwizeFragment? = null
    private var mapwizeMap: MapwizeMap? = null
    private var locationProvider: ManualIndoorLocationProvider? = null
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var permissionManager: PermissionsManager;
    private lateinit var originLocation: Location;

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
                //.followUserButtonHidden(false)
                //.floorControllerHidden(false)
                //.compassHidden(true)
                .build()
        mapwizeFragment = MapwizeFragment.newInstance(opts, uiSettings)
        val frameLayout = findViewById<FrameLayout>(R.id.fragmentContainer)
        val fm = supportFragmentManager
        val ft = fm.beginTransaction()
        ft.add(frameLayout.id, mapwizeFragment!!)
        ft.commit()

      //  setupPermissions()
        makeRequest()
        obtieneLocalizacion()
        System.out.println("YAYAYA")
        
    }

    private fun setupPermissions() {
        val permission = ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION)

        if (permission != PackageManager.PERMISSION_GRANTED) {
            System.out.println("autorise")
        }
    }

    private fun makeRequest() {
        ActivityCompat.requestPermissions(this,
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION,Manifest.permission.ACCESS_COARSE_LOCATION),
                101)
    }

    @SuppressLint("MissingPermission")
    private fun obtieneLocalizacion(){
        System.out.println("YAYAYA")
        fusedLocationClient.lastLocation
                .addOnSuccessListener { location: Location? ->
                    System.out.println("LAST LOCATION")
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

        mapwizeMap.addOnLongClickListener {
            val il = IndoorLocation("manual", it.latLngFloor.latitude,
                    it.latLngFloor.longitude,
                    it.latLngFloor.floor,
                    System.currentTimeMillis())
            this.locationProvider?.setIndoorLocation(il)
        }

        /* mapwizeMap.mapwizeApi.getPlace("5e4fb50400c03a0016b79e7b", object : ApiCallback<Place> {
            override fun onSuccess(place: Place){

                println("un truc quon peut recup dans les logs avant")

                val compositeDisposable : CompositeDisposable = CompositeDisposable()

                compositeDisposable.clear()

                compositeDisposable.add(mapwizeFragment!!.selectPlace(place, true)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(object : DisposableCompletableObserver() {

                        override fun onComplete() {
                            print("un truc qui fonctionne quoi")
                        }

                        override fun onError(e: Throwable) {
                            println("un truc ${e.message}")
                        }
                    })
                )

                println("un truc quon peut recup dans les logs")
            }

            override fun onFailure(throwable: Throwable){}

            override fun onNext(`object`: Place) { /* compiled code */
            }
        })*/
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