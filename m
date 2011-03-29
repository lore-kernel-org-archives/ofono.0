Content-Type: multipart/mixed; boundary="===============4561736006081277334=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 2/3] core: remove redundant code
Date: Tue, 29 Mar 2011 10:48:29 +0300
Message-ID: <1301384910-28272-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1301384910-28272-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4561736006081277334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c    |    7 -------
 src/call-forwarding.c |    7 -------
 src/call-settings.c   |    7 -------
 src/cbs.c             |    7 -------
 src/gprs.c            |    7 -------
 src/sms.c             |   11 -----------
 src/voicecall.c       |    6 ------
 7 files changed, 0 insertions(+), 52 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index e6570e0..d2f88c6 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -1092,7 +1092,6 @@ void ofono_call_barring_register(struct ofono_call_ba=
rring *cb)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cb->atom);
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cb->atom);
-	struct ofono_atom *ussd_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CALL_BARRING_INTERFACE,
@@ -1110,12 +1109,6 @@ void ofono_call_barring_register(struct ofono_call_b=
arring *cb)
 					OFONO_ATOM_TYPE_USSD,
 					ussd_watch, cb, NULL);
 =

-	ussd_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_USSD);
-
-	if (ussd_atom && __ofono_atom_get_registered(ussd_atom))
-		ussd_watch(ussd_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
-				cb);
-
 	__ofono_atom_register(cb->atom, call_barring_unregister);
 }
 =

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 1ba588a..84d3067 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1539,7 +1539,6 @@ void ofono_call_forwarding_register(struct ofono_call=
_forwarding *cf)
 	const char *path =3D __ofono_atom_get_path(cf->atom);
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
 	struct ofono_atom *sim_atom;
-	struct ofono_atom *ussd_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CALL_FORWARDING_INTERFACE,
@@ -1566,12 +1565,6 @@ void ofono_call_forwarding_register(struct ofono_cal=
l_forwarding *cf)
 					OFONO_ATOM_TYPE_USSD,
 					ussd_watch, cf, NULL);
 =

-	ussd_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_USSD);
-
-	if (ussd_atom && __ofono_atom_get_registered(ussd_atom))
-		ussd_watch(ussd_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
-				cf);
-
 	__ofono_atom_register(cf->atom, call_forwarding_unregister);
 }
 =

diff --git a/src/call-settings.c b/src/call-settings.c
index ede1a88..2d68adc 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -1454,7 +1454,6 @@ void ofono_call_settings_register(struct ofono_call_s=
ettings *cs)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cs->atom);
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cs->atom);
-	struct ofono_atom *ussd_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CALL_SETTINGS_INTERFACE,
@@ -1472,12 +1471,6 @@ void ofono_call_settings_register(struct ofono_call_=
settings *cs)
 					OFONO_ATOM_TYPE_USSD,
 					ussd_watch, cs, NULL);
 =

-	ussd_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_USSD);
-
-	if (ussd_atom && __ofono_atom_get_registered(ussd_atom))
-		ussd_watch(ussd_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
-				cs);
-
 	__ofono_atom_register(cs->atom, call_settings_unregister);
 }
 =

diff --git a/src/cbs.c b/src/cbs.c
index d99f250..d81104e 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -1087,7 +1087,6 @@ void ofono_cbs_register(struct ofono_cbs *cbs)
 	const char *path =3D __ofono_atom_get_path(cbs->atom);
 	struct ofono_atom *sim_atom;
 	struct ofono_atom *stk_atom;
-	struct ofono_atom *netreg_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CELL_BROADCAST_INTERFACE,
@@ -1119,12 +1118,6 @@ void ofono_cbs_register(struct ofono_cbs *cbs)
 					OFONO_ATOM_TYPE_NETREG,
 					netreg_watch, cbs, NULL);
 =

-	netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETREG);
-
-	if (netreg_atom && __ofono_atom_get_registered(netreg_atom))
-		netreg_watch(netreg_atom,
-				OFONO_ATOM_WATCH_CONDITION_REGISTERED, cbs);
-
 	__ofono_atom_register(cbs->atom, cbs_unregister);
 }
 =

diff --git a/src/gprs.c b/src/gprs.c
index f9e327a..deffeb8 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2869,7 +2869,6 @@ static void ofono_gprs_finish_register(struct ofono_g=
prs *gprs)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
-	struct ofono_atom *netreg_atom;
 =

 	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
 		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
@@ -2892,12 +2891,6 @@ static void ofono_gprs_finish_register(struct ofono_=
gprs *gprs)
 					OFONO_ATOM_TYPE_NETREG,
 					netreg_watch, gprs, NULL);
 =

-	netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETREG);
-
-	if (netreg_atom && __ofono_atom_get_registered(netreg_atom))
-		netreg_watch(netreg_atom,
-				OFONO_ATOM_WATCH_CONDITION_REGISTERED, gprs);
-
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

diff --git a/src/sms.c b/src/sms.c
index a413a37..c17e5c8 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1955,7 +1955,6 @@ void ofono_sms_register(struct ofono_sms *sms)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	const char *path =3D __ofono_atom_get_path(sms->atom);
-	struct ofono_atom *atom;
 	struct ofono_atom *sim_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
@@ -1974,20 +1973,10 @@ void ofono_sms_register(struct ofono_sms *sms)
 					OFONO_ATOM_TYPE_MESSAGE_WAITING,
 					mw_watch, sms, NULL);
 =

-	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_MESSAGE_WAITING);
-
-	if (atom && __ofono_atom_get_registered(atom))
-		mw_watch(atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, sms);
-
 	sms->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
 					OFONO_ATOM_TYPE_NETREG,
 					netreg_watch, sms, NULL);
 =

-	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETREG);
-
-	if (atom && __ofono_atom_get_registered(atom))
-		netreg_watch(atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, sms);
-
 	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
 =

 	/*
diff --git a/src/voicecall.c b/src/voicecall.c
index b1d5586..afda96a 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2368,7 +2368,6 @@ void ofono_voicecall_register(struct ofono_voicecall =
*vc)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	const char *path =3D __ofono_atom_get_path(vc->atom);
-	struct ofono_atom *sim_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_VOICECALL_MANAGER_INTERFACE,
@@ -2393,11 +2392,6 @@ void ofono_voicecall_register(struct ofono_voicecall=
 *vc)
 						OFONO_ATOM_TYPE_SIM,
 						sim_watch, vc, NULL);
 =

-	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
-
-	if (sim_atom && __ofono_atom_get_registered(sim_atom))
-		sim_watch(sim_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, vc);
-
 	__ofono_atom_register(vc->atom, voicecall_unregister);
 }
 =

-- =

1.7.1


--===============4561736006081277334==--

