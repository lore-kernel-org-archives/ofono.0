Content-Type: multipart/mixed; boundary="===============0932945512651641088=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] sms: Pass const pointer to dispatch_app_datagram
Date: Sat, 19 Aug 2017 12:26:16 +0300
Message-ID: <1503134776-24068-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0932945512651641088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/sms.c b/src/sms.c
index 17c5a9c..b86158e 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1171,7 +1171,8 @@ static gboolean compute_incoming_msgid(GSList *sms_li=
st,
 static void dispatch_app_datagram(struct ofono_sms *sms,
 					const struct ofono_uuid *uuid,
 					int dst, int src,
-					unsigned char *buf, unsigned len,
+					const unsigned char *buf,
+					unsigned int len,
 					const struct sms_address *addr,
 					const struct sms_scts *scts)
 {
-- =

1.9.1


--===============0932945512651641088==--

