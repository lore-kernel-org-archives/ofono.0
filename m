Content-Type: multipart/mixed; boundary="===============1316990701387118943=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/9] modem.c: Go to PRE_SIM modem state on
 OFONO_SIM_STATE_INSERTED.
Date: Tue, 15 Feb 2011 08:58:51 +0100
Message-ID: <1297756739-2958-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1316990701387118943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The assumption so far was that SIM state would only go from
NOT_PRESENT -> INSERTED -> READY -> NOT_PRESENT because there's
no method to unauthenticate from SIM without removing.  We need to
be able to switch to INSERTED when SIM is being reset,
reinitialised, etc. because going to NOT_PRESENT and then
immediately INSERTED would be logically wrong.
---
 src/modem.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 3c1bb52..d1c7905 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -517,7 +517,7 @@ static void common_online_cb(const struct ofono_error *=
error, void *data)
 	 *
 	 * Additionally, this process can be interrupted by the following
 	 * events:
-	 *	- Sim being removed
+	 *	- Sim being removed or reset
 	 *	- SetProperty(Powered, False) being called
 	 *	- SetProperty(Lockdown, True) being called
 	 *
@@ -531,7 +531,7 @@ static void common_online_cb(const struct ofono_error *=
error, void *data)
 		/* The powered operation is pending */
 		break;
 	case MODEM_STATE_PRE_SIM:
-		/* Go back offline if the sim was removed */
+		/* Go back offline if the sim was removed or reset */
 		modem->driver->set_online(modem, 0, NULL, NULL);
 		break;
 	case MODEM_STATE_ONLINE:
@@ -583,9 +583,13 @@ static void sim_state_watch(enum ofono_sim_state new_s=
tate, void *user)
 =

 	switch (new_state) {
 	case OFONO_SIM_STATE_NOT_PRESENT:
-		modem_change_state(modem, MODEM_STATE_PRE_SIM);
-		break;
 	case OFONO_SIM_STATE_INSERTED:
+		if (modem->modem_state !=3D MODEM_STATE_PRE_SIM) {
+			if (modem->modem_state =3D=3D MODEM_STATE_ONLINE)
+				modem->get_online =3D TRUE;
+
+			modem_change_state(modem, MODEM_STATE_PRE_SIM);
+		}
 		break;
 	case OFONO_SIM_STATE_READY:
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
-- =

1.7.1.86.g0e460.dirty


--===============1316990701387118943==--

