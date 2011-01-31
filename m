Content-Type: multipart/mixed; boundary="===============3778390840070207049=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 8/8] gsmdial: add option for Bluetooth DUN dialing
Date: Mon, 31 Jan 2011 18:52:02 -0200
Message-ID: <1296507122-10936-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296507122-10936-7-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3778390840070207049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 1be80e3..d54a26e 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -56,6 +56,7 @@ static gboolean option_legacy =3D FALSE;
 static gchar *option_username =3D NULL;
 static gchar *option_password =3D NULL;
 static gchar *option_pppdump =3D NULL;
+static gboolean option_bluetooth =3D 0;
 =

 static GAtPPP *ppp;
 static GAtChat *control;
@@ -266,6 +267,9 @@ static void no_carrier_notify(GAtResult *result, gpoint=
er user_data)
 {
 	char buf[64];
 =

+	if (option_bluetooth)
+		return;
+
 	sprintf(buf, "AT+CFUN=3D%u", option_offmode);
 	g_at_chat_send(control, buf, none_prefix, power_down, NULL, NULL);
 }
@@ -612,6 +616,8 @@ static GOptionEntry options[] =3D {
 				"Specify CFUN offmode" },
 	{ "legacy", 'l', 0, G_OPTION_ARG_NONE, &option_legacy,
 				"Use ATD*99***<cid>#" },
+	{ "bluetooth", 'b', 0, G_OPTION_ARG_NONE, &option_bluetooth,
+				"Use only ATD*99" },
 	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
 				"Specify PPP username" },
 	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_password,
@@ -700,9 +706,14 @@ int main(int argc, char **argv)
 =

 	event_loop =3D g_main_loop_new(NULL, FALSE);
 =

-	g_at_chat_send(control, "ATE0Q0V1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(control, "AT+CFUN?", cfun_prefix,
-						check_mode, NULL, NULL);
+	if (option_bluetooth) {
+		g_at_chat_send(control, "ATD*99", none_prefix, connect_cb,
+				NULL, NULL);
+	} else {
+		g_at_chat_send(control, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+		g_at_chat_send(control, "AT+CFUN?", cfun_prefix,
+							check_mode, NULL, NULL);
+	}
 =

 	g_main_loop_run(event_loop);
 	g_source_remove(signal_source);
-- =

1.7.4.rc3


--===============3778390840070207049==--

