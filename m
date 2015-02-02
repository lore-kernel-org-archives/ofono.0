Content-Type: multipart/mixed; boundary="===============5219250393000423916=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH 2/2] atmodem: fix retries reporting from AT+CPINR
Date: Mon, 02 Feb 2015 10:32:45 +0100
Message-ID: <1422869565-11746-2-git-send-email-cedric.jehasse@gmail.com>
In-Reply-To: <1422869565-11746-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5219250393000423916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

The retries array was not correctly filled in.
---
 drivers/atmodem/sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 054f548..d6a0dcf 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -827,7 +827,7 @@ static void at_cpinr_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 =

 		for (i =3D 1; i < len; i++) {
 			if (!strcmp(name, at_sim_name[i].name)) {
-				retries[i] =3D val;
+				retries[at_sim_name[i].type] =3D val;
 				break;
 			}
 		}
-- =

1.9.2


--===============5219250393000423916==--

