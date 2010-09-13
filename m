Content-Type: multipart/mixed; boundary="===============7309338356983037431=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/8] smsutil: Add USSD encoding function
Date: Mon, 13 Sep 2010 16:00:10 -0700
Message-ID: <1284418817-28575-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284418817-28575-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7309338356983037431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   29 +++++++++++++++++++++++++++++
 src/smsutil.h |    1 +
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 26c7951..0d68d33 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -4179,3 +4179,32 @@ char *ussd_decode(int dcs, int len, const unsigned c=
har *data)
 =

 	return utf8;
 }
+
+gboolean ussd_encode(const char *str, long *items_written, unsigned char *=
pdu)
+{
+	unsigned char *converted =3D NULL;
+	long written;
+	long num_packed;
+
+	if (!pdu)
+		return FALSE;
+
+	converted =3D convert_utf8_to_gsm(str, -1, NULL, &written, 0);
+	if (!converted || written > 182)
+		goto error;
+
+	pack_7bit_own_buf(converted, written, 0, TRUE, &num_packed, 0, pdu);
+
+	g_free(converted);
+
+	if (num_packed < 1)
+		return FALSE;
+
+	if (items_written)
+		*items_written =3D num_packed;
+
+	return TRUE;
+error:
+	g_free(converted);
+	return FALSE;
+}
diff --git a/src/smsutil.h b/src/smsutil.h
index 0e0ddf4..a81fd6d 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -544,3 +544,4 @@ GSList *cbs_optimize_ranges(GSList *ranges);
 gboolean cbs_topic_in_range(unsigned int topic, GSList *ranges);
 =

 char *ussd_decode(int dcs, int len, const unsigned char *data);
+gboolean ussd_encode(const char *str, long *items_written, unsigned char *=
pdu);
-- =

1.7.0.4


--===============7309338356983037431==--

