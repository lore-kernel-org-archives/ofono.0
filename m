Content-Type: multipart/mixed; boundary="===============3520353773923200930=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/2] atutil: remove unused mpty
Date: Thu, 13 Jan 2011 10:29:56 -0800
Message-ID: <1294943397-27551-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294943397-27551-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3520353773923200930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 0726da0..da17253 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -140,7 +140,6 @@ GSList *at_util_parse_clcc(GAtResult *result)
 		call->direction =3D dir;
 		call->status =3D status;
 		call->type =3D type;
-		call->mpty =3D mpty;
 		strncpy(call->phone_number.number, str,
 				OFONO_MAX_PHONE_NUMBER_LENGTH);
 		call->phone_number.type =3D number_type;
-- =

1.7.0.4


--===============3520353773923200930==--

