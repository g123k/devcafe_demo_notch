package com.example.devcafe_app

import android.content.Context
import android.graphics.Path
import android.graphics.PointF
import android.graphics.RectF
import android.os.Build
import androidx.annotation.RequiresApi
import com.example.devcafe_app.DartAPI.PathSegment
import dev.romainguy.graphics.path.PathSegment.Type.*
import dev.romainguy.graphics.path.iterator
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        DartAPI.NotchApi.setup(flutterEngine.dartExecutor.binaryMessenger, DartAPIImpl(this))
    }
}

class DartAPIImpl(private val context: Context) : DartAPI.NotchApi {

    @RequiresApi(Build.VERSION_CODES.S)
    override fun getNotchPath(): DartAPI.Path? {
        if (!hasNotch()) {
            return null
        }

        return context.display?.cutout?.cutoutPath?.run {
            if (!isSquare()) {
                getPathBasedOnPoints(this)
            } else {
                getPathWithPathway(this)
            }
        }
    }

    private fun getPathWithPathway(cutoutPath: Path): DartAPI.Path {
        return cutoutPath.run {
            val segments = mutableListOf<PathSegment>()

            for (segment in iterator()) {
                segments.add(
                    PathSegment.Builder()
                        .setType(convertToDartPathSegment(segment.type))
                        .setPoints(convertToDartSegment(segment.points))
                        .build()
                )
            }

            DartAPI.Path.Builder()
                .setSegments(segments)
                .build()
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun getPathBasedOnPoints(cutoutPath: Path): DartAPI.Path {
        val path = cutoutPath.approximate(0.2f)

        val points = ArrayList<PointF>()
        for (i in path.indices step 3) {
            points.add(PointF(path[i + 1], path[i + 2]))
        }

        var finalPoints = points.filter { it.y >= 0.0f }.sortedBy { it.x }
        finalPoints = finalPoints.filterIndexed { index, pointF ->
            !(index > 0 && index < finalPoints.size - 1 && pointF.y == 0.0f)
        }.toMutableList()

        return DartAPI.Path.Builder()
            .setSegments(finalPoints.map { point ->
                val array =
                    DoubleArray(2) { if (it == 0) point.x.toDouble() else point.y.toDouble() }

                PathSegment.Builder()
                    .setType(DartAPI.PathMovementType.LINE)
                    .setPoints(listOf(array))
                    .build()

            })
            .build()
    }

    private fun convertToDartPathSegment(segment: dev.romainguy.graphics.path.PathSegment.Type): DartAPI.PathMovementType {
        return when (segment) {
            Move -> DartAPI.PathMovementType.MOVE
            Line -> DartAPI.PathMovementType.LINE
            Quadratic -> DartAPI.PathMovementType.QUADRATIC
            Conic -> DartAPI.PathMovementType.CONIC
            Cubic -> DartAPI.PathMovementType.CUBIC
            Close -> DartAPI.PathMovementType.CLOSE
            Done -> DartAPI.PathMovementType.DONE
        }
    }

    private fun convertToDartSegment(segment: Array<PointF>): MutableList<DoubleArray> {
        return segment.map { doubleArrayOf(it.x.toDouble(), it.y.toDouble()) }.toMutableList()
    }

    override fun hasNotch(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            return false
        }

        return context.display?.cutout != null
    }
}

private fun Path.isSquare(): Boolean {
    val bounds = RectF()
    computeBounds(bounds, false)
    return bounds.width() == bounds.height()
}