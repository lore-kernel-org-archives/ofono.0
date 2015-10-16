Content-Type: multipart/mixed; boundary="===============4598211993617783649=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 3/3 v3] hfp_ag_bluez5: use codec negotiation
Date: Fri, 16 Oct 2015 08:00:00 +0200
Message-ID: <1444975200-19682-3-git-send-email-simon.fels@canonical.com>
In-Reply-To: <1444975200-19682-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4598211993617783649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c | 56 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 3aca792..c5abff0 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -38,6 +38,11 @@
 #include <ofono/modem.h>
 #include <ofono/handsfree-audio.h>
 =

+typedef struct GAtChat GAtChat;
+typedef struct GAtResult GAtResult;
+
+#include "drivers/atmodem/atutil.h"
+
 #include "hfp.h"
 #include "bluez5.h"
 #include "bluetooth.h"
@@ -69,12 +74,59 @@ static void hfp_card_remove(struct ofono_handsfree_card=
 *card)
 	DBG("");
 }
 =

+static void codec_negotiation_done_cb(int err, void *data)
+{
+	struct cb_data *cbd =3D data;
+	ofono_handsfree_card_connect_cb_t cb =3D cbd->cb;
+
+	DBG("err %d", err);
+
+	if (err < 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		goto done;
+	}
+
+	/*
+	 * We don't have anything to do at this point as when the
+	 * codec negotiation succeeded the emulator internally
+	 * already triggered the SCO connection setup of the
+	 * handsfree card which also takes over the processing
+	 * of the pending dbus message
+	 */
+
+done:
+	g_free(cbd);
+}
+
 static void hfp_card_connect(struct ofono_handsfree_card *card,
 					ofono_handsfree_card_connect_cb_t cb,
 					void *data)
 {
+	int err;
+	struct ofono_emulator *em =3D ofono_handsfree_card_get_data(card);
+	struct cb_data *cbd;
+
 	DBG("");
-	ofono_handsfree_card_connect_sco(card);
+
+	cbd =3D cb_data_new(cb, data);
+
+	/*
+	 * The emulator core will take care if the remote side supports
+	 * codec negotiation or not.
+	 */
+	err =3D ofono_emulator_start_codec_negotiation(em, 0,
+					codec_negotiation_done_cb, cbd);
+	if (err < 0) {
+		CALLBACK_WITH_FAILURE(cb, data);
+
+		g_free(cbd);
+		return;
+	}
+
+	/*
+	 * We hand over to the emulator core here to establish the
+	 * SCO connection once the codec is negotiated
+	 * */
 }
 =

 static void hfp_sco_connected_hint(struct ofono_handsfree_card *card)
@@ -208,6 +260,8 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 					OFONO_HANDSFREE_CARD_TYPE_GATEWAY,
 					HFP_AG_DRIVER, em);
 =

+	ofono_handsfree_card_set_data(card, em);
+
 	ofono_handsfree_card_set_local(card, local);
 	ofono_handsfree_card_set_remote(card, remote);
 =

-- =

2.5.0


--===============4598211993617783649==--

