Content-Type: multipart/mixed; boundary="===============4477495666803741835=="
MIME-Version: 1.0
From: ANTARA BORWANKAR <antara.borwankar@intel.com>
Subject: [PATCH] stk: changes for sim toolkit initialization in rilmodem
Date: Tue, 07 Feb 2017 11:47:09 +0530
Message-ID: <1486448229-17649-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4477495666803741835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sending RIL_REQUEST_REPORT_STK_SERVICE_IS_RUNNING after
stk atom is created so that modem will inititialize
sim toolkit by sending terminal profile to sim.
---
 drivers/rilmodem/stk.c | 23 ++++++++++++++++++++++-
 plugins/ril_intel.c    |  2 ++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/rilmodem/stk.c b/drivers/rilmodem/stk.c
index c57c382..5f17f15 100644
--- a/drivers/rilmodem/stk.c
+++ b/drivers/rilmodem/stk.c
@@ -183,11 +183,31 @@ static void ril_stk_session_end_notify(struct ril_msg=
 *message,
 	ofono_stk_proactive_session_end_notify(stk);
 }
 =

+static void ril_stk_initialize_cb(struct ril_msg *message,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_stk *stk =3D cbd->cb;
+	struct stk_data *sd =3D cbd->user;
+
+	if(message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s RILD reply failure: %s",
+			g_ril_request_id_to_string(sd->ril, message->req),
+			ril_error_to_string(message->error));
+		ofono_stk_remove(stk);
+
+		return;
+	}
+
+	ofono_stk_register(stk);
+}
+
 static int ril_stk_probe(struct ofono_stk *stk, unsigned int vendor,
 				void *user)
 {
 	GRil *ril =3D user;
 	struct stk_data *data;
+	struct cb_data *cbd =3D cb_data_new(stk, NULL, data);
 =

 	data =3D g_new0(struct stk_data, 1);
 	data->ril =3D g_ril_clone(ril);
@@ -204,7 +224,8 @@ static int ril_stk_probe(struct ofono_stk *stk, unsigne=
d int vendor,
 	g_ril_register(ril, RIL_UNSOL_STK_EVENT_NOTIFY,
 					ril_stk_event_notify, stk);
 =

-	ofono_stk_register(stk);
+	g_ril_send(data->ril, RIL_REQUEST_REPORT_STK_SERVICE_IS_RUNNING, NULL,
+					ril_stk_initialize_cb, cbd, g_free);
 =

 	return 0;
 }
diff --git a/plugins/ril_intel.c b/plugins/ril_intel.c
index 06bcaa9..e644f2f 100644
--- a/plugins/ril_intel.c
+++ b/plugins/ril_intel.c
@@ -459,6 +459,8 @@ static void ril_post_sim(struct ofono_modem *modem)
 =

 	if (ofono_modem_get_boolean(modem, MODEM_PROP_LTE_CAPABLE))
 		ofono_lte_create(modem, "rilmodem", rd->ril);
+
+	ofono_stk_create(modem, 0, "rilmodem", rd->ril);
 }
 =

 static void ril_post_online(struct ofono_modem *modem)
-- =

1.9.1


--===============4477495666803741835==--

