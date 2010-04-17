Content-Type: multipart/mixed; boundary="===============4562484054251554734=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/3] hdlc: allow for scanning and escaping
Date: Sat, 17 Apr 2010 11:15:33 -0700
Message-ID: <1271528135-12337-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1271528135-12337-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4562484054251554734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

PPP needs to inspect the packet protocol to see if a character
should be escaped.  Additionally, it needs to be able to compare
against recv and xmit accm.
---
 gatchat/gathdlc.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++-=
---
 gatchat/gathdlc.h |   12 ++++++++++
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 19df9c6..c5c02cf 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -47,6 +47,12 @@ struct _GAtHDLC {
 	gpointer receive_data;
 	GAtDebugFunc debugf;
 	gpointer debug_data;
+	GAtHDLCScanFunc scan_func;
+	gpointer scan_data;
+	GAtHDLCSendEscapeFunc send_escape_func;
+	gpointer send_escape_data;
+	GAtHDLCRecvEscapeFunc recv_escape_func;
+	gpointer recv_escape_data;
 };
 =

 static void new_bytes(GAtHDLC *hdlc)
@@ -71,6 +77,13 @@ static void new_bytes(GAtHDLC *hdlc)
 			continue;
 		}
 =

+		if (hdlc->recv_escape_func &&
+				hdlc->recv_escape_func(hdlc->recv_escape_data,
+				buf[pos])) {
+			pos++;
+			continue;
+		}
+
 		if (buf[pos] =3D=3D 0x7d) {
 			if (pos + 2 > len)
 				break;
@@ -249,6 +262,35 @@ void g_at_hdlc_set_receive(GAtHDLC *hdlc, GAtReceiveFu=
nc func,
 	hdlc->receive_data =3D user_data;
 }
 =

+void g_at_hdlc_set_scan(GAtHDLC *hdlc, GAtHDLCScanFunc func, gpointer user=
_data)
+{
+	if (!hdlc)
+		return;
+
+	hdlc->scan_func =3D func;
+	hdlc->scan_data =3D user_data;
+}
+
+void g_at_hdlc_set_send_escape(GAtHDLC *hdlc, GAtHDLCSendEscapeFunc func,
+						gpointer user_data)
+{
+	if (!hdlc)
+		return;
+
+	hdlc->send_escape_func =3D func;
+	hdlc->send_escape_data =3D user_data;
+}
+
+void g_at_hdlc_set_recv_escape(GAtHDLC *hdlc, GAtHDLCRecvEscapeFunc func,
+						gpointer user_data)
+{
+	if (!hdlc)
+		return;
+
+	hdlc->recv_escape_func =3D func;
+	hdlc->recv_escape_data =3D user_data;
+}
+
 static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -302,11 +344,15 @@ static void wakeup_write(GAtHDLC *hdlc)
 				can_write_data, hdlc, write_watch_destroy);
 }
 =

-static inline void hdlc_put(GAtHDLC *hdlc, guint8 *buf, gsize *pos, guint8=
 c)
+static inline void hdlc_put(GAtHDLC *hdlc, guint8 *buf, gsize *pos, guint8=
 c,
+				gboolean scan_result)
 {
 	gsize i =3D *pos;
 =

-	if (c =3D=3D 0x7e || c =3D=3D 0x7d) {
+	if ((hdlc->send_escape_func &&
+				hdlc->send_escape_func(hdlc->send_escape_data,
+							c, scan_result))
+			|| c =3D=3D 0x7e || c =3D=3D 0x7d) {
 		buf[i++] =3D 0x7d;
 		buf[i++] =3D c ^ 0x20;
 	} else
@@ -321,6 +367,10 @@ gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned =
char *data, gsize size)
 	unsigned int space, i =3D 0;
 	guint16 fcs =3D 0xffff;
 	gsize pos;
+	gboolean scan_result =3D FALSE;
+
+	if (hdlc->scan_func)
+		scan_result =3D hdlc->scan_func(hdlc->scan_data, data);
 =

 	do {
 		space =3D ring_buffer_avail_no_wrap(hdlc->write_buffer);
@@ -332,12 +382,12 @@ gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned=
 char *data, gsize size)
 =

 		while (size--) {
 			fcs =3D crc_ccitt_byte(fcs, data[i]);
-			hdlc_put(hdlc, buf, &pos, data[i++]);
+			hdlc_put(hdlc, buf, &pos, data[i++], scan_result);
 		}
 =

 		fcs ^=3D 0xffff;
-		hdlc_put(hdlc, buf, &pos, fcs & 0xff);
-		hdlc_put(hdlc, buf, &pos, fcs >> 8);
+		hdlc_put(hdlc, buf, &pos, fcs & 0xff, scan_result);
+		hdlc_put(hdlc, buf, &pos, fcs >> 8, scan_result);
 =

 		buf[pos++] =3D 0x7e;
 =

diff --git a/gatchat/gathdlc.h b/gatchat/gathdlc.h
index a295f08..f1adeb7 100644
--- a/gatchat/gathdlc.h
+++ b/gatchat/gathdlc.h
@@ -32,6 +32,12 @@ struct _GAtHDLC;
 =

 typedef struct _GAtHDLC GAtHDLC;
 =

+typedef gboolean (*GAtHDLCSendEscapeFunc)(gpointer user_data, guint8 c,
+						gboolean scan_result);
+typedef gboolean (*GAtHDLCRecvEscapeFunc)(gpointer user_data, guint8 c);
+
+typedef gboolean (*GAtHDLCScanFunc)(gpointer user_data,
+						const unsigned char *data);
 GAtHDLC *g_at_hdlc_new(GIOChannel *channel);
 =

 GAtHDLC *g_at_hdlc_ref(GAtHDLC *hdlc);
@@ -43,6 +49,12 @@ void g_at_hdlc_set_receive(GAtHDLC *hdlc, GAtReceiveFunc=
 func,
 							gpointer user_data);
 gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned char *data, gsize si=
ze);
 =

+void g_at_hdlc_set_scan(GAtHDLC *hdlc, GAtHDLCScanFunc func,
+							gpointer user_data);
+void g_at_hdlc_set_send_escape(GAtHDLC *hdlc, GAtHDLCSendEscapeFunc func,
+						gpointer user_data);
+void g_at_hdlc_set_recv_escape(GAtHDLC *hdlc, GAtHDLCRecvEscapeFunc func,
+						gpointer user_data);
 #ifdef __cplusplus
 }
 #endif
-- =

1.6.6.1


--===============4562484054251554734==--

