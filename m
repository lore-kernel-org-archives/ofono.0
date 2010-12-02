Content-Type: multipart/mixed; boundary="===============5689411076010940284=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 3/3] isimodem: context activation might follow attach
Date: Thu, 02 Dec 2010 18:16:22 +0200
Message-ID: <1291306582-19024-4-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1291306582-19024-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5689411076010940284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/gprs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index 3c9facd..deffb1a 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -259,7 +259,7 @@ static GIsiRequest *attach_request_send(GIsiClient *cli=
ent, void *data)
 {
 	const unsigned char msg[] =3D {
 		GPDS_ATTACH_REQ,
-		GPDS_FOLLOW_OFF
+		GPDS_FOLLOW_ON
 	};
 =

 	return g_isi_send(client, msg, sizeof(msg), GPDS_TIMEOUT,
-- =

1.7.1


--===============5689411076010940284==--

