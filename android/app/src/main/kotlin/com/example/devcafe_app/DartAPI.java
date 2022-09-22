// Autogenerated from Pigeon (v4.1.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.example.devcafe_app;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class DartAPI {

  public enum PathMovementType {
    MOVE(0),
    LINE(1),
    QUADRATIC(2),
    CONIC(3),
    CUBIC(4),
    CLOSE(5),
    DONE(6);

    private int index;
    private PathMovementType(final int index) {
      this.index = index;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class PathSegment {
    private @Nullable PathMovementType type;
    public @Nullable PathMovementType getType() { return type; }
    public void setType(@Nullable PathMovementType setterArg) {
      this.type = setterArg;
    }

    private @Nullable List<double[]> points;
    public @Nullable List<double[]> getPoints() { return points; }
    public void setPoints(@Nullable List<double[]> setterArg) {
      this.points = setterArg;
    }

    public static final class Builder {
      private @Nullable PathMovementType type;
      public @NonNull Builder setType(@Nullable PathMovementType setterArg) {
        this.type = setterArg;
        return this;
      }
      private @Nullable List<double[]> points;
      public @NonNull Builder setPoints(@Nullable List<double[]> setterArg) {
        this.points = setterArg;
        return this;
      }
      public @NonNull PathSegment build() {
        PathSegment pigeonReturn = new PathSegment();
        pigeonReturn.setType(type);
        pigeonReturn.setPoints(points);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("type", type == null ? null : type.index);
      toMapResult.put("points", points);
      return toMapResult;
    }
    static @NonNull PathSegment fromMap(@NonNull Map<String, Object> map) {
      PathSegment pigeonResult = new PathSegment();
      Object type = map.get("type");
      pigeonResult.setType(type == null ? null : PathMovementType.values()[(int)type]);
      Object points = map.get("points");
      pigeonResult.setPoints((List<double[]>)points);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class Path {
    private @Nullable List<PathSegment> segments;
    public @Nullable List<PathSegment> getSegments() { return segments; }
    public void setSegments(@Nullable List<PathSegment> setterArg) {
      this.segments = setterArg;
    }

    public static final class Builder {
      private @Nullable List<PathSegment> segments;
      public @NonNull Builder setSegments(@Nullable List<PathSegment> setterArg) {
        this.segments = setterArg;
        return this;
      }
      public @NonNull Path build() {
        Path pigeonReturn = new Path();
        pigeonReturn.setSegments(segments);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("segments", segments);
      return toMapResult;
    }
    static @NonNull Path fromMap(@NonNull Map<String, Object> map) {
      Path pigeonResult = new Path();
      Object segments = map.get("segments");
      pigeonResult.setSegments((List<PathSegment>)segments);
      return pigeonResult;
    }
  }
  private static class NotchApiCodec extends StandardMessageCodec {
    public static final NotchApiCodec INSTANCE = new NotchApiCodec();
    private NotchApiCodec() {}
    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case (byte)128:         
          return Path.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)129:         
          return PathSegment.fromMap((Map<String, Object>) readValue(buffer));
        
        default:        
          return super.readValueOfType(type, buffer);
        
      }
    }
    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value)     {
      if (value instanceof Path) {
        stream.write(128);
        writeValue(stream, ((Path) value).toMap());
      } else 
      if (value instanceof PathSegment) {
        stream.write(129);
        writeValue(stream, ((PathSegment) value).toMap());
      } else 
{
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface NotchApi {
    @Nullable Path getNotchPath();
    @NonNull Boolean hasNotch();

    /** The codec used by NotchApi. */
    static MessageCodec<Object> getCodec() {
      return NotchApiCodec.INSTANCE;
    }

    /**Sets up an instance of `NotchApi` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, NotchApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.NotchApi.getNotchPath", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              Path output = api.getNotchPath();
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.NotchApi.hasNotch", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              Boolean output = api.hasNotch();
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
  private static Map<String, Object> wrapError(Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put("details", "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorMap;
  }
}
