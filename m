Content-Type: multipart/mixed; boundary="===============4795439652347063593=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 2/2] Add datagram dispatch to sms atom
Date: Mon, 27 Sep 2010 16:24:37 +0300
Message-ID: <1285593877-31638-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1285593877-31638-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4795439652347063593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |   41 +++++++++++++++++++++++++++--------------
 1 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 9bf7feb..e6a2f9c 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1064,12 +1064,24 @@ static gboolean compute_incoming_msgid(GSList *sms_=
list,
 	return TRUE;
 }
 =

-static void dispatch_app_datagram(struct ofono_sms *sms, int dst, int src,
-					unsigned char *buf, long len)
+static void dispatch_app_datagram(struct ofono_sms *sms,
+					const struct ofono_uuid *uuid,
+					int dst, int src,
+					unsigned char *buf, unsigned len,
+					const struct sms_address *addr,
+					const struct sms_scts *scts)
 {
-	DBG("Got app datagram for dst port: %d, src port: %d",
-			dst, src);
-	DBG("Contents-Len: %ld", len);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
+	const char *sender =3D sms_address_to_string(addr);
+	time_t ts;
+	struct tm remote;
+	struct tm local;
+
+	ts =3D sms_scts_to_time(scts, &remote);
+	localtime_r(&ts, &local);
+
+	__ofono_history_datagram_received(modem, uuid, sender, dst, src,
+						&remote, &local, buf, len);
 }
 =

 static void dispatch_text_message(struct ofono_sms *sms,
@@ -1141,6 +1153,7 @@ static void sms_dispatch(struct ofono_sms *sms, GSLis=
t *sms_list)
 {
 	GSList *l;
 	const struct sms *s;
+	struct ofono_uuid uuid;
 	enum sms_charset uninitialized_var(old_charset);
 	enum sms_class cls;
 	int srcport =3D -1;
@@ -1214,6 +1227,11 @@ static void sms_dispatch(struct ofono_sms *sms, GSLi=
st *sms_list)
 		}
 	}
 =

+	if (!compute_incoming_msgid(sms_list, &uuid))
+		return;
+
+	s =3D sms_list->data;
+
 	/* Handle datagram */
 	if (old_charset =3D=3D SMS_CHARSET_8BIT) {
 		unsigned char *buf;
@@ -1230,23 +1248,18 @@ static void sms_dispatch(struct ofono_sms *sms, GSL=
ist *sms_list)
 		if (!buf)
 			return;
 =

-		dispatch_app_datagram(sms, dstport, srcport, buf, len);
+		dispatch_app_datagram(sms, &uuid, dstport, srcport, buf, len,
+					&s->deliver.oaddr, &s->deliver.scts);
 =

 		g_free(buf);
 	} else {
-		struct ofono_uuid uuid;
 		char *message =3D sms_decode_text(sms_list);
 =

 		if (!message)
 			return;
 =

-		if (compute_incoming_msgid(sms_list, &uuid)) {
-			s =3D sms_list->data;
-
-			dispatch_text_message(sms, &uuid, message, cls,
-						&s->deliver.oaddr,
-						&s->deliver.scts);
-		}
+		dispatch_text_message(sms, &uuid, message, cls,
+					&s->deliver.oaddr, &s->deliver.scts);
 =

 		g_free(message);
 	}
-- =

1.7.0.4


--===============4795439652347063593==--

