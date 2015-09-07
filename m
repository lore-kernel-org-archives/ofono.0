Content-Type: multipart/mixed; boundary="===============5796627173675367752=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/3] sms: Add trace when datagram is not delivered
Date: Mon, 07 Sep 2015 11:58:17 +0200
Message-ID: <1441619897-22899-4-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1441619897-22899-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5796627173675367752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/sms.c b/src/sms.c
index 0270029..72972b2 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1184,6 +1184,7 @@ static void dispatch_app_datagram(struct ofono_sms *s=
ms,
 	ofono_sms_datagram_notify_cb_t notify;
 	struct sms_handler *h;
 	GSList *l;
+	gboolean dispatched =3D FALSE;
 =

 	ts =3D sms_scts_to_time(scts, &remote);
 	localtime_r(&ts, &local);
@@ -1195,9 +1196,15 @@ static void dispatch_app_datagram(struct ofono_sms *=
sms,
 		if (!port_equal(dst, h->dst) || !port_equal(src, h->src))
 			continue;
 =

+		dispatched =3D TRUE;
+
 		notify(sender, &remote, &local, dst, src, buf, len,
 			h->item.notify_data);
 	}
+
+	if (!dispatched)
+		ofono_info("Datagram with ports [%d,%d] not delivered",
+								dst, src);
 }
 =

 static void dispatch_text_message(struct ofono_sms *sms,
-- =

2.1.4


--===============5796627173675367752==--

