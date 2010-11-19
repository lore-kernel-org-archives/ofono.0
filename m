Content-Type: multipart/mixed; boundary="===============1177491116318681950=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] src: coding style fixes - rule M6
Date: Fri, 19 Nov 2010 05:57:22 -0800
Message-ID: <1290175042-8832-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1177491116318681950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/audio-settings.c  |    4 ++--
 src/call-barring.c    |    4 ++--
 src/call-forwarding.c |    4 ++--
 src/call-meter.c      |    4 ++--
 src/call-settings.c   |    4 ++--
 src/cbs.c             |   10 +++++-----
 src/dbus.c            |    4 ++--
 src/gprs.c            |    4 ++--
 src/history.c         |    2 +-
 src/modem.c           |    8 ++++----
 src/nettime.c         |    2 +-
 src/network.c         |    4 ++--
 src/phonebook.c       |   12 ++++++------
 src/radio-settings.c  |    4 ++--
 src/sim.c             |    4 ++--
 src/simfs.c           |    2 +-
 src/simutil.c         |    2 +-
 src/sms.c             |   12 ++++++------
 src/smsutil.c         |   38 +++++++++++++++++++-------------------
 src/ssn.c             |    4 ++--
 src/stk.c             |    4 ++--
 src/stkutil.c         |   20 ++++++++++----------
 src/ussd.c            |    8 ++++----
 src/util.c            |    6 +++---
 src/voicecall.c       |   10 +++++-----
 25 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/src/audio-settings.c b/src/audio-settings.c
index 0959909..bf00c54 100644
--- a/src/audio-settings.c
+++ b/src/audio-settings.c
@@ -135,7 +135,7 @@ int ofono_audio_settings_driver_register(const struct o=
fono_audio_settings_drive
 	if (!d || !d->probe)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -147,7 +147,7 @@ void ofono_audio_settings_driver_unregister(const struc=
t ofono_audio_settings_dr
 	if (!d)
 		return;
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void audio_settings_unregister(struct ofono_atom *atom)
diff --git a/src/call-barring.c b/src/call-barring.c
index f89602e..db32c0c 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -1029,7 +1029,7 @@ int ofono_call_barring_driver_register(const struct o=
fono_call_barring_driver *d
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -1038,7 +1038,7 @@ void ofono_call_barring_driver_unregister(const struc=
t ofono_call_barring_driver
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void call_barring_unregister(struct ofono_atom *atom)
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 928cda1..715ce02 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1112,7 +1112,7 @@ int ofono_call_forwarding_driver_register(const struc=
t ofono_call_forwarding_dri
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -1121,7 +1121,7 @@ void ofono_call_forwarding_driver_unregister(const st=
ruct ofono_call_forwarding_
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void call_forwarding_unregister(struct ofono_atom *atom)
diff --git a/src/call-meter.c b/src/call-meter.c
index 5199b37..568fe40 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -667,7 +667,7 @@ int ofono_call_meter_driver_register(const struct ofono=
_call_meter_driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -676,7 +676,7 @@ void ofono_call_meter_driver_unregister(const struct of=
ono_call_meter_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void call_meter_unregister(struct ofono_atom *atom)
diff --git a/src/call-settings.c b/src/call-settings.c
index 23da47e..29e8300 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -1193,7 +1193,7 @@ int ofono_call_settings_driver_register(const struct =
ofono_call_settings_driver
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -1202,7 +1202,7 @@ void ofono_call_settings_driver_unregister(const stru=
ct ofono_call_settings_driv
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void call_settings_unregister(struct ofono_atom *atom)
diff --git a/src/cbs.c b/src/cbs.c
index 1617795..50e78c2 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -565,7 +565,7 @@ int ofono_cbs_driver_register(const struct ofono_cbs_dr=
iver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -574,7 +574,7 @@ void ofono_cbs_driver_unregister(const struct ofono_cbs=
_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void cbs_unregister(struct ofono_atom *atom)
@@ -588,20 +588,20 @@ static void cbs_unregister(struct ofono_atom *atom)
 	ofono_modem_remove_interface(modem, OFONO_CELL_BROADCAST_INTERFACE);
 =

 	if (cbs->topics) {
-		g_slist_foreach(cbs->topics, (GFunc)g_free, NULL);
+		g_slist_foreach(cbs->topics, (GFunc) g_free, NULL);
 		g_slist_free(cbs->topics);
 		cbs->topics =3D NULL;
 	}
 =

 	if (cbs->new_topics) {
-		g_slist_foreach(cbs->new_topics, (GFunc)g_free, NULL);
+		g_slist_foreach(cbs->new_topics, (GFunc) g_free, NULL);
 		g_slist_free(cbs->new_topics);
 		cbs->new_topics =3D NULL;
 	}
 =

 	if (cbs->efcbmid_length) {
 		cbs->efcbmid_length =3D 0;
-		g_slist_foreach(cbs->efcbmid_contents, (GFunc)g_free, NULL);
+		g_slist_foreach(cbs->efcbmid_contents, (GFunc) g_free, NULL);
 		g_slist_free(cbs->efcbmid_contents);
 		cbs->efcbmid_contents =3D NULL;
 	}
diff --git a/src/dbus.c b/src/dbus.c
index 8a685aa..86dbdda 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -75,7 +75,7 @@ static void append_array_variant(DBusMessageIter *iter, i=
nt type, void *val)
 	DBusMessageIter variant, array;
 	char typesig[2];
 	char arraysig[3];
-	const char **str_array =3D *(const char ***)val;
+	const char **str_array =3D *(const char ***) val;
 	int i;
 =

 	arraysig[0] =3D DBUS_TYPE_ARRAY;
@@ -117,7 +117,7 @@ static void append_dict_variant(DBusMessageIter *iter, =
int type, void *val)
 	DBusMessageIter variant, array, entry;
 	char typesig[5];
 	char arraysig[6];
-	const void **val_array =3D *(const void ***)val;
+	const void **val_array =3D *(const void ***) val;
 	int i;
 =

 	arraysig[0] =3D DBUS_TYPE_ARRAY;
diff --git a/src/gprs.c b/src/gprs.c
index 0f6fb0c..3de3f2b 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2019,7 +2019,7 @@ int ofono_gprs_context_driver_register(const struct o=
fono_gprs_context_driver *d
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_context_drivers =3D g_slist_prepend(g_context_drivers, (void *)d);
+	g_context_drivers =3D g_slist_prepend(g_context_drivers, (void *) d);
 =

 	return 0;
 }
@@ -2028,7 +2028,7 @@ void ofono_gprs_context_driver_unregister(const struc=
t ofono_gprs_context_driver
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_context_drivers =3D g_slist_remove(g_context_drivers, (void *)d);
+	g_context_drivers =3D g_slist_remove(g_context_drivers, (void *) d);
 }
 =

 static void gprs_context_remove(struct ofono_atom *atom)
diff --git a/src/history.c b/src/history.c
index 0229cf5..7d3c927 100644
--- a/src/history.c
+++ b/src/history.c
@@ -255,7 +255,7 @@ int ofono_history_driver_register(const struct ofono_hi=
story_driver *driver)
 {
 	DBG("driver: %p name: %s", driver, driver->name);
 =

-	history_drivers =3D g_slist_prepend(history_drivers, (void *)driver);
+	history_drivers =3D g_slist_prepend(history_drivers, (void *) driver);
 =

 	return 0;
 }
diff --git a/src/modem.c b/src/modem.c
index 6d346c3..f4fafd6 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1059,7 +1059,7 @@ int ofono_devinfo_driver_register(const struct ofono_=
devinfo_driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_devinfo_drivers =3D g_slist_prepend(g_devinfo_drivers, (void *)d);
+	g_devinfo_drivers =3D g_slist_prepend(g_devinfo_drivers, (void *) d);
 =

 	return 0;
 }
@@ -1068,7 +1068,7 @@ void ofono_devinfo_driver_unregister(const struct ofo=
no_devinfo_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_devinfo_drivers =3D g_slist_remove(g_devinfo_drivers, (void *)d);
+	g_devinfo_drivers =3D g_slist_remove(g_devinfo_drivers, (void *) d);
 }
 =

 static void devinfo_remove(struct ofono_atom *atom)
@@ -1572,7 +1572,7 @@ int ofono_modem_driver_register(const struct ofono_mo=
dem_driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_driver_list =3D g_slist_prepend(g_driver_list, (void *)d);
+	g_driver_list =3D g_slist_prepend(g_driver_list, (void *) d);
 =

 	return 0;
 }
@@ -1584,7 +1584,7 @@ void ofono_modem_driver_unregister(const struct ofono=
_modem_driver *d)
 =

 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_driver_list =3D g_slist_remove(g_driver_list, (void *)d);
+	g_driver_list =3D g_slist_remove(g_driver_list, (void *) d);
 =

 	for (l =3D g_modem_list; l; l =3D l->next) {
 		modem =3D l->data;
diff --git a/src/nettime.c b/src/nettime.c
index b17e375..904deee 100644
--- a/src/nettime.c
+++ b/src/nettime.c
@@ -108,7 +108,7 @@ int ofono_nettime_driver_register(const struct ofono_ne=
ttime_driver *driver)
 {
 	DBG("driver: %p name: %s", driver, driver->name);
 =

-	nettime_drivers =3D g_slist_prepend(nettime_drivers, (void *)driver);
+	nettime_drivers =3D g_slist_prepend(nettime_drivers, (void *) driver);
 =

 	return 0;
 }
diff --git a/src/network.c b/src/network.c
index f1d7724..d203bee 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1646,7 +1646,7 @@ int ofono_netreg_driver_register(const struct ofono_n=
etreg_driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -1655,7 +1655,7 @@ void ofono_netreg_driver_unregister(const struct ofon=
o_netreg_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void netreg_unregister(struct ofono_atom *atom)
diff --git a/src/phonebook.c b/src/phonebook.c
index ed768bd..cae2b14 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -249,7 +249,7 @@ static void print_merged_entry(struct phonebook_person =
*person, GString *vcards)
 	vcard_printf_begin(vcards);
 	vcard_printf_text(vcards, person->text);
 =

-	g_slist_foreach(person->number_list, (GFunc)print_number, vcards);
+	g_slist_foreach(person->number_list, (GFunc) print_number, vcards);
 =

 	vcard_printf_group(vcards, person->group);
 	vcard_printf_email(vcards, person->email);
@@ -264,7 +264,7 @@ static void destroy_merged_entry(struct phonebook_perso=
n *person)
 	g_free(person->email);
 	g_free(person->sip_uri);
 =

-	g_slist_foreach(person->number_list, (GFunc)destroy_number, NULL);
+	g_slist_foreach(person->number_list, (GFunc) destroy_number, NULL);
 	g_slist_free(person->number_list);
 =

 	g_free(person);
@@ -420,9 +420,9 @@ static void export_phonebook_cb(const struct ofono_erro=
r *error, void *data)
 =

 	/* convert the collected entries that are already merged to vcard */
 	phonebook->merge_list =3D g_slist_reverse(phonebook->merge_list);
-	g_slist_foreach(phonebook->merge_list, (GFunc)print_merged_entry,
+	g_slist_foreach(phonebook->merge_list, (GFunc) print_merged_entry,
 				phonebook->vcards);
-	g_slist_foreach(phonebook->merge_list, (GFunc)destroy_merged_entry,
+	g_slist_foreach(phonebook->merge_list, (GFunc) destroy_merged_entry,
 				NULL);
 	g_slist_free(phonebook->merge_list);
 	phonebook->merge_list =3D NULL;
@@ -498,7 +498,7 @@ int ofono_phonebook_driver_register(const struct ofono_=
phonebook_driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -507,7 +507,7 @@ void ofono_phonebook_driver_unregister(const struct ofo=
no_phonebook_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void phonebook_unregister(struct ofono_atom *atom)
diff --git a/src/radio-settings.c b/src/radio-settings.c
index eb2a42d..5794221 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -377,7 +377,7 @@ int ofono_radio_settings_driver_register(const struct o=
fono_radio_settings_drive
 	if (!d || !d->probe)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -389,7 +389,7 @@ void ofono_radio_settings_driver_unregister(const struc=
t ofono_radio_settings_dr
 	if (!d)
 		return;
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void radio_settings_unregister(struct ofono_atom *atom)
diff --git a/src/sim.c b/src/sim.c
index f362565..c4af079 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2120,7 +2120,7 @@ int ofono_sim_driver_register(const struct ofono_sim_=
driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -2129,7 +2129,7 @@ void ofono_sim_driver_unregister(const struct ofono_s=
im_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void sim_unregister(struct ofono_atom *atom)
diff --git a/src/simfs.c b/src/simfs.c
index 1e71f82..5f459ab 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -98,7 +98,7 @@ void sim_fs_free(struct sim_fs *fs)
 	 * for operations still in progress
 	 */
 	if (fs->op_q) {
-		g_queue_foreach(fs->op_q, (GFunc)sim_fs_op_free, NULL);
+		g_queue_foreach(fs->op_q, (GFunc) sim_fs_op_free, NULL);
 		g_queue_free(fs->op_q);
 	}
 =

diff --git a/src/simutil.c b/src/simutil.c
index 0474d2a..58ea81d 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -813,7 +813,7 @@ static char *sim_network_name_parse(const unsigned char=
 *buffer, int length,
 			if (buffer[i] =3D=3D 0xff && buffer[i + 1] =3D=3D 0xff)
 				break;
 =

-		ret =3D g_convert((const char *)buffer, length,
+		ret =3D g_convert((const char *) buffer, length,
 					"UTF-8//TRANSLIT", "UCS-2BE",
 					NULL, NULL, NULL);
 		break;
diff --git a/src/sms.c b/src/sms.c
index d6f2a01..12988c8 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -205,7 +205,7 @@ static unsigned int add_sms_handler(struct ofono_watchl=
ist *watchlist,
 	handler->item.destroy =3D destroy;
 =

 	return __ofono_watchlist_add_item(watchlist,
-				(struct ofono_watchlist_item *)handler);
+				(struct ofono_watchlist_item *) handler);
 }
 =

 unsigned int __ofono_sms_text_watch_add(struct ofono_sms *sms,
@@ -1003,7 +1003,7 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
 	err =3D __ofono_sms_txq_submit(sms, msg_list, flags, &uuid,
 					message_queued, msg);
 =

-	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
+	g_slist_foreach(msg_list, (GFunc) g_free, NULL);
 	g_slist_free(msg_list);
 =

 	if (err < 0)
@@ -1369,13 +1369,13 @@ static void handle_deliver(struct ofono_sms *sms, c=
onst struct sms *incoming)
 			return;
 =

 		sms_dispatch(sms, sms_list);
-		g_slist_foreach(sms_list, (GFunc)g_free, NULL);
+		g_slist_foreach(sms_list, (GFunc) g_free, NULL);
 		g_slist_free(sms_list);
 =

 		return;
 	}
 =

-	l =3D g_slist_append(NULL, (void *)incoming);
+	l =3D g_slist_append(NULL, (void *) incoming);
 	sms_dispatch(sms, l);
 	g_slist_free(l);
 }
@@ -1602,7 +1602,7 @@ int ofono_sms_driver_register(const struct ofono_sms_=
driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -1611,7 +1611,7 @@ void ofono_sms_driver_unregister(const struct ofono_s=
ms_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void sms_unregister(struct ofono_atom *atom)
diff --git a/src/smsutil.c b/src/smsutil.c
index 3ec1e75..e6dbf5f 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -158,7 +158,7 @@ gboolean sms_dcs_decode(guint8 dcs, enum sms_class *cls,
 		comp =3D (dcs & 0x20) ? TRUE : FALSE;
 =

 		if (dcs & 0x10)
-			cl =3D (enum sms_class)(dcs & 0x03);
+			cl =3D (enum sms_class) (dcs & 0x03);
 		else
 			cl =3D SMS_CLASS_UNSPECIFIED;
 =

@@ -177,7 +177,7 @@ gboolean sms_dcs_decode(guint8 dcs, enum sms_class *cls,
 		else
 			ch =3D SMS_CHARSET_7BIT;
 =

-		cl =3D (enum sms_class)(dcs & 0x03);
+		cl =3D (enum sms_class) (dcs & 0x03);
 =

 		break;
 	default:
@@ -2260,7 +2260,7 @@ char *sms_decode_text(GSList *sms_list)
 								locking_shift,
 								single_shift);
 		} else {
-			const gchar *from =3D (const gchar *)(ud + taken);
+			const gchar *from =3D (const gchar *) (ud + taken);
 			/*
 			 * According to the spec: A UCS2 character shall not be
 			 * split in the middle; if the length of the User Data
@@ -2502,7 +2502,7 @@ void sms_assembly_free(struct sms_assembly *assembly)
 	for (l =3D assembly->assembly_list; l; l =3D l->next) {
 		struct sms_assembly_node *node =3D l->data;
 =

-		g_slist_foreach(node->fragment_list, (GFunc)g_free, 0);
+		g_slist_foreach(node->fragment_list, (GFunc) g_free, 0);
 		g_slist_free(node->fragment_list);
 		g_free(node);
 	}
@@ -2653,7 +2653,7 @@ void sms_assembly_expire(struct sms_assembly *assembl=
y, time_t before)
 =

 		sms_assembly_backup_free(assembly, node);
 =

-		g_slist_foreach(node->fragment_list, (GFunc)g_free, 0);
+		g_slist_foreach(node->fragment_list, (GFunc) g_free, 0);
 		g_slist_free(node->fragment_list);
 		g_free(node);
 =

@@ -2760,7 +2760,7 @@ struct status_report_assembly *status_report_assembly=
_new(const char *imsi)
 				g_new0(struct status_report_assembly, 1);
 =

 	ret->assembly_table =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-				g_free, (GDestroyNotify)g_hash_table_destroy);
+				g_free, (GDestroyNotify) g_hash_table_destroy);
 =

 	if (imsi) {
 		ret->imsi =3D imsi;
@@ -3244,7 +3244,7 @@ GSList *sms_datagram_prepare(const char *to,
 	}
 =

 	if (left > 0) {
-		g_slist_foreach(r, (GFunc)g_free, NULL);
+		g_slist_foreach(r, (GFunc) g_free, NULL);
 		g_slist_free(r);
 =

 		return NULL;
@@ -3407,7 +3407,7 @@ GSList *sms_text_prepare(const char *to, const char *=
utf8, guint16 ref,
 		g_free(ucs2_encoded);
 =

 	if (left > 0) {
-		g_slist_foreach(r, (GFunc)g_free, NULL);
+		g_slist_foreach(r, (GFunc) g_free, NULL);
 		g_slist_free(r);
 =

 		return NULL;
@@ -3446,7 +3446,7 @@ gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, e=
num sms_class *cls,
 	case 0:
 		ch =3D SMS_CHARSET_7BIT;
 		cl =3D SMS_CLASS_UNSPECIFIED;
-		lang =3D (enum cbs_language)lower;
+		lang =3D (enum cbs_language) lower;
 		break;
 	case 1:
 		if (lower > 1)
@@ -3467,7 +3467,7 @@ gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, e=
num sms_class *cls,
 =

 		ch =3D SMS_CHARSET_7BIT;
 		cl =3D SMS_CLASS_UNSPECIFIED;
-		lang =3D (enum cbs_language)dcs;
+		lang =3D (enum cbs_language) dcs;
 		break;
 	case 4:
 	case 5:
@@ -3476,21 +3476,21 @@ gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi,=
 enum sms_class *cls,
 		comp =3D (dcs & 0x20) ? TRUE : FALSE;
 =

 		if (dcs & 0x10)
-			cl =3D (enum sms_class)(dcs & 0x03);
+			cl =3D (enum sms_class) (dcs & 0x03);
 		else
 			cl =3D SMS_CLASS_UNSPECIFIED;
 =

 		if (((dcs & 0x0c) >> 2) < 3)
-			ch =3D (enum sms_charset)((dcs & 0x0c) >> 2);
+			ch =3D (enum sms_charset) ((dcs & 0x0c) >> 2);
 		else
 			return FALSE;
 =

 		break;
 	case 9:
 		udh =3D TRUE;
-		cl =3D (enum sms_class)(dcs & 0x03);
+		cl =3D (enum sms_class) (dcs & 0x03);
 		if (((dcs & 0x0c) >> 2) < 3)
-			ch =3D (enum sms_charset)((dcs & 0x0c) >> 2);
+			ch =3D (enum sms_charset) ((dcs & 0x0c) >> 2);
 		else
 			return FALSE;
 =

@@ -3505,7 +3505,7 @@ gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, e=
num sms_class *cls,
 			ch =3D SMS_CHARSET_7BIT;
 =

 		if (lower & 0x3)
-			cl =3D (enum sms_class)(lower & 0x3);
+			cl =3D (enum sms_class) (lower & 0x3);
 		else
 			cl =3D SMS_CLASS_UNSPECIFIED;
 =

@@ -3858,7 +3858,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 	if (charset =3D=3D SMS_CHARSET_7BIT)
 		utf8 =3D convert_gsm_to_utf8(buf, bufsize, NULL, NULL, 0);
 	else
-		utf8 =3D g_convert((char *)buf, bufsize, "UTF-8//TRANSLIT",
+		utf8 =3D g_convert((char *) buf, bufsize, "UTF-8//TRANSLIT",
 					"UCS-2BE", NULL, NULL, NULL);
 =

 	g_free(buf);
@@ -3897,7 +3897,7 @@ void cbs_assembly_free(struct cbs_assembly *assembly)
 	for (l =3D assembly->assembly_list; l; l =3D l->next) {
 		struct cbs_assembly_node *node =3D l->data;
 =

-		g_slist_foreach(node->pages, (GFunc)g_free, 0);
+		g_slist_foreach(node->pages, (GFunc) g_free, 0);
 		g_slist_free(node->pages);
 		g_free(node);
 	}
@@ -3977,7 +3977,7 @@ static void cbs_assembly_expire(struct cbs_assembly *=
assembly,
 		else
 			assembly->assembly_list =3D l->next;
 =

-		g_slist_foreach(node->pages, (GFunc)g_free, NULL);
+		g_slist_foreach(node->pages, (GFunc) g_free, NULL);
 		g_slist_free(node->pages);
 		g_free(node->pages);
 		tmp =3D l;
@@ -4287,7 +4287,7 @@ GSList *cbs_extract_topic_ranges(const char *ranges)
 	}
 =

 	tmp =3D cbs_optimize_ranges(ret);
-	g_slist_foreach(ret, (GFunc)g_free, NULL);
+	g_slist_foreach(ret, (GFunc) g_free, NULL);
 	g_slist_free(ret);
 =

 	return tmp;
diff --git a/src/ssn.c b/src/ssn.c
index b886dba..64c94b7 100644
--- a/src/ssn.c
+++ b/src/ssn.c
@@ -150,7 +150,7 @@ int ofono_ssn_driver_register(const struct ofono_ssn_dr=
iver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -159,7 +159,7 @@ void ofono_ssn_driver_unregister(const struct ofono_ssn=
_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void ssn_unregister(struct ofono_atom *atom)
diff --git a/src/stk.c b/src/stk.c
index 18beee6..a58513b 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2526,7 +2526,7 @@ int ofono_stk_driver_register(const struct ofono_stk_=
driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -2535,7 +2535,7 @@ void ofono_stk_driver_unregister(const struct ofono_s=
tk_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void stk_unregister(struct ofono_atom *atom)
diff --git a/src/stkutil.c b/src/stkutil.c
index cdd66bd..377ceff 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -640,7 +640,7 @@ static gboolean parse_dataobj_file_list(struct comprehe=
nsion_tlv_iter *iter,
 	return TRUE;
 =

 error:
-	g_slist_foreach(*fl, (GFunc)g_free, NULL);
+	g_slist_foreach(*fl, (GFunc) g_free, NULL);
 	g_slist_free(*fl);
 	return FALSE;
 }
@@ -2237,7 +2237,7 @@ static gboolean parse_item_list(struct comprehension_=
tlv_iter *iter,
 	if (count =3D=3D 1)
 		return TRUE;
 =

-	g_slist_foreach(list, (GFunc)destroy_stk_item, NULL);
+	g_slist_foreach(list, (GFunc) destroy_stk_item, NULL);
 	g_slist_free(list);
 	return FALSE;
 =

@@ -2358,7 +2358,7 @@ static enum stk_command_parse_result parse_dataobj(
 			minimum_set =3D FALSE;
 	}
 =

-	g_slist_foreach(entries, (GFunc)g_free, NULL);
+	g_slist_foreach(entries, (GFunc) g_free, NULL);
 	g_slist_free(entries);
 =

 	if (minimum_set =3D=3D FALSE)
@@ -2543,7 +2543,7 @@ static void destroy_setup_menu(struct stk_command *co=
mmand)
 {
 	g_free(command->setup_menu.alpha_id);
 	g_slist_foreach(command->setup_menu.items,
-				(GFunc)destroy_stk_item, NULL);
+				(GFunc) destroy_stk_item, NULL);
 	g_slist_free(command->setup_menu.items);
 }
 =

@@ -2585,7 +2585,7 @@ static void destroy_select_item(struct stk_command *c=
ommand)
 {
 	g_free(command->select_item.alpha_id);
 	g_slist_foreach(command->select_item.items,
-				(GFunc)destroy_stk_item, NULL);
+				(GFunc) destroy_stk_item, NULL);
 	g_slist_free(command->select_item.items);
 }
 =

@@ -2847,7 +2847,7 @@ static enum stk_command_parse_result parse_setup_call(
 =

 static void destroy_refresh(struct stk_command *command)
 {
-	g_slist_foreach(command->refresh.file_list, (GFunc)g_free, NULL);
+	g_slist_foreach(command->refresh.file_list, (GFunc) g_free, NULL);
 	g_slist_free(command->refresh.file_list);
 	g_free(command->refresh.alpha_id);
 }
@@ -3144,7 +3144,7 @@ static void destroy_launch_browser(struct stk_command=
 *command)
 	g_free(command->launch_browser.url);
 	g_free(command->launch_browser.bearer.array);
 	g_slist_foreach(command->launch_browser.prov_file_refs,
-				(GFunc)g_free, NULL);
+				(GFunc) g_free, NULL);
 	g_slist_free(command->launch_browser.prov_file_refs);
 	g_free(command->launch_browser.text_gateway_proxy_id);
 	g_free(command->launch_browser.alpha_id);
@@ -3448,7 +3448,7 @@ static void destroy_retrieve_mms(struct stk_command *=
command)
 {
 	g_free(command->retrieve_mms.alpha_id);
 	g_slist_foreach(command->retrieve_mms.mms_rec_files,
-						(GFunc)g_free, NULL);
+						(GFunc) g_free, NULL);
 	g_slist_free(command->retrieve_mms.mms_rec_files);
 }
 =

@@ -3492,7 +3492,7 @@ static void destroy_submit_mms(struct stk_command *co=
mmand)
 {
 	g_free(command->submit_mms.alpha_id);
 	g_slist_foreach(command->submit_mms.mms_subm_files,
-						(GFunc)g_free, NULL);
+						(GFunc) g_free, NULL);
 	g_slist_free(command->submit_mms.mms_subm_files);
 }
 =

@@ -3529,7 +3529,7 @@ static enum stk_command_parse_result parse_submit_mms(
 static void destroy_display_mms(struct stk_command *command)
 {
 	g_slist_foreach(command->display_mms.mms_subm_files,
-						(GFunc)g_free, NULL);
+						(GFunc) g_free, NULL);
 	g_slist_free(command->display_mms.mms_subm_files);
 }
 =

diff --git a/src/ussd.c b/src/ussd.c
index 59e0a49..c4de177 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -759,7 +759,7 @@ int ofono_ussd_driver_register(const struct ofono_ussd_=
driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -768,7 +768,7 @@ void ofono_ussd_driver_unregister(const struct ofono_us=
sd_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void ussd_unregister(struct ofono_atom *atom)
@@ -778,11 +778,11 @@ static void ussd_unregister(struct ofono_atom *atom)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
 =

-	g_slist_foreach(ussd->ss_control_list, (GFunc)ssc_entry_destroy, NULL);
+	g_slist_foreach(ussd->ss_control_list, (GFunc) ssc_entry_destroy, NULL);
 	g_slist_free(ussd->ss_control_list);
 	ussd->ss_control_list =3D NULL;
 =

-	g_slist_foreach(ussd->ss_passwd_list, (GFunc)ssc_entry_destroy, NULL);
+	g_slist_foreach(ussd->ss_passwd_list, (GFunc) ssc_entry_destroy, NULL);
 	g_slist_free(ussd->ss_passwd_list);
 	ussd->ss_passwd_list =3D NULL;
 =

diff --git a/src/util.c b/src/util.c
index 511683a..4421c3d 100644
--- a/src/util.c
+++ b/src/util.c
@@ -462,8 +462,8 @@ static const struct alphabet_conversion_table alphabet_=
lookup[] =3D {
 =

 static int compare_codepoints(const void *a, const void *b)
 {
-	const struct codepoint *ca =3D (const struct codepoint *)a;
-	const struct codepoint *cb =3D (const struct codepoint *)b;
+	const struct codepoint *ca =3D (const struct codepoint *) a;
+	const struct codepoint *cb =3D (const struct codepoint *) b;
 =

 	return (ca->from > cb->from) - (ca->from < cb->from);
 }
@@ -1126,7 +1126,7 @@ char *sim_string_to_utf8(const unsigned char *buffer,=
 int length)
 			if (buffer[i] =3D=3D 0xff && buffer[i + 1] =3D=3D 0xff)
 				break;
 =

-		return g_convert((char *)buffer + 1, i - 1,
+		return g_convert((char *) buffer + 1, i - 1,
 					"UTF-8//TRANSLIT", "UCS-2BE",
 					NULL, NULL, NULL);
 	case 0x81:
diff --git a/src/voicecall.c b/src/voicecall.c
index bd64432..52baec3 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1926,7 +1926,7 @@ static void set_new_ecc(struct ofono_voicecall *vc)
 {
 	int i =3D 0;
 =

-	g_slist_foreach(vc->en_list, (GFunc)g_free, NULL);
+	g_slist_foreach(vc->en_list, (GFunc) g_free, NULL);
 	g_slist_free(vc->en_list);
 	vc->en_list =3D NULL;
 =

@@ -2026,7 +2026,7 @@ int ofono_voicecall_driver_register(const struct ofon=
o_voicecall_driver *d)
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
 =

 	return 0;
 }
@@ -2035,7 +2035,7 @@ void ofono_voicecall_driver_unregister(const struct o=
fono_voicecall_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

 static void voicecall_unregister(struct ofono_atom *atom)
@@ -2077,13 +2077,13 @@ static void voicecall_remove(struct ofono_atom *ato=
m)
 		vc->driver->remove(vc);
 =

 	if (vc->en_list) {
-		g_slist_foreach(vc->en_list, (GFunc)g_free, NULL);
+		g_slist_foreach(vc->en_list, (GFunc) g_free, NULL);
 		g_slist_free(vc->en_list);
 		vc->en_list =3D NULL;
 	}
 =

 	if (vc->new_en_list) {
-		g_slist_foreach(vc->new_en_list, (GFunc)g_free, NULL);
+		g_slist_foreach(vc->new_en_list, (GFunc) g_free, NULL);
 		g_slist_free(vc->new_en_list);
 		vc->new_en_list =3D NULL;
 	}
-- =

1.7.0.4


--===============1177491116318681950==--

