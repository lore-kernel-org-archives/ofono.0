Content-Type: multipart/mixed; boundary="===============3080227877016686860=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/2] emulator: add BRSF support
Date: Wed, 23 Feb 2011 20:00:26 +0100
Message-ID: <1298487626-16827-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298487626-16827-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3080227877016686860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index ca36c0e..f024468 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -43,6 +43,9 @@ struct ofono_emulator {
 	GAtServer *server;
 	GAtPPP *ppp;
 	guint source;
+	gboolean slc;
+	int l_features;
+	int r_features;
 	int events_mode;
 	gboolean events_ind;
 	GSList *indicators;
@@ -174,6 +177,39 @@ error:
        g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static void brsf_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
+	char buf[16];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
+			goto fail;
+
+		if ((val < 0) && (val > 127))
+			goto fail;
+
+		em->r_features =3D val;
+
+		sprintf(buf, "+BRSF: %d", em->l_features);
+		g_at_server_send_info(em->server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+fail:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void cind_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -340,6 +376,7 @@ done:
 =

 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 =

+		em->slc =3D TRUE;
 		break;
 	}
 =

@@ -422,6 +459,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0, 1, 0);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_BATTERY, 0, 5, 5);
 =

+		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
 		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
 		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
 	}
@@ -464,6 +502,8 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 		return NULL;
 =

 	em->type =3D type;
+	/* TODO: Check real local features */
+	em->l_features =3D 32;
 	em->events_mode =3D 3;	/* default mode is forwarding events */
 =

 	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
@@ -545,6 +585,9 @@ static void handler_proxy(GAtServer *server, GAtServerR=
equestType type,
 	struct handler *h =3D userdata;
 	struct ofono_emulator_request req;
 =

+	if ((h->em->type =3D=3D OFONO_EMULATOR_TYPE_HFP) && !h->em->slc)
+		g_at_server_send_final(h->em->server, G_AT_SERVER_RESULT_ERROR);
+
 	switch (type) {
 	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
 		req.type =3D OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY;
@@ -647,7 +690,7 @@ void ofono_emulator_set_indicator(struct ofono_emulator=
 *em,
 =

 		ind->value =3D value;
 =

-		if (em->events_mode =3D=3D 3 && em->events_ind) {
+		if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
 			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
 			g_at_server_send_info(em->server, buf, TRUE);
 		}
-- =

1.7.1


--===============3080227877016686860==--

