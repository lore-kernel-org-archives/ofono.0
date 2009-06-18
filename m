Content-Type: multipart/mixed; boundary="===============0142557438264379959=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Implement CallBarring::ChangePassword in AT backend.
Date: Thu, 18 Jun 2009 06:04:46 +0200
Message-ID: <1245297886-15358-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0142557438264379959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Depends on "[PATCH] Add CallBarring::ChangePassword for setting a new servi=
ce password."
---
 drivers/atmodem/call-barring.c |   45 ++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index 5d2af58..f0ba18e 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -152,9 +152,50 @@ error:
 	}
 }
 =

+static void cpwd_set_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_generic_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	dump_response("cpwd_set_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void at_call_barring_set_passwd(struct ofono_modem *modem,
+				const char *lock,
+				const char *old_passwd, const char *new_passwd,
+				ofono_generic_cb_t cb, void *data)
+{
+	struct at_data *at =3D ofono_modem_userdata(modem);
+	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
+	char buf[64];
+
+	if (!cbd || strlen(lock) !=3D 2)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
+			lock, old_passwd, new_passwd);
+
+	if (g_at_chat_send(at->parser, buf, none_prefix,
+				cpwd_set_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, data);
+	}
+}
+
 static struct ofono_call_barring_ops ops =3D {
-	.set	=3D at_call_barring_set,
-	.query	=3D at_call_barring_query,
+	.set		=3D at_call_barring_set,
+	.query		=3D at_call_barring_query,
+	.set_passwd	=3D at_call_barring_set_passwd,
 };
 =

 void at_call_barring_init(struct ofono_modem *modem)
-- =

1.6.0


--===============0142557438264379959==--

