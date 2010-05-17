Content-Type: multipart/mixed; boundary="===============3443848834647443881=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] hdlc: detect NO CARRIER
Date: Mon, 17 May 2010 12:43:43 -0700
Message-ID: <1274125424-14490-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1274125424-14490-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3443848834647443881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

modify hdlc receive function to check for NO CARRIER string.  If
found, notify anyone that has indicated they are interested.
---
 gatchat/gathdlc.c |   37 ++++++++++++++++++++++++++++++++++---
 gatchat/gathdlc.h |    4 ++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 6e71eb4..47ef736 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -57,6 +57,8 @@ struct _GAtHDLC {
 	guint decode_offset;
 	guint16 decode_fcs;
 	gboolean decode_escape;
+	gboolean match;
+	guint match_offset;
 	guint32 xmit_accm[8];
 	guint32 recv_accm;
 	GAtReceiveFunc receive_func;
@@ -64,8 +66,17 @@ struct _GAtHDLC {
 	GAtDebugFunc debugf;
 	gpointer debug_data;
 	int record_fd;
+	GAtHDLCNoCarrierFunc no_carrier_notify;
+	gpointer no_carrier_data;
 };
 =

+struct match_string {
+	guint len;
+	const char *s;
+};
+
+static struct match_string no_carrier =3D { 10, "NO CARRIER" };
+
 static void hdlc_record(int fd, gboolean in, guint8 *data, guint16 length)
 {
 	guint16 len =3D htons(length);
@@ -123,6 +134,13 @@ guint32 g_at_hdlc_get_recv_accm(GAtHDLC *hdlc)
 	return hdlc->recv_accm;
 }
 =

+void g_at_hdlc_set_no_carrier(GAtHDLC *hdlc, GAtHDLCNoCarrierFunc func,
+						gpointer user_data)
+{
+	hdlc->no_carrier_notify =3D func;
+	hdlc->no_carrier_data =3D user_data;
+}
+
 static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 {
 	GAtHDLC *hdlc =3D user_data;
@@ -153,10 +171,23 @@ static void new_bytes(struct ring_buffer *rbuf, gpoin=
ter user_data)
 =

 			hdlc->decode_fcs =3D HDLC_INITFCS;
 			hdlc->decode_offset =3D 0;
-		} else if (*buf >=3D 0x20 ||
+		} else {
+			if (*buf =3D=3D no_carrier.s[hdlc->match_offset++]) {
+				hdlc->match =3D TRUE;
+				if (hdlc->match_offset =3D=3D no_carrier.len &&
+					hdlc->no_carrier_notify)
+					hdlc->no_carrier_notify(hdlc->no_carrier_data);
+			} else {
+				hdlc->match =3D FALSE;
+				hdlc->match_offset =3D 0;
+			}
+			if (*buf >=3D 0x20 ||
 					(hdlc->recv_accm & (1 << *buf)) =3D=3D 0) {
-			hdlc->decode_buffer[hdlc->decode_offset++] =3D *buf;
-			hdlc->decode_fcs =3D HDLC_FCS(hdlc->decode_fcs, *buf);
+				hdlc->decode_buffer[hdlc->decode_offset++] =3D
+									*buf;
+				hdlc->decode_fcs =3D HDLC_FCS(hdlc->decode_fcs,
+								*buf);
+			}
 		}
 =

 		buf++;
diff --git a/gatchat/gathdlc.h b/gatchat/gathdlc.h
index 132e1a9..7ab27ac 100644
--- a/gatchat/gathdlc.h
+++ b/gatchat/gathdlc.h
@@ -33,6 +33,8 @@ struct _GAtHDLC;
 =

 typedef struct _GAtHDLC GAtHDLC;
 =

+typedef void (*GAtHDLCNoCarrierFunc)(gpointer user_data);
+
 GAtHDLC *g_at_hdlc_new(GIOChannel *channel);
 GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io);
 =

@@ -41,6 +43,8 @@ void g_at_hdlc_unref(GAtHDLC *hdlc);
 =

 void g_at_hdlc_set_debug(GAtHDLC *hdlc, GAtDebugFunc func, gpointer user_d=
ata);
 =

+void g_at_hdlc_set_no_carrier(GAtHDLC *hdlc, GAtHDLCNoCarrierFunc func,
+						gpointer user_data);
 void g_at_hdlc_set_xmit_accm(GAtHDLC *hdlc, guint32 accm);
 guint32 g_at_hdlc_get_xmit_accm(GAtHDLC *hdlc);
 =

-- =

1.6.6.1


--===============3443848834647443881==--

