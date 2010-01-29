Content-Type: multipart/mixed; boundary="===============8967232645192018000=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: [PATCH 2/2] bluetooth: add HFP Gateway support
Date: Fri, 29 Jan 2010 12:44:26 -0200
Message-ID: <1264776266-7646-3-git-send-email-jprvita@gmail.com>
In-Reply-To: <1264776266-7646-2-git-send-email-jprvita@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8967232645192018000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jo=C3=A3o Paulo Rechi Vita <jprvita@profusion.mobi>

Create the 'Handsfree Gateway' profile for bluetooth cards and add
filters for 'org.bluez.HandsfreeGateway' to the discover module so
module-bluetooth-device is loaded with the correct profile when a
Handsfree Gateway connects to bluetoothd (in this case bluetoothd
is acting as the headset).
---
 src/modules/bluetooth/bluetooth-util.c            |   30 ++++++++++--
 src/modules/bluetooth/bluetooth-util.h            |    3 +
 src/modules/bluetooth/module-bluetooth-device.c   |   50 +++++++++++++++--=
---
 src/modules/bluetooth/module-bluetooth-discover.c |    9 +++-
 4 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/src/modules/bluetooth/bluetooth-util.c b/src/modules/bluetooth=
/bluetooth-util.c
index d3f3bfe..a873e25 100644
--- a/src/modules/bluetooth/bluetooth-util.c
+++ b/src/modules/bluetooth/bluetooth-util.c
@@ -97,6 +97,7 @@ static pa_bluetooth_device* device_new(const char *path) {
     d->audio_sink_state =3D PA_BT_AUDIO_STATE_INVALID;
     d->audio_source_state =3D PA_BT_AUDIO_STATE_INVALID;
     d->headset_state =3D PA_BT_AUDIO_STATE_INVALID;
+    d->hfgw_state =3D PA_BT_AUDIO_STATE_INVALID;
 =

     return d;
 }
@@ -122,11 +123,11 @@ static pa_bool_t device_is_audio(pa_bluetooth_device =
*d) {
     pa_assert(d);
 =

     return
-        d->device_info_valid &&
+        d->device_info_valid && (d->hfgw_state !=3D PA_BT_AUDIO_STATE_INVA=
LID ||
         (d->audio_state !=3D PA_BT_AUDIO_STATE_INVALID &&
          (d->audio_sink_state !=3D PA_BT_AUDIO_STATE_INVALID ||
           d->audio_source_state !=3D PA_BT_AUDIO_STATE_INVALID ||
-          d->headset_state !=3D PA_BT_AUDIO_STATE_INVALID));
+          d->headset_state !=3D PA_BT_AUDIO_STATE_INVALID)));
 }
 =

 static int parse_device_property(pa_bluetooth_discovery *y, pa_bluetooth_d=
evice *d, DBusMessageIter *i) {
@@ -229,7 +230,10 @@ static int parse_device_property(pa_bluetooth_discover=
y *y, pa_bluetooth_device
                     PA_LLIST_PREPEND(pa_bluetooth_uuid, d->uuids, node);
 =

                     /* Vudentz said the interfaces are here when the UUIDs=
 are announced */
-                    if (strcasecmp(HSP_HS_UUID, value) =3D=3D 0 || strcase=
cmp(HFP_HS_UUID, value) =3D=3D 0) {
+                    if (strcasecmp(HSP_AG_UUID, value) =3D=3D 0 || strcase=
cmp(HFP_AG_UUID, value) =3D=3D 0) {
+                        pa_assert_se(m =3D dbus_message_new_method_call("o=
rg.bluez", d->path, "org.bluez.HandsfreeGateway", "GetProperties"));
+                        send_and_add_to_pending(y, d, m, get_properties_re=
ply);
+                    } else if (strcasecmp(HSP_HS_UUID, value) =3D=3D 0 || =
strcasecmp(HFP_HS_UUID, value) =3D=3D 0) {
                         pa_assert_se(m =3D dbus_message_new_method_call("o=
rg.bluez", d->path, "org.bluez.Headset", "GetProperties"));
                         send_and_add_to_pending(y, d, m, get_properties_re=
ply);
                     } else if (strcasecmp(A2DP_SINK_UUID, value) =3D=3D 0)=
 {
@@ -396,9 +400,14 @@ static void get_properties_reply(DBusPendingCall *pend=
ing, void *userdata) {
             }  else if (dbus_message_has_interface(p->message, "org.bluez.=
AudioSink")) {
                 if (parse_audio_property(y, &d->audio_sink_state, &dict_i)=
 < 0)
                     goto finish;
+
             }  else if (dbus_message_has_interface(p->message, "org.bluez.=
AudioSource")) {
                 if (parse_audio_property(y, &d->audio_source_state, &dict_=
i) < 0)
                     goto finish;
+
+            }  else if (dbus_message_has_interface(p->message, "org.bluez.=
HandsfreeGateway")) {
+                if (parse_audio_property(y, &d->hfgw_state, &arg_i) < 0)
+                    goto finish;
             }
         }
 =

@@ -626,6 +635,7 @@ static DBusHandlerResult filter_cb(DBusConnection *bus,=
 DBusMessage *m, void *us
                dbus_message_is_signal(m, "org.bluez.Headset", "PropertyCha=
nged") ||
                dbus_message_is_signal(m, "org.bluez.AudioSink", "PropertyC=
hanged") ||
                dbus_message_is_signal(m, "org.bluez.AudioSource", "Propert=
yChanged") ||
+               dbus_message_is_signal(m, "org.bluez.HandsfreeGateway", "Pr=
opertyChanged") ||
                dbus_message_is_signal(m, "org.bluez.Device", "PropertyChan=
ged")) {
 =

         pa_bluetooth_device *d;
@@ -653,9 +663,14 @@ static DBusHandlerResult filter_cb(DBusConnection *bus=
, DBusMessage *m, void *us
             }  else if (dbus_message_has_interface(m, "org.bluez.AudioSink=
")) {
                 if (parse_audio_property(y, &d->audio_sink_state, &arg_i) =
< 0)
                     goto fail;
+
             }  else if (dbus_message_has_interface(m, "org.bluez.AudioSour=
ce")) {
                 if (parse_audio_property(y, &d->audio_source_state, &arg_i=
) < 0)
                     goto fail;
+
+            }  else if (dbus_message_has_interface(m, "org.bluez.Handsfree=
Gateway")) {
+                if (parse_audio_property(y, &d->hfgw_state, &arg_i) < 0)
+                    goto fail;
             }
 =

             run_callback(y, d, FALSE);
@@ -672,6 +687,7 @@ static DBusHandlerResult filter_cb(DBusConnection *bus,=
 DBusMessage *m, void *us
             d->audio_sink_state =3D PA_BT_AUDIO_STATE_DISCONNECTED;
             d->audio_source_state =3D PA_BT_AUDIO_STATE_DISCONNECTED;
             d->headset_state =3D PA_BT_AUDIO_STATE_DISCONNECTED;
+            d->hfgw_state =3D PA_BT_AUDIO_STATE_DISCONNECTED;
 =

             run_callback(y, d, FALSE);
         }
@@ -801,7 +817,9 @@ pa_bluetooth_discovery* pa_bluetooth_discovery_get(pa_c=
ore *c) {
                 "type=3D'signal',sender=3D'org.bluez',interface=3D'org.blu=
ez.Audio',member=3D'PropertyChanged'",
                 "type=3D'signal',sender=3D'org.bluez',interface=3D'org.blu=
ez.Headset',member=3D'PropertyChanged'",
                 "type=3D'signal',sender=3D'org.bluez',interface=3D'org.blu=
ez.AudioSink',member=3D'PropertyChanged'",
-                "type=3D'signal',sender=3D'org.bluez',interface=3D'org.blu=
ez.AudioSource',member=3D'PropertyChanged'", NULL) < 0) {
+                "type=3D'signal',sender=3D'org.bluez',interface=3D'org.blu=
ez.AudioSource',member=3D'PropertyChanged'",
+                "type=3D'signal',sender=3D'org.bluez',interface=3D'org.blu=
ez.HandsfreeGateway',member=3D'PropertyChanged'",
+                NULL) < 0) {
         pa_log("Failed to add D-Bus matches: %s", err.message);
         goto fail;
     }
@@ -855,7 +873,9 @@ void pa_bluetooth_discovery_unref(pa_bluetooth_discover=
y *y) {
                                "type=3D'signal',sender=3D'org.bluez',inter=
face=3D'org.bluez.Audio',member=3D'PropertyChanged'",
                                "type=3D'signal',sender=3D'org.bluez',inter=
face=3D'org.bluez.Headset',member=3D'PropertyChanged'",
                                "type=3D'signal',sender=3D'org.bluez',inter=
face=3D'org.bluez.AudioSink',member=3D'PropertyChanged'",
-                               "type=3D'signal',sender=3D'org.bluez',inter=
face=3D'org.bluez.AudioSource',member=3D'PropertyChanged'", NULL);
+                               "type=3D'signal',sender=3D'org.bluez',inter=
face=3D'org.bluez.AudioSource',member=3D'PropertyChanged'",
+                               "type=3D'signal',sender=3D'org.bluez',inter=
face=3D'org.bluez.HandsfreeGateway',member=3D'PropertyChanged'",
+                               NULL);
 =

         dbus_connection_remove_filter(pa_dbus_connection_get(y->connection=
), filter_cb, y);
 =

diff --git a/src/modules/bluetooth/bluetooth-util.h b/src/modules/bluetooth=
/bluetooth-util.h
index e2a0c3d..9cee3de 100644
--- a/src/modules/bluetooth/bluetooth-util.h
+++ b/src/modules/bluetooth/bluetooth-util.h
@@ -89,6 +89,9 @@ struct pa_bluetooth_device {
 =

     /* Headset state */
     pa_bt_audio_state_t headset_state;
+
+    /* HandsfreeGateway state */
+    pa_bt_audio_state_t hfgw_state;
 };
 =

 pa_bluetooth_discovery* pa_bluetooth_discovery_get(pa_core *core);
diff --git a/src/modules/bluetooth/module-bluetooth-device.c b/src/modules/=
bluetooth/module-bluetooth-device.c
index 0ba1421..f383aa7 100644
--- a/src/modules/bluetooth/module-bluetooth-device.c
+++ b/src/modules/bluetooth/module-bluetooth-device.c
@@ -71,7 +71,7 @@ PA_MODULE_USAGE(
         "source_name=3D<name for the source> "
         "source_properties=3D<properties for the source> "
         "address=3D<address of the device> "
-        "profile=3D<a2dp|hsp> "
+        "profile=3D<a2dp|hsp|hfgw> "
         "rate=3D<sample rate> "
         "channels=3D<number of channels> "
         "path=3D<device object path> "
@@ -133,6 +133,7 @@ enum profile {
     PROFILE_A2DP,
     PROFILE_A2DP_SOURCE,
     PROFILE_HSP,
+    PROFILE_HFGW,
     PROFILE_OFF
 };
 =

@@ -316,12 +317,12 @@ static int parse_caps(struct userdata *u, uint8_t sei=
d, const struct bt_get_capa
     pa_log_debug("Payload size is %lu %lu", (unsigned long) bytes_left, (u=
nsigned long) sizeof(*codec));
 =

     if (((u->profile =3D=3D PROFILE_A2DP || u->profile =3D=3D PROFILE_A2DP=
_SOURCE) && codec->transport !=3D BT_CAPABILITIES_TRANSPORT_A2DP) ||
-        (u->profile =3D=3D PROFILE_HSP && codec->transport !=3D BT_CAPABIL=
ITIES_TRANSPORT_SCO)) {
+        ((u->profile =3D=3D PROFILE_HSP || u->profile =3D=3D PROFILE_HFGW)=
 && codec->transport !=3D BT_CAPABILITIES_TRANSPORT_SCO)) {
         pa_log_error("Got capabilities for wrong codec.");
         return -1;
     }
 =

-    if (u->profile =3D=3D PROFILE_HSP) {
+    if (u->profile =3D=3D PROFILE_HSP || u->profile =3D=3D PROFILE_HFGW) {
 =

         if (bytes_left <=3D 0 || codec->length !=3D sizeof(u->hsp.pcm_capa=
bilities))
             return -1;
@@ -399,7 +400,7 @@ static int get_caps(struct userdata *u, uint8_t seid) {
     if (u->profile =3D=3D PROFILE_A2DP || u->profile =3D=3D PROFILE_A2DP_S=
OURCE)
         msg.getcaps_req.transport =3D BT_CAPABILITIES_TRANSPORT_A2DP;
     else {
-        pa_assert(u->profile =3D=3D PROFILE_HSP);
+        pa_assert(u->profile =3D=3D PROFILE_HSP || u->profile =3D=3D PROFI=
LE_HFGW);
         msg.getcaps_req.transport =3D BT_CAPABILITIES_TRANSPORT_SCO;
     }
     msg.getcaps_req.flags =3D u->auto_connect ? BT_FLAG_AUTOCONNECT : 0;
@@ -695,7 +696,7 @@ static int set_conf(struct userdata *u) {
         if (setup_a2dp(u) < 0)
             return -1;
     } else {
-        pa_assert(u->profile =3D=3D PROFILE_HSP);
+        pa_assert(u->profile =3D=3D PROFILE_HSP || u->profile =3D=3D PROFI=
LE_HFGW);
 =

         u->sample_spec.format =3D PA_SAMPLE_S16LE;
         u->sample_spec.channels =3D 1;
@@ -987,7 +988,7 @@ static int hsp_process_render(struct userdata *u) {
     int ret =3D 0;
 =

     pa_assert(u);
-    pa_assert(u->profile =3D=3D PROFILE_HSP);
+    pa_assert(u->profile =3D=3D PROFILE_HSP || u->profile =3D=3D PROFILE_H=
FGW);
     pa_assert(u->sink);
 =

     /* First, render some data */
@@ -1052,7 +1053,7 @@ static int hsp_process_push(struct userdata *u) {
     pa_memchunk memchunk;
 =

     pa_assert(u);
-    pa_assert(u->profile =3D=3D PROFILE_HSP);
+    pa_assert(u->profile =3D=3D PROFILE_HSP || u->profile =3D=3D PROFILE_H=
FGW);
     pa_assert(u->source);
     pa_assert(u->read_smoother);
 =

@@ -1426,7 +1427,7 @@ static void thread_func(void *userdata) {
             if (pollfd && (pollfd->revents & POLLIN)) {
                 int n_read;
 =

-                if (u->profile =3D=3D PROFILE_HSP)
+                if (u->profile =3D=3D PROFILE_HSP || PROFILE_HFGW)
                     n_read =3D hsp_process_push(u);
                 else
                     n_read =3D a2dp_process_push(u);
@@ -1834,7 +1835,7 @@ static int add_source(struct userdata *u) {
         data.module =3D u->module;
         pa_source_new_data_set_sample_spec(&data, &u->sample_spec);
         pa_proplist_sets(data.proplist, "bluetooth.protocol", u->profile =
=3D=3D PROFILE_A2DP_SOURCE ? "a2dp_source" : "hsp");
-        if (u->profile =3D=3D PROFILE_HSP)
+        if ((u->profile =3D=3D PROFILE_HSP) || (u->profile =3D=3D PROFILE_=
HFGW))
             pa_proplist_sets(data.proplist, PA_PROP_DEVICE_INTENDED_ROLES,=
 "phone");
         data.card =3D u->card;
         data.name =3D get_name("source", u->modargs, u->address, &b);
@@ -1862,8 +1863,10 @@ static int add_source(struct userdata *u) {
                                     pa_bytes_to_usec(u->block_size, &u->sa=
mple_spec));
     }
 =

-    if (u->profile =3D=3D PROFILE_HSP) {
+    if (u->profile =3D=3D PROFILE_HSP || u->profile =3D=3D PROFILE_HFGW)
         pa_proplist_sets(u->source->proplist, "bluetooth.nrec", (u->hsp.pc=
m_capabilities.flags & BT_PCM_FLAG_NREC) ? "1" : "0");
+
+    if (u->profile =3D=3D PROFILE_HSP) {
         u->source->set_volume =3D source_set_volume_cb;
         u->source->n_volume_steps =3D 16;
     }
@@ -1951,12 +1954,14 @@ static int init_profile(struct userdata *u) {
         return -1;
 =

     if (u->profile =3D=3D PROFILE_A2DP ||
-        u->profile =3D=3D PROFILE_HSP)
+        u->profile =3D=3D PROFILE_HSP ||
+        u->profile =3D=3D PROFILE_HFGW)
         if (add_sink(u) < 0)
             r =3D -1;
 =

     if (u->profile =3D=3D PROFILE_HSP ||
-        u->profile =3D=3D PROFILE_A2DP_SOURCE)
+        u->profile =3D=3D PROFILE_A2DP_SOURCE ||
+        u->profile =3D=3D PROFILE_HFGW)
         if (add_source(u) < 0)
             r =3D -1;
 =

@@ -2091,6 +2096,10 @@ static int card_set_profile(pa_card *c, pa_card_prof=
ile *new_profile) {
         pa_log_warn("A2DP is not connected, refused to switch profile");
         return -PA_ERR_IO;
     }
+    else if (device->hfgw_state <=3D PA_BT_AUDIO_STATE_CONNECTED && *d =3D=
=3D PROFILE_HFGW) {
+        pa_log_warn("HandsfreeGateway is not connected, refused to switch =
profile");
+        return -PA_ERR_IO;
+    }
 =

     if (u->sink) {
         inputs =3D pa_sink_move_all_start(u->sink, NULL);
@@ -2226,6 +2235,20 @@ static int add_card(struct userdata *u, const pa_blu=
etooth_device *device) {
         pa_hashmap_put(data.profiles, p->name, p);
     }
 =

+    if (pa_bluetooth_uuid_has(device->uuids, HFP_AG_UUID)) {
+        p =3D pa_card_profile_new("hfgw", _("Handsfree Gateway"), sizeof(e=
num profile));
+        p->priority =3D 20;
+        p->n_sinks =3D 1;
+        p->n_sources =3D 1;
+        p->max_sink_channels =3D 1;
+        p->max_source_channels =3D 1;
+
+        d =3D PA_CARD_PROFILE_DATA(p);
+        *d =3D PROFILE_HFGW;
+
+        pa_hashmap_put(data.profiles, p->name, p);
+    }
+
     pa_assert(!pa_hashmap_isempty(data.profiles));
 =

     p =3D pa_card_profile_new("off", _("Off"), sizeof(enum profile));
@@ -2254,7 +2277,8 @@ static int add_card(struct userdata *u, const pa_blue=
tooth_device *device) {
     d =3D PA_CARD_PROFILE_DATA(u->card->active_profile);
 =

     if ((device->headset_state < PA_BT_AUDIO_STATE_CONNECTED && *d =3D=3D =
PROFILE_HSP) ||
-        (device->audio_sink_state < PA_BT_AUDIO_STATE_CONNECTED && *d =3D=
=3D PROFILE_A2DP)) {
+        (device->audio_sink_state < PA_BT_AUDIO_STATE_CONNECTED && *d =3D=
=3D PROFILE_A2DP) ||
+        (device->hfgw_state < PA_BT_AUDIO_STATE_CONNECTED && *d =3D=3D PRO=
FILE_HFGW)) {
         pa_log_warn("Default profile not connected, selecting off profile"=
);
         u->card->active_profile =3D pa_hashmap_get(u->card->profiles, "off=
");
         u->card->save_profile =3D FALSE;
diff --git a/src/modules/bluetooth/module-bluetooth-discover.c b/src/module=
s/bluetooth/module-bluetooth-discover.c
index 0085fa8..fd34c6f 100644
--- a/src/modules/bluetooth/module-bluetooth-discover.c
+++ b/src/modules/bluetooth/module-bluetooth-discover.c
@@ -83,8 +83,10 @@ static pa_hook_result_t load_module_for_device(pa_blueto=
oth_discovery *y, const
 =

     mi =3D pa_hashmap_get(u->hashmap, d->path);
 =

-    if (!d->dead &&
-        d->device_connected > 0 && (d->audio_state >=3D PA_BT_AUDIO_STATE_=
CONNECTED || d->audio_source_state >=3D PA_BT_AUDIO_STATE_CONNECTED)) {
+    if (!d->dead && d->device_connected > 0 &&
+        (d->audio_state >=3D PA_BT_AUDIO_STATE_CONNECTED ||
+         d->audio_source_state >=3D PA_BT_AUDIO_STATE_CONNECTED ||
+         d->hfgw_state > PA_BT_AUDIO_STATE_CONNECTED)) {
 =

         if (!mi) {
             pa_module *m =3D NULL;
@@ -119,6 +121,9 @@ static pa_hook_result_t load_module_for_device(pa_bluet=
ooth_discovery *y, const
             if (d->audio_source_state >=3D PA_BT_AUDIO_STATE_CONNECTED)
                 args =3D pa_sprintf_malloc("%s profile=3D\"a2dp_source\" a=
uto_connect=3Dno", args);
 =

+            if (d->hfgw_state > PA_BT_AUDIO_STATE_CONNECTED)
+                args =3D pa_sprintf_malloc("%s profile=3D\"hfgw\"", args);
+
             pa_log_debug("Loading module-bluetooth-device %s", args);
             m =3D pa_module_load(u->module->core, "module-bluetooth-device=
", args);
             pa_xfree(args);
-- =

1.6.3.3


--===============8967232645192018000==--

