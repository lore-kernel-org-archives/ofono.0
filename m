Content-Type: multipart/mixed; boundary="===============8100858924258197391=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/7] modem: Add flag for drivers that watch SIM state
Date: Fri, 13 Nov 2015 13:25:06 +0100
Message-ID: <1447417510-9368-4-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1447417510-9368-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8100858924258197391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add flag for drivers that handle modems that cannot access the SIM when
in offline state. These drivers watch the SIM state to create/destroy
certain atoms.
---
 src/modem.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 01b0e35..dec398c 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -87,6 +87,7 @@ struct ofono_modem {
 	void			*driver_data;
 	char			*driver_type;
 	char			*name;
+	ofono_bool_t		driver_watches_sim;
 };
 =

 struct ofono_devinfo {
@@ -708,22 +709,26 @@ static void sim_state_watch(enum ofono_sim_state new_=
state, void *user)
 	case OFONO_SIM_STATE_RESETTING:
 		break;
 	case OFONO_SIM_STATE_LOCKED_OUT:
-		modem_change_state(modem, MODEM_STATE_PRE_SIM);
+		if (modem->driver_watches_sim =3D=3D FALSE)
+			modem_change_state(modem, MODEM_STATE_PRE_SIM);
 		break;
 	case OFONO_SIM_STATE_READY:
-		modem_change_state(modem, MODEM_STATE_OFFLINE);
+		/* Avoid state regressions */
+		if (modem->modem_state !=3D MODEM_STATE_ONLINE) {
+			modem_change_state(modem, MODEM_STATE_OFFLINE);
 =

-		/* Modem is always online, proceed to online state. */
-		if (modem_is_always_online(modem) =3D=3D TRUE)
-			set_online(modem, TRUE);
+			/* Modem is always online, proceed to online state. */
+			if (modem_is_always_online(modem) =3D=3D TRUE)
+				set_online(modem, TRUE);
 =

-		if (modem->online =3D=3D TRUE)
-			modem_change_state(modem, MODEM_STATE_ONLINE);
-		else if (modem->get_online)
-			modem->driver->set_online(modem, 1, common_online_cb,
-							modem);
+			if (modem->online =3D=3D TRUE)
+				modem_change_state(modem, MODEM_STATE_ONLINE);
+			else if (modem->get_online)
+				modem->driver->set_online(modem, 1,
+						common_online_cb, modem);
 =

-		modem->get_online =3D FALSE;
+			modem->get_online =3D FALSE;
+		}
 =

 		break;
 	}
@@ -1809,6 +1814,17 @@ void ofono_modem_set_driver(struct ofono_modem *mode=
m, const char *type)
 	modem->driver_type =3D g_strdup(type);
 }
 =

+void ofono_modem_set_driver_watches_sim(struct ofono_modem *modem,
+					ofono_bool_t value)
+{
+	modem->driver_watches_sim =3D value;
+}
+
+ofono_bool_t ofono_modem_get_driver_watches_sim(struct ofono_modem *modem)
+{
+	return modem->driver_watches_sim;
+}
+
 struct ofono_modem *ofono_modem_create(const char *name, const char *type)
 {
 	struct ofono_modem *modem;
-- =

2.5.0


--===============8100858924258197391==--

