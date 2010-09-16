Content-Type: multipart/mixed; boundary="===============3611885446224023567=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem/ussd: clean const casts
Date: Thu, 16 Sep 2010 16:50:06 +0300
Message-ID: <1284645006-3361-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3611885446224023567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/ussd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 19ba30e..2f4091c 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -119,7 +119,7 @@ error:
 }
 =

 static GIsiRequest *ussd_send(GIsiClient *client,
-				int dcs, uint8_t *str, size_t len,
+				int dcs, uint8_t const *str, size_t len,
 				void *data, GDestroyNotify notify)
 {
 	const uint8_t msg[] =3D {
@@ -135,7 +135,7 @@ static GIsiRequest *ussd_send(GIsiClient *client,
 =

 	const struct iovec iov[2] =3D {
 		{ (uint8_t *)msg, sizeof(msg) },
-		{ str, len }
+		{ (uint8_t *)str, len }
 	};
 =

 	return g_isi_vsend(client, iov, 2, SS_TIMEOUT,
@@ -152,7 +152,7 @@ static void isi_request(struct ofono_ussd *ussd, int dc=
s,
 	if (!cbd)
 		goto error;
 =

-	if (ussd_send(ud->client, dcs, (guint8 *) pdu, len, cbd, g_free))
+	if (ussd_send(ud->client, dcs, pdu, len, cbd, g_free))
 		return;
 =

 error:
-- =

1.7.0.4


--===============3611885446224023567==--

