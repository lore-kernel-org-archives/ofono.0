Content-Type: multipart/mixed; boundary="===============0399334866865466839=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [RFC at-export 1/2] atmodem: export generic netreg funcs
Date: Mon, 22 Apr 2019 09:44:40 +0200
Message-ID: <20190422074441.11854-2-jonas@norrbonn.se>
In-Reply-To: <20190422074441.11854-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0399334866865466839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An upcoming netreg driver for uBlox modems will need to override the
probe method in order to set itself up, but for further functionality
the "generic" AT implementations are sufficient.  The easiest way to do
this is to just set up a vtable with a custom probe implementation and
defer all other methods to the common/generic methods.

The problem is that the AT methods are not actually exported.  This
generic AT functionality was not intended to be hooked directly into
other drivers.

This patch exports all the methods of the atmodem network-registration
driver implementation so that they can be used as generic/common
implementations for other drivers.
---
 drivers/atmodem/network-registration.c | 16 +++++++++-------
 drivers/atmodem/network-registration.h | 17 +++++++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)
 create mode 100644 drivers/atmodem/network-registration.h

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 67380b73..0f83977b 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -41,6 +41,8 @@
 #include "atmodem.h"
 #include "vendor.h"
 =

+#include "network-registration.h"
+
 static const char *none_prefix[] =3D { NULL };
 static const char *creg_prefix[] =3D { "+CREG:", NULL };
 static const char *cops_prefix[] =3D { "+COPS:", NULL };
@@ -270,7 +272,7 @@ static void option_tech_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		nd->tech =3D -1;
 }
 =

-static void at_registration_status(struct ofono_netreg *netreg,
+void at_registration_status(struct ofono_netreg *netreg,
 					ofono_netreg_status_cb_t cb,
 					void *data)
 {
@@ -450,7 +452,7 @@ error:
 	g_free(cbd);
 }
 =

-static void at_current_operator(struct ofono_netreg *netreg,
+void at_current_operator(struct ofono_netreg *netreg,
 				ofono_netreg_operator_cb_t cb, void *data)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
@@ -589,7 +591,7 @@ static void cops_list_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	g_free(list);
 }
 =

-static void at_list_operators(struct ofono_netreg *netreg,
+void at_list_operators(struct ofono_netreg *netreg,
 				ofono_netreg_operator_list_cb_t cb, void *data)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
@@ -615,7 +617,7 @@ static void register_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	cb(&error, cbd->data);
 }
 =

-static void at_register_auto(struct ofono_netreg *netreg,
+void at_register_auto(struct ofono_netreg *netreg,
 				ofono_netreg_register_cb_t cb, void *data)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
@@ -630,7 +632,7 @@ static void at_register_auto(struct ofono_netreg *netre=
g,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void at_register_manual(struct ofono_netreg *netreg,
+void at_register_manual(struct ofono_netreg *netreg,
 				const char *mcc, const char *mnc,
 				ofono_netreg_register_cb_t cb, void *data)
 {
@@ -1228,7 +1230,7 @@ static void csq_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	cb(&error, strength, cbd->data);
 }
 =

-static void at_signal_strength(struct ofono_netreg *netreg,
+void at_signal_strength(struct ofono_netreg *netreg,
 				ofono_netreg_strength_cb_t cb, void *data)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
@@ -2144,7 +2146,7 @@ static int at_netreg_probe(struct ofono_netreg *netre=
g, unsigned int vendor,
 	return 0;
 }
 =

-static void at_netreg_remove(struct ofono_netreg *netreg)
+void at_netreg_remove(struct ofono_netreg *netreg)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

diff --git a/drivers/atmodem/network-registration.h b/drivers/atmodem/netwo=
rk-registration.h
new file mode 100644
index 00000000..0f622411
--- /dev/null
+++ b/drivers/atmodem/network-registration.h
@@ -0,0 +1,17 @@
+#pragma once
+
+void at_registration_status(struct ofono_netreg *netreg,
+					ofono_netreg_status_cb_t cb,
+					void *data);
+void at_current_operator(struct ofono_netreg *netreg,
+				ofono_netreg_operator_cb_t cb, void *data);
+void at_list_operators(struct ofono_netreg *netreg,
+				ofono_netreg_operator_list_cb_t cb, void *data);
+void at_register_auto(struct ofono_netreg *netreg,
+				ofono_netreg_register_cb_t cb, void *data);
+void at_register_manual(struct ofono_netreg *netreg,
+				const char *mcc, const char *mnc,
+				ofono_netreg_register_cb_t cb, void *data);
+void at_signal_strength(struct ofono_netreg *netreg,
+				ofono_netreg_strength_cb_t cb, void *data);
+void at_netreg_remove(struct ofono_netreg *netreg);
-- =

2.20.1


--===============0399334866865466839==--

