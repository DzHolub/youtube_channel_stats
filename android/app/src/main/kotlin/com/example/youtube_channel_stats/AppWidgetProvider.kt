package com.example.youtube_channel_stats

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class AppWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java
                )
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                var channelTitle = widgetData.getString("channelCustomUrl", "")
                var channelViewCount = widgetData.getString("channelViewCount", "")
                var subscriberCount = widgetData.getString("subscriberCount", "")
                
                var channelTitleText = "@$channelTitle"
                var channelViewCountText = "$channelViewCount views"
                var subscriberCountText = "$subscriberCount subs"
                
                setTextViewText(R.id.title_text, channelTitleText)
                setTextViewText(R.id.total_text, channelViewCountText)
                setTextViewText(R.id.subscriber_text, subscriberCountText)

                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse("myAppWidget://refresh")
                )
                setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
