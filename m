Content-Type: multipart/mixed; boundary="===============5856035090136578216=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/2] message-waiting: Fix reading EF_MWIS records
Date: Thu, 16 Jul 2015 15:02:18 +0200
Message-ID: <1437051738-11852-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1437051738-11852-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5856035090136578216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/message-waiting.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index 6d1b462..a356e90 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -481,7 +481,7 @@ static void mw_mwis_read_cb(int ok, int total_length, i=
nt record,
 	status =3D data[0];
 	data++;
 =

-	for (i =3D 0; i < 5 && i < record_length - 1; i++) {
+	for (i =3D 0; i < 5 && i < record_length - 1; i++, data++) {
 		info.indication =3D (status >> i) & 1;
 		info.message_count =3D info.indication ? data[0] : 0;
 =

-- =

2.1.4


--===============5856035090136578216==--

