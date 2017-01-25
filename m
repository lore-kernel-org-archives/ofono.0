Content-Type: multipart/mixed; boundary="===============3471588605927053681=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH] atmodem: add LTE to Telit #PSNT status parser
Date: Wed, 25 Jan 2017 10:23:56 +0100
Message-ID: <20170125092356.25928-1-gluedig@gmail.com>
In-Reply-To: <b3830629-9b59-24b9-de5e-01f87f3fb6b0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3471588605927053681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Network type of 4 in Telit #PSNT command response
denotes LTE network
---
 drivers/atmodem/gprs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 5724f861..7ea9f005 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -323,6 +323,9 @@ static void telit_mode_notify(GAtResult *result, gpoint=
er user_data)
 	case 3:
 		bearer =3D 5;    /* HSDPA */
 		break;
+	case 4:
+		bearer =3D 7;    /* LTE */
+		break;
 	default:
 		bearer =3D 0;
 		break;
-- =

2.11.0


--===============3471588605927053681==--

