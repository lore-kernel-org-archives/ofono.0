Content-Type: multipart/mixed; boundary="===============2140824924913384216=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 11/11] gsmdial: Delay ppp_unref after IO processing
Date: Sat, 12 Jun 2010 13:50:50 +0800
Message-ID: <1276321850-13307-12-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-11-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2140824924913384216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 59f1a5c..d6cacc5 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -71,6 +71,7 @@ enum state {
 =

 static int state =3D 0;
 static int oldmode =3D 0;
+static int resume_source =3D 0;
 =

 static void gsmdial_debug(const char *str, void *data)
 {
@@ -262,11 +263,11 @@ static void ppp_connect(const char *iface, const char=
 *local, const char *peer,
 	execute(buf);
 }
 =

-static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+static gboolean resume_modem(gpointer user_data)
 {
 	char buf[64];
 =

-	g_print("PPP Link down: %d\n", reason);
+	resume_source =3D 0;
 =

 	g_at_ppp_unref(ppp);
 	ppp =3D NULL;
@@ -275,6 +276,15 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
 =

 	sprintf(buf, "AT+CFUN=3D%u", option_offmode);
 	g_at_chat_send(control, buf, none_prefix, power_down, NULL, NULL);
+
+	return FALSE;
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	g_print("PPP Link down: %d\n", reason);
+
+	resume_source =3D g_idle_add(resume_modem, NULL);
 }
 =

 static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -703,6 +713,9 @@ int main(int argc, char **argv)
 	g_main_loop_unref(event_loop);
 =

 out:
+	if (resume_source)
+		g_source_remove(resume_source);
+
 	if (ppp =3D=3D NULL) {
 		g_at_chat_unref(control);
 		g_at_chat_unref(modem);
-- =

1.6.3.3


--===============2140824924913384216==--

