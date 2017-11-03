Content-Type: multipart/mixed; boundary="===============3392614036139747456=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 3/4] atmodem: helper for appending the file path to a command
Date: Fri, 03 Nov 2017 15:34:43 -0700
Message-ID: <1509748484-8773-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509748484-8773-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3392614036139747456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Several file read API's were re-using the same code to append
a file path. This code was moved into a helper API.
---
 drivers/atmodem/sim.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 8665274..421abfb 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -72,6 +72,22 @@ static const char *qpinc_prefix[] =3D { "+QPINC:", NULL =
};
 static const char *upincnt_prefix[] =3D { "+UPINCNT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

+static void append_file_path(char *buf, const unsigned char *path,
+		unsigned int path_len)
+{
+	if (path_len > 0) {
+		*buf++ =3D ',';
+		*buf++ =3D ',';
+		*buf++ =3D '\"';
+
+		for (; path_len; path_len--)
+			buf +=3D sprintf(buf, "%02hhX", *path++);
+
+		*buf++ =3D '\"';
+		*buf =3D '\0';
+	}
+}
+
 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -176,15 +192,7 @@ static void at_sim_read_info(struct ofono_sim *sim, in=
t fileid,
 		break;
 	}
 =

-	if (path_len > 0) {
-		len +=3D sprintf(buf + len, ",,\"");
-
-		for (; path_len; path_len--)
-			len +=3D sprintf(buf + len, "%02hhX", *path++);
-
-		buf[len++] =3D '\"';
-		buf[len] =3D '\0';
-	}
+	append_file_path(buf + len, path, path_len);
 =

 	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_info_cb, cbd, g_free) > 0)
@@ -258,17 +266,7 @@ static void at_sim_read_binary(struct ofono_sim *sim, =
int fileid,
 	len =3D snprintf(buf, sizeof(buf), "AT+CRSM=3D176,%i,%i,%i,%i", fileid,
 			start >> 8, start & 0xff, length);
 =

-	if (path_len > 0) {
-		buf[len++] =3D ',';
-		buf[len++] =3D ',';
-		buf[len++] =3D '\"';
-
-		for (; path_len; path_len--)
-			len +=3D sprintf(buf + len, "%02hhX", *path++);
-
-		buf[len++] =3D '\"';
-		buf[len] =3D '\0';
-	}
+	append_file_path(buf + len, path, path_len);
 =

 	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_read_cb, cbd, g_free) > 0)
@@ -288,10 +286,13 @@ static void at_sim_read_record(struct ofono_sim *sim,=
 int fileid,
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[128];
+	unsigned int len;
 =

-	snprintf(buf, sizeof(buf), "AT+CRSM=3D178,%i,%i,4,%i", fileid,
+	len =3D snprintf(buf, sizeof(buf), "AT+CRSM=3D178,%i,%i,4,%i", fileid,
 			record, length);
 =

+	append_file_path(buf + len, path, path_len);
+
 	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_read_cb, cbd, g_free) > 0)
 		return;
-- =

2.7.4


--===============3392614036139747456==--

