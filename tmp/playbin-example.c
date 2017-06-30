#include <gst/gst.h>

int main(int argc, char *argv[]) {
  GstElement *pipeline, *bin, *equalizer, *convert, *sink;
  GstPad *pad, *ghost_pad;
  GstBus *bus;
  GstMessage *msg;

  /* Initialize GStreamer */
  gst_init (&argc, &argv);


  GstRegistry* reg = gst_registry_get();

  GstPluginFeature* jpegparse = gst_registry_lookup_feature(reg, "jpegparse");

  if(jpegparse == NULL) {
    printf("get jpegparse failed\n");
    return;
  }

  gst_plugin_feature_set_rank(jpegparse, GST_RANK_PRIMARY);

  gst_object_unref(jpegparse);


  GstPluginFeature* jpegdec = gst_registry_lookup_feature(reg, "jpegdec");

  if(jpegdec == NULL) {
    printf("get jpegdec failed\n");
    return;
  }

  gst_plugin_feature_set_rank(jpegdec, GST_RANK_NONE);

  gst_object_unref(jpegdec);



  /* Build the pipeline */
    pipeline = gst_parse_launch ("playbin uri=file:///home/linaro/test.jpg", NULL);

  /* Create the elements inside the sink bin */
  sink = gst_element_factory_make ("rkximagesink", "videosink");
  if (!sink) {
    g_printerr ("Not all elements could be created.\n");
    return -1;
  }

  /* Set playbin's audio sink to be our sink bin */
  g_object_set (GST_OBJECT (pipeline), "video-sink", sink, NULL);

  /* Start playing */
  gst_element_set_state (pipeline, GST_STATE_PLAYING);

  /* Wait until error or EOS */
  bus = gst_element_get_bus (pipeline);
  msg = gst_bus_timed_pop_filtered (bus, GST_CLOCK_TIME_NONE, GST_MESSAGE_ERROR | GST_MESSAGE_EOS);

  /* Free resources */
  if (msg != NULL)
    gst_message_unref (msg);
  gst_object_unref (bus);
  gst_element_set_state (pipeline, GST_STATE_NULL);
  gst_object_unref (pipeline);
  return 0;
}
