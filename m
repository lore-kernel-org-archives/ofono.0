Content-Type: multipart/mixed; boundary="===============4638274777030408582=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 3/4] modem: some debugs added for indicating modem state
 change
Date: Fri, 01 Oct 2010 19:06:40 +0300
Message-ID: <1285949201-2994-4-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1285949201-2994-3-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4638274777030408582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index f6ed1ab..e90f4dc 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -380,20 +380,25 @@ static void modem_change_state(struct ofono_modem *mo=
dem,
 =

 	modem->modem_state =3D new_state;
 =

-	if (old_state > new_state)
+	if (old_state > new_state) {
+		DBG("flush atoms");
 		flush_atoms(modem, new_state);
+	}
 =

 	switch (new_state) {
 	case MODEM_STATE_POWER_OFF:
+		DBG("MODEM_STATE_POWER_OFF");
 		modem->call_ids =3D 0;
 		break;
 =

 	case MODEM_STATE_PRE_SIM:
+		DBG("MODEM_STATE_PRE_SIM");
 		if (old_state < MODEM_STATE_PRE_SIM && driver->pre_sim)
 			driver->pre_sim(modem);
 		break;
 =

 	case MODEM_STATE_OFFLINE:
+		DBG("MODEM_STATE_OFFLINE");
 		if (old_state < MODEM_STATE_OFFLINE) {
 			if (driver->post_sim)
 				driver->post_sim(modem);
@@ -403,6 +408,7 @@ static void modem_change_state(struct ofono_modem *mode=
m,
 		break;
 =

 	case MODEM_STATE_ONLINE:
+		DBG("MODEM_STATE_ONLINE");
 		if (driver->post_online)
 			driver->post_online(modem);
 		break;
-- =

1.6.3.3



--===============4638274777030408582==--

