Content-Type: multipart/mixed; boundary="===============4066104367728111499=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] hdlc: handle wrapped buffers
Date: Fri, 16 Apr 2010 19:31:03 -0700
Message-ID: <1271471463-7956-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1271471463-7956-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4066104367728111499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |   75 ++++++++++++++++++++++++++++---------------------=
---
 1 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index c5c02cf..13e15a1 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -59,11 +59,12 @@ static void new_bytes(GAtHDLC *hdlc)
 {
 	unsigned int len =3D ring_buffer_len(hdlc->read_buffer);
 	unsigned char *buf =3D ring_buffer_read_ptr(hdlc->read_buffer, 0);
+	unsigned int wrap =3D ring_buffer_len_no_wrap(hdlc->read_buffer);
 	unsigned char val;
 	unsigned int pos =3D 0;
 =

 	while (pos < len) {
-		if (buf[pos] =3D=3D 0x7e) {
+		if (*buf =3D=3D 0x7e) {
 			if (hdlc->receive_func && hdlc->decode_offset > 2 &&
 						hdlc->decode_fcs =3D=3D 0xf0b8) {
 				hdlc->receive_func(hdlc->decode_buffer,
@@ -74,29 +75,44 @@ static void new_bytes(GAtHDLC *hdlc)
 			hdlc->decode_fcs =3D 0xffff;
 			hdlc->decode_offset =3D 0;
 			pos++;
+			buf++;
+			if (pos =3D=3D wrap)
+				buf =3D ring_buffer_read_ptr(hdlc->read_buffer,
+								pos);
 			continue;
 		}
 =

 		if (hdlc->recv_escape_func &&
 				hdlc->recv_escape_func(hdlc->recv_escape_data,
-				buf[pos])) {
+				*buf)) {
 			pos++;
+			buf++;
+			if (pos =3D=3D wrap)
+				buf =3D ring_buffer_read_ptr(hdlc->read_buffer,
+								pos);
 			continue;
 		}
 =

-		if (buf[pos] =3D=3D 0x7d) {
+		if (*buf =3D=3D 0x7d) {
 			if (pos + 2 > len)
 				break;
 			pos++;
-			val =3D buf[pos] ^ 0x20;
+			buf++;
+			if (pos =3D=3D wrap)
+				buf =3D ring_buffer_read_ptr(hdlc->read_buffer,
+								pos);
+			val =3D *buf ^ 0x20;
 		} else
-			val =3D buf[pos];
+			val =3D *buf;
 =

 		hdlc->decode_buffer[hdlc->decode_offset] =3D val;
 		hdlc->decode_fcs =3D crc_ccitt_byte(hdlc->decode_fcs, val);
 =

 		hdlc->decode_offset++;
 		pos++;
+		buf++;
+		if (pos =3D=3D wrap)
+			buf =3D ring_buffer_read_ptr(hdlc->read_buffer, pos);
 	}
 =

 	ring_buffer_drain(hdlc->read_buffer, pos);
@@ -344,55 +360,44 @@ static void wakeup_write(GAtHDLC *hdlc)
 				can_write_data, hdlc, write_watch_destroy);
 }
 =

-static inline void hdlc_put(GAtHDLC *hdlc, guint8 *buf, gsize *pos, guint8=
 c,
-				gboolean scan_result)
+static inline void hdlc_buffer_put_char(struct ring_buffer *buffer,
+					const char val)
 {
-	gsize i =3D *pos;
+	ring_buffer_write(buffer, &val, 1);
+}
 =

+static inline void hdlc_put(GAtHDLC *hdlc, guint8 c, gboolean scan_result)
+{
 	if ((hdlc->send_escape_func &&
 				hdlc->send_escape_func(hdlc->send_escape_data,
 							c, scan_result))
 			|| c =3D=3D 0x7e || c =3D=3D 0x7d) {
-		buf[i++] =3D 0x7d;
-		buf[i++] =3D c ^ 0x20;
+		hdlc_buffer_put_char(hdlc->write_buffer, 0x7d);
+		hdlc_buffer_put_char(hdlc->write_buffer, c ^ 0x20);
 	} else
-		buf[i++] =3D c;
-
-	*pos =3D i;
+		hdlc_buffer_put_char(hdlc->write_buffer, c);
 }
 =

 gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned char *data, gsize si=
ze)
 {
-	unsigned char *buf;
-	unsigned int space, i =3D 0;
 	guint16 fcs =3D 0xffff;
-	gsize pos;
 	gboolean scan_result =3D FALSE;
+	unsigned int i =3D 0;
 =

 	if (hdlc->scan_func)
 		scan_result =3D hdlc->scan_func(hdlc->scan_data, data);
 =

-	do {
-		space =3D ring_buffer_avail_no_wrap(hdlc->write_buffer);
-		if (space =3D=3D 0)
-			break;
+	hdlc_buffer_put_char(hdlc->write_buffer, 0x7e);
 =

-		buf =3D ring_buffer_write_ptr(hdlc->write_buffer);
-		pos =3D 0;
-
-		while (size--) {
-			fcs =3D crc_ccitt_byte(fcs, data[i]);
-			hdlc_put(hdlc, buf, &pos, data[i++], scan_result);
-		}
-
-		fcs ^=3D 0xffff;
-		hdlc_put(hdlc, buf, &pos, fcs & 0xff, scan_result);
-		hdlc_put(hdlc, buf, &pos, fcs >> 8, scan_result);
-
-		buf[pos++] =3D 0x7e;
+	while (size--) {
+		fcs =3D crc_ccitt_byte(fcs, data[i]);
+		hdlc_put(hdlc, data[i++], scan_result);
+	}
 =

-		ring_buffer_write_advance(hdlc->write_buffer, pos);
-	} while (0);
+	fcs ^=3D 0xffff;
+	hdlc_put(hdlc, fcs & 0xff, scan_result);
+	hdlc_put(hdlc, fcs >> 8, scan_result);
+	hdlc_buffer_put_char(hdlc->write_buffer, 0x7e);
 =

 	wakeup_write(hdlc);
 =

-- =

1.6.6.1


--===============4066104367728111499==--

