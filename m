Content-Type: multipart/mixed; boundary="===============5663668324745315064=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Fix isimodem call forwarding.
Date: Mon, 09 Aug 2010 21:32:17 +0300
Message-ID: <1281378737-9142-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5663668324745315064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/call-forwarding.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index aaf6ed8..7b4a185 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -426,9 +426,8 @@ static gboolean query_resp_cb(GIsiClient *client,
 							&ton, &norply, &number))
 				goto error;
 =

-			list.status =3D status & (SS_GSM_ACTIVE
-						| SS_GSM_REGISTERED
-						| SS_GSM_PROVISIONED);
+			/* As in 27.007 section 7.11 */
+			list.status =3D status & SS_GSM_ACTIVE;
 			list.time =3D norply;
 			list.phone_number.type =3D ton | 128;
 			strncpy(list.phone_number.number, number,
-- =

1.7.0.4


--===============5663668324745315064==--

