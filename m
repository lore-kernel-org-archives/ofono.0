Content-Type: multipart/mixed; boundary="===============5483558316499076117=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 1/3] ssn: remove SSN atom
Date: Mon, 28 Feb 2011 18:28:21 +0200
Message-ID: <63018c09eba82cb8ebe4a8ae23b071ce390cae61.1298883762.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1298883762.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5483558316499076117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/ssn.c |    6 +---
 include/ssn.h         |    9 +++----
 plugins/calypso.c     |    1 -
 plugins/g1.c          |    1 -
 plugins/huawei.c      |    1 -
 plugins/ifx.c         |    1 -
 plugins/isiusb.c      |    1 -
 plugins/linktop.c     |    1 -
 plugins/n900.c        |    1 -
 plugins/phonesim.c    |    1 -
 plugins/ste.c         |    1 -
 plugins/tc65.c        |    1 -
 plugins/u8500.c       |    1 -
 plugins/wavecom.c     |    1 -
 src/ssn.c             |   59 +++++++++++++++------------------------------=
----
 15 files changed, 24 insertions(+), 62 deletions(-)

diff --git a/drivers/atmodem/ssn.c b/drivers/atmodem/ssn.c
index b7a9df4..c927bf1 100644
--- a/drivers/atmodem/ssn.c
+++ b/drivers/atmodem/ssn.c
@@ -56,7 +56,7 @@ static void cssi_notify(GAtResult *result, gpointer user_=
data)
 	if (!g_at_result_iter_next_number(&iter, &index))
 		index =3D 0;
 =

-	ofono_ssn_cssi_notify(ssn, code1, index);
+	ofono_ssn_mo_notify(ssn, code1, index);
 }
 =

 static void cssu_notify(GAtResult *result, gpointer user_data)
@@ -93,7 +93,7 @@ static void cssu_notify(GAtResult *result, gpointer user_=
data)
 		return;
 =

 out:
-	ofono_ssn_cssu_notify(ssn, code2, index, &ph);
+	ofono_ssn_mt_notify(ssn, code2, index, &ph);
 }
 =

 static void at_ssn_initialized(gboolean ok, GAtResult *result,
@@ -104,8 +104,6 @@ static void at_ssn_initialized(gboolean ok, GAtResult *=
result,
 =

 	g_at_chat_register(chat, "+CSSI:", cssi_notify, FALSE, ssn, NULL);
 	g_at_chat_register(chat, "+CSSU:", cssu_notify, FALSE, ssn, NULL);
-
-	ofono_ssn_register(ssn);
 }
 =

 static int at_ssn_probe(struct ofono_ssn *ssn, unsigned int vendor,
diff --git a/include/ssn.h b/include/ssn.h
index d640cad..c8f3e0b 100644
--- a/include/ssn.h
+++ b/include/ssn.h
@@ -37,19 +37,18 @@ struct ofono_ssn_driver {
 };
 =

 /* SSN notifications (CSSI and CSSU).  */
-void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code, int index);
-void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code, int index,
+void ofono_ssn_mo_notify(struct ofono_ssn *ssn, int code, int index);
+void ofono_ssn_mt_notify(struct ofono_ssn *ssn, int code, int index,
 				const struct ofono_phone_number *number);
 =

 int ofono_ssn_driver_register(const struct ofono_ssn_driver *d);
 void ofono_ssn_driver_unregister(const struct ofono_ssn_driver *d);
 =

-struct ofono_ssn *ofono_ssn_create(struct ofono_modem *modem,
+struct ofono_ssn *ofono_ssn_new(struct ofono_modem *modem,
 					unsigned int vendor,
 					const char *driver, void *data);
 =

-void ofono_ssn_register(struct ofono_ssn *ssn);
-void ofono_ssn_remove(struct ofono_ssn *ssn);
+void ofono_ssn_free(struct ofono_ssn *ssn);
 =

 void ofono_ssn_set_data(struct ofono_ssn *ssn, void *data);
 void *ofono_ssn_get_data(struct ofono_ssn *ssn);
diff --git a/plugins/calypso.c b/plugins/calypso.c
index 0e29256..9c1b449 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -534,7 +534,6 @@ static void calypso_post_sim(struct ofono_modem *modem)
 				data->dlcs[NETREG_DLC]);
 	ofono_call_meter_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_barring_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
-	ofono_ssn_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_volume_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 =

 	mw =3D ofono_message_waiting_create(modem);
diff --git a/plugins/g1.c b/plugins/g1.c
index 22bacdc..bccde13 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -184,7 +184,6 @@ static void g1_post_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "atmodem", chat);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
-	ofono_ssn_create(modem, 0, "atmodem", chat);
 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem", chat);
 	ofono_phonebook_create(modem, 0, "atmodem", chat);
 =

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 6f05677..5be5247 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -685,7 +685,6 @@ static void huawei_post_online(struct ofono_modem *mode=
m)
 		ofono_call_forwarding_create(modem, 0, "atmodem", data->pcui);
 		ofono_call_settings_create(modem, 0, "atmodem", data->pcui);
 		ofono_call_barring_create(modem, 0, "atmodem", data->pcui);
-		ofono_ssn_create(modem, 0, "atmodem", data->pcui);
 =

 		mw =3D ofono_message_waiting_create(modem);
 		if (mw)
diff --git a/plugins/ifx.c b/plugins/ifx.c
index 527a8c4..16a2326 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -717,7 +717,6 @@ static void ifx_post_online(struct ofono_modem *modem)
 	ofono_cbs_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_ussd_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 =

-	ofono_ssn_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_settings_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_meter_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_barring_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
diff --git a/plugins/isiusb.c b/plugins/isiusb.c
index c036604..a5edf72 100644
--- a/plugins/isiusb.c
+++ b/plugins/isiusb.c
@@ -428,7 +428,6 @@ static void isiusb_post_online(struct ofono_modem *mode=
m)
 	ofono_netreg_create(modem, 0, "wgmodem2.5", isi->modem);
 	ofono_sms_create(modem, 0, "isimodem", isi->modem);
 	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
-	ofono_ssn_create(modem, 0, "isimodem", isi->modem);
 	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
diff --git a/plugins/linktop.c b/plugins/linktop.c
index 2fb3896..59367d4 100644
--- a/plugins/linktop.c
+++ b/plugins/linktop.c
@@ -313,7 +313,6 @@ static void linktop_post_online(struct ofono_modem *mod=
em)
 	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->control);
 	ofono_call_meter_create(modem, 0, "atmodem", data->control);
 	ofono_call_barring_create(modem, 0, "atmodem", data->control);
-	ofono_ssn_create(modem, 0, "atmodem", data->control);
 	ofono_call_volume_create(modem, 0, "atmodem", data->control);
 	ofono_cbs_create(modem, 0, "atmodem", data->control);
 =

diff --git a/plugins/n900.c b/plugins/n900.c
index c685266..0c92d8d 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -509,7 +509,6 @@ static void n900_post_online(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "isimodem", isi->modem);
 	ofono_sms_create(modem, 0, "isimodem", isi->modem);
 	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
-	ofono_ssn_create(modem, 0, "isimodem", isi->modem);
 	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 2b36fe0..9beb04e 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -651,7 +651,6 @@ static void phonesim_post_online(struct ofono_modem *mo=
dem)
 =

 	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-	ofono_ssn_create(modem, 0, "atmodem", data->chat);
 	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
 =

 	if (!data->calypso)
diff --git a/plugins/ste.c b/plugins/ste.c
index b786571..bcfd33d 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -430,7 +430,6 @@ static void ste_post_online(struct ofono_modem *modem)
 	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->chat);
 	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-	ofono_ssn_create(modem, 0, "atmodem", data->chat);
 	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
 	ofono_cbs_create(modem, 0, "atmodem", data->chat);
 =

diff --git a/plugins/tc65.c b/plugins/tc65.c
index f58f33d..e9d6e90 100644
--- a/plugins/tc65.c
+++ b/plugins/tc65.c
@@ -208,7 +208,6 @@ static void tc65_post_online(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "atmodem", chat);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
-	ofono_ssn_create(modem, 0, "atmodem", chat);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);
diff --git a/plugins/u8500.c b/plugins/u8500.c
index eb142b4..c46670f 100644
--- a/plugins/u8500.c
+++ b/plugins/u8500.c
@@ -460,7 +460,6 @@ static void u8500_post_online(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "wgmodem2.5", isi->modem);
 	ofono_sms_create(modem, 0, "isimodem", isi->modem);
 	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
-	ofono_ssn_create(modem, 0, "isimodem", isi->modem);
 	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
diff --git a/plugins/wavecom.c b/plugins/wavecom.c
index cb55f85..cd9c85e 100644
--- a/plugins/wavecom.c
+++ b/plugins/wavecom.c
@@ -156,7 +156,6 @@ static void wavecom_post_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "atmodem", chat);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
-	ofono_ssn_create(modem, 0, "atmodem", chat);
 	ofono_sms_create(modem, 0, "atmodem", chat);
 	ofono_phonebook_create(modem, 0, "atmodem", chat);
 =

diff --git a/src/ssn.c b/src/ssn.c
index 64c94b7..ee48fba 100644
--- a/src/ssn.c
+++ b/src/ssn.c
@@ -45,7 +45,6 @@ struct ofono_ssn {
 	struct ofono_watchlist *mt_handler_list;
 	const struct ofono_ssn_driver *driver;
 	void *driver_data;
-	struct ofono_atom *atom;
 };
 =

 static unsigned int add_ssn_handler(struct ofono_watchlist *watchlist,
@@ -112,7 +111,7 @@ gboolean __ofono_ssn_mt_watch_remove(struct ofono_ssn *=
ssn, unsigned int id)
 	return __ofono_watchlist_remove_item(ssn->mt_handler_list, id);
 }
 =

-void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code1, int index)
+void ofono_ssn_mo_notify(struct ofono_ssn *ssn, int code1, int index)
 {
 	struct ssn_handler *h;
 	GSList *l;
@@ -127,7 +126,7 @@ void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int c=
ode1, int index)
 	}
 }
 =

-void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code2, int index,
+void ofono_ssn_mt_notify(struct ofono_ssn *ssn, int code2, int index,
 				const struct ofono_phone_number *ph)
 {
 	struct ssn_handler *h;
@@ -162,33 +161,7 @@ void ofono_ssn_driver_unregister(const struct ofono_ss=
n_driver *d)
 	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

-static void ssn_unregister(struct ofono_atom *atom)
-{
-	struct ofono_ssn *ssn =3D __ofono_atom_get_data(atom);
-
-	__ofono_watchlist_free(ssn->mo_handler_list);
-	ssn->mo_handler_list =3D NULL;
-
-	__ofono_watchlist_free(ssn->mt_handler_list);
-	ssn->mt_handler_list =3D NULL;
-}
-
-static void ssn_remove(struct ofono_atom *atom)
-{
-	struct ofono_ssn *ssn =3D __ofono_atom_get_data(atom);
-
-	DBG("atom: %p", atom);
-
-	if (ssn =3D=3D NULL)
-		return;
-
-	if (ssn->driver && ssn->driver->remove)
-		ssn->driver->remove(ssn);
-
-	g_free(ssn);
-}
-
-struct ofono_ssn *ofono_ssn_create(struct ofono_modem *modem,
+struct ofono_ssn *ofono_ssn_new(struct ofono_modem *modem,
 					unsigned int vendor,
 					const char *driver,
 					void *data)
@@ -204,9 +177,6 @@ struct ofono_ssn *ofono_ssn_create(struct ofono_modem *=
modem,
 	if (ssn =3D=3D NULL)
 		return NULL;
 =

-	ssn->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_SSN,
-						ssn_remove, ssn);
-
 	for (l =3D g_drivers; l; l =3D l->next) {
 		const struct ofono_ssn_driver *drv =3D l->data;
 =

@@ -220,20 +190,27 @@ struct ofono_ssn *ofono_ssn_create(struct ofono_modem=
 *modem,
 		break;
 	}
 =

-	return ssn;
-}
-
-void ofono_ssn_register(struct ofono_ssn *ssn)
-{
 	ssn->mo_handler_list =3D __ofono_watchlist_new(g_free);
 	ssn->mt_handler_list =3D __ofono_watchlist_new(g_free);
 =

-	__ofono_atom_register(ssn->atom, ssn_unregister);
+	return ssn;
 }
 =

-void ofono_ssn_remove(struct ofono_ssn *ssn)
+void ofono_ssn_free(struct ofono_ssn *ssn)
 {
-	__ofono_atom_free(ssn->atom);
+	if (ssn =3D=3D NULL)
+		return;
+
+	if (ssn->driver && ssn->driver->remove)
+		ssn->driver->remove(ssn);
+
+	__ofono_watchlist_free(ssn->mo_handler_list);
+	ssn->mo_handler_list =3D NULL;
+
+	__ofono_watchlist_free(ssn->mt_handler_list);
+	ssn->mt_handler_list =3D NULL;
+
+	g_free(ssn);
 }
 =

 void ofono_ssn_set_data(struct ofono_ssn *ssn, void *data)
-- =

1.7.0.4


--===============5483558316499076117==--

