Content-Type: multipart/mixed; boundary="===============1047956011153295771=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH v2 1/6] Don't remove atoms when state goes from INSERTED to
 NOT PRESENT.
Date: Fri, 07 May 2010 02:26:48 +0200
Message-ID: <1273192008-11131-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1047956011153295771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 8319702..0d0cb2a 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1132,13 +1132,16 @@ static void modem_sim_ready(void *user, enum ofono_=
sim_state new_state)
 =

 	switch (new_state) {
 	case OFONO_SIM_STATE_NOT_PRESENT:
-		remove_all_atoms(&modem->atoms);
+		if (modem->pre_sim_atoms !=3D NULL)
+			remove_all_atoms(&modem->atoms);
 		break;
 	case OFONO_SIM_STATE_INSERTED:
 		break;
 	case OFONO_SIM_STATE_READY:
-		modem->pre_sim_atoms =3D modem->atoms;
-		modem->atoms =3D NULL;
+		if (modem->pre_sim_atoms =3D=3D NULL) {
+			modem->pre_sim_atoms =3D modem->atoms;
+			modem->atoms =3D NULL;
+		}
 =

 		if (modem->driver->post_sim)
 			modem->driver->post_sim(modem);
-- =

1.6.1


--===============1047956011153295771==--

