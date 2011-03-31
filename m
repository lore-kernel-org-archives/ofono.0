Content-Type: multipart/mixed; boundary="===============2089620518906006187=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/1] isimodem: remove atoms that fail to probe
Date: Thu, 31 Mar 2011 11:28:53 +0300
Message-ID: <1301560133-13303-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1301560133-13303-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2089620518906006187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/audio-settings.c       |    4 +++-
 drivers/isimodem/call-barring.c         |    4 +++-
 drivers/isimodem/call-forwarding.c      |    4 +++-
 drivers/isimodem/call-settings.c        |    4 +++-
 drivers/isimodem/cbs.c                  |    5 ++++-
 drivers/isimodem/devinfo.c              |    4 +++-
 drivers/isimodem/gprs-context.c         |    6 ++++--
 drivers/isimodem/gprs.c                 |    1 +
 drivers/isimodem/network-registration.c |    7 +++----
 drivers/isimodem/phonebook.c            |    4 +++-
 drivers/isimodem/radio-settings.c       |    4 +++-
 drivers/isimodem/sim.c                  |    1 +
 drivers/isimodem/sms.c                  |    5 ++++-
 drivers/isimodem/ussd.c                 |    4 +++-
 drivers/isimodem/voicecall.c            |    4 +++-
 15 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/isimodem/audio-settings.c b/drivers/isimodem/audio-set=
tings.c
index 65c596b..fd21dec 100644
--- a/drivers/isimodem/audio-settings.c
+++ b/drivers/isimodem/audio-settings.c
@@ -67,8 +67,10 @@ static void isi_call_verify_cb(const GIsiMessage *msg, v=
oid *data)
 	struct ofono_audio_settings *as =3D data;
 	struct audio_settings_data *asd =3D ofono_audio_settings_get_data(as);
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_audio_settings_remove(as);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index 5eb06ca..ea425e2 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -383,8 +383,10 @@ static void reachable_cb(const GIsiMessage *msg, void =
*data)
 {
 	struct ofono_call_barring *barr =3D data;
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_call_barring_remove(barr);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 52c28fe..888314d 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -410,8 +410,10 @@ static void reachable_cb(const GIsiMessage *msg, void =
*data)
 {
 	struct ofono_call_forwarding *cf =3D data;
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_call_forwarding_remove(cf);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

diff --git a/drivers/isimodem/call-settings.c b/drivers/isimodem/call-setti=
ngs.c
index 9fb17df..9270f5f 100644
--- a/drivers/isimodem/call-settings.c
+++ b/drivers/isimodem/call-settings.c
@@ -358,8 +358,10 @@ static void reachable_cb(const GIsiMessage *msg, void =
*data)
 {
 	struct ofono_call_settings *cs =3D data;
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_call_settings_remove(cs);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

diff --git a/drivers/isimodem/cbs.c b/drivers/isimodem/cbs.c
index b969c1f..11b7aff 100644
--- a/drivers/isimodem/cbs.c
+++ b/drivers/isimodem/cbs.c
@@ -133,8 +133,11 @@ static void routing_resp_cb(const GIsiMessage *msg, vo=
id *data)
 	struct ofono_cbs *cbs =3D data;
 	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
 =

-	if (cd =3D=3D NULL || !check_response_status(msg, SMS_GSM_CB_ROUTING_RESP=
))
+	if (cd =3D=3D NULL ||
+			!check_response_status(msg, SMS_GSM_CB_ROUTING_RESP)) {
+		ofono_cbs_remove(cbs);
 		return;
+	}
 =

 	g_isi_client_ntf_subscribe(cd->client, SMS_GSM_CB_ROUTING_NTF,
 					routing_ntf_cb, cbs);
diff --git a/drivers/isimodem/devinfo.c b/drivers/isimodem/devinfo.c
index 3bf05f4..62dd2d1 100644
--- a/drivers/isimodem/devinfo.c
+++ b/drivers/isimodem/devinfo.c
@@ -205,8 +205,10 @@ static void reachable_cb(const GIsiMessage *msg, void =
*data)
 {
 	struct ofono_devinfo *info =3D data;
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_devinfo_remove(info);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index 329ef21..8d68213 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -601,10 +601,12 @@ static void isi_gprs_deactivate_primary(struct ofono_=
gprs_context *gc,
 =

 static void gpds_ctx_reachable_cb(const GIsiMessage *msg, void *opaque)
 {
-	struct context_data *cd =3D opaque;
+	struct ofono_gprs_context *gc =3D opaque;
+	struct context_data *cd =3D ofono_gprs_context_get_data(gc);
 =

 	if (g_isi_msg_error(msg) < 0) {
 		DBG("unable to bootstrap gprs context driver");
+		ofono_gprs_context_remove(gc);
 		return;
 	}
 =

@@ -630,7 +632,7 @@ static int isi_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 	cd->context =3D gc;
 	ofono_gprs_context_set_data(gc, cd);
 =

-	g_isi_client_verify(cd->client, gpds_ctx_reachable_cb, cd, NULL);
+	g_isi_client_verify(cd->client, gpds_ctx_reachable_cb, gc, NULL);
 =

 	return 0;
 }
diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index ea90704..d4d7ebf 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -265,6 +265,7 @@ static void gpds_reachable_cb(const GIsiMessage *msg, v=
oid *opaque)
 =

 	if (g_isi_msg_error(msg) < 0) {
 		DBG("unable to bootstrap gprs driver");
+		ofono_gprs_remove(gprs);
 		return;
 	}
 =

diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index 8bf2423..56c3bb8 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -933,14 +933,13 @@ static void reachable_cb(const GIsiMessage *msg, void=
 *data)
 	struct ofono_netreg *netreg =3D data;
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_netreg_remove(netreg);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

-	if (nd =3D=3D NULL)
-		return;
-
 	nd->version.major =3D g_isi_msg_version_major(msg);
 	nd->version.minor =3D g_isi_msg_version_minor(msg);
 =

diff --git a/drivers/isimodem/phonebook.c b/drivers/isimodem/phonebook.c
index 1f92d37..4c68e31 100644
--- a/drivers/isimodem/phonebook.c
+++ b/drivers/isimodem/phonebook.c
@@ -294,8 +294,10 @@ static void reachable_cb(const GIsiMessage *msg, void =
*data)
 {
 	struct ofono_phonebook *pb =3D data;
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_phonebook_remove(pb);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

diff --git a/drivers/isimodem/radio-settings.c b/drivers/isimodem/radio-set=
tings.c
index 5d99213..a2a521b 100644
--- a/drivers/isimodem/radio-settings.c
+++ b/drivers/isimodem/radio-settings.c
@@ -304,8 +304,10 @@ static void gss_reachable_cb(const GIsiMessage *msg, v=
oid *opaque)
 {
 	struct ofono_radio_settings *rs =3D opaque;
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_radio_settings_remove(rs);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index a602e39..f5fa75d 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -872,6 +872,7 @@ static void sim_reachable_cb(const GIsiMessage *msg, vo=
id *data)
 =

 	if (g_isi_msg_error(msg) < 0) {
 		DBG("PN_SIM: %s", strerror(-g_isi_msg_error(msg)));
+		ofono_sim_remove(sim);
 		return;
 	}
 =

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index c90c06d..6f6b247 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -602,8 +602,10 @@ static void routing_resp_cb(const GIsiMessage *msg, vo=
id *data)
 	struct ofono_sms *sms =3D data;
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 =

-	if (!check_sms_status(msg, SMS_PP_ROUTING_RESP))
+	if (!check_sms_status(msg, SMS_PP_ROUTING_RESP)) {
+		ofono_sms_remove(sms);
 		return;
+	}
 =

 	g_isi_client_ntf_subscribe(sd->client, SMS_PP_ROUTING_NTF,
 					routing_ntf_cb, sms);
@@ -647,6 +649,7 @@ static void sms_reachable_cb(const GIsiMessage *msg, vo=
id *data)
 =

 	if (g_isi_msg_error(msg) < 0) {
 		DBG("unable to find SMS resource");
+		ofono_sms_remove(sms);
 		return;
 	}
 =

diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index f0b7392..ee5c095 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -226,8 +226,10 @@ static void ussd_reachable_cb(const GIsiMessage *msg, =
void *data)
 	struct ofono_ussd *ussd =3D data;
 	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_ussd_remove(ussd);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 92d98ab..5cbba1f 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1764,8 +1764,10 @@ static void call_verify_cb(const GIsiMessage *msg, v=
oid *data)
 	struct ofono_voicecall *ovc =3D data;
 	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		ofono_voicecall_remove(ovc);
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

-- =

1.7.1


--===============2089620518906006187==--

