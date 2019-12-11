Content-Type: multipart/mixed; boundary="===============8410117981351388974=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: Update attach state on context deactivation for LTE
Date: Wed, 11 Dec 2019 20:13:17 +0100
Message-ID: <20191211191317.12677-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8410117981351388974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

To be considered attached on LTE a context should be activated.
But in case the context got deactivated we did not update
the attached state, it remained attached.
That caused the connection manager to try to re-activate the
context manually, but for LTE thats done automatically.
In the case of ublox it returns errors, which is passed
on to the connection manager, which tries again and
again, until we get attached again.

It looked like this:
12:03:18 ofonod[547]: Aux: < \r\n+CIEV: 2,3\r\n
12:03:23 ofonod[547]: Aux: < \r\n+CIEV: 2,2\r\n

Deactivated

12:16:01 ofonod[547]: Aux: < \r\n+CGEV: NW PDN DEACT 4\r\n
12:16:01 ofonod[547]: drivers/ubloxmodem/gprs-context.c:cgev_notify() cid 4=
, active cid: 4
12:16:01 ofonod[547]: src/gprs.c:ofono_gprs_context_deactivated() 0x1743e50=
 0x17424a8 4

Connection manager now try to activate, over and over again
because Attached remains TRUE

12:16:01 ofonod[547]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_activate=
_primary() cid 1
12:16:01 ofonod[547]: Aux: > AT+CGDCONT=3D1,"IP","apn"\r
12:16:01 ofonod[547]: Aux: < \r\nOK\r\n
12:16:01 ofonod[547]: drivers/ubloxmodem/gprs-context.c:cgdcont_cb() ok 1
12:16:01 ofonod[547]: Aux: > AT+CGACT=3D1,1\r
12:16:01 ofonod[547]: Aux: < \r\n+CME ERROR: 30\r\n
12:16:01 ofonod[547]: drivers/ubloxmodem/gprs-context.c:cgact_enable_cb() o=
k 0
12:16:01 ofonod[547]: src/gprs.c:pri_activate_callback() 0x17475c0
12:16:01 ofonod[547]: src/gprs.c:pri_activate_callback() Activating context=
 failed with error: No network service
12:16:01 ofonod[547]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_activate=
_primary() cid 1
12:16:02 ofonod[547]: Aux: > AT+CGDCONT=3D1,"IP","apn"\r
12:16:02 ofonod[547]: Aux: < \r\nOK\r\n
12:16:02 ofonod[547]: drivers/ubloxmodem/gprs-context.c:cgdcont_cb() ok 1
12:16:02 ofonod[547]: Aux: > AT+CGACT=3D1,1\r
12:16:02 ofonod[547]: Aux: < \r\n+CME ERROR: 30\r\n
12:16:02 ofonod[547]: drivers/ubloxmodem/gprs-context.c:cgact_enable_cb() o=
k 0
12:16:02 ofonod[547]: src/gprs.c:pri_activate_callback() 0x17475c0
12:16:02 ofonod[547]: src/gprs.c:pri_activate_callback() Activating context=
 failed with error: No network service
.
.
.
12:16:14 ofonod[547]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_activate=
_primary() cid 1
12:16:14 ofonod[547]: Aux: > AT+CGDCONT=3D1,"IP","apn"\r
12:16:14 ofonod[547]: Aux: < \r\nOK\r\n
12:16:14 ofonod[547]: drivers/ubloxmodem/gprs-context.c:cgdcont_cb() ok 1
12:16:14 ofonod[547]: Aux: > AT+CGACT=3D1,1\r
12:16:14 ofonod[547]: Aux: < \r\n+CME ERROR: 30\r\n
12:16:14 ofonod[547]: drivers/ubloxmodem/gprs-context.c:cgact_enable_cb() o=
k 0
12:16:14 ofonod[547]: src/gprs.c:pri_activate_callback() 0x17475c0
12:16:14 ofonod[547]: src/gprs.c:pri_activate_callback() Activating context=
 failed with error: No network service
12:16:14 ofonod[547]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_activate=
_primary() cid 1
12:16:14 ofonod[547]: Aux: > AT+CGDCONT=3D1,"IP","apn"\r
12:16:14 ofonod[547]: Aux: < \r\nOK\r\n
12:16:14 ofonod[547]: drivers/ubloxmodem/gprs-context.c:cgdcont_cb() ok 1
12:16:14 ofonod[547]: Aux: > AT+CGACT=3D1,1\r

The context got activated again

12:16:14 ofonod[547]: Aux: < \r\n+CGEV: ME PDN ACT 4\r\n\r\n+CIEV: 9,2\r\n\=
r\n+CTZE: +04,0,"19/12/11,13:17:58"\r\n
12:16:14 ofonod[547]: drivers/ubloxmodem/network-registration.c:ctze_notify=
() tz +04 dst 0 time 19/12/11,13:17:58
12:16:14 ofonod[547]: src/network.c:ofono_netreg_time_notify() net time 201=
9-12-11 13:17:58 utcoff 3600 dst 0
12:16:14 ofonod[547]: Aux: < \r\n+CME ERROR: 100\r\n
12:16:14 ofonod[547]: drivers/ubloxmodem/gprs-context.c:cgact_enable_cb() o=
k 0
12:16:14 ofonod[547]: src/gprs.c:pri_activate_callback() 0x17475c0
12:16:14 ofonod[547]: src/gprs.c:pri_activate_callback() Activating context=
 failed with error: Unknown error
---
 src/gprs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 2d3a99e6..3d016d95 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2730,14 +2730,15 @@ void ofono_gprs_context_deactivated(struct ofono_gp=
rs_context *gc,
 					unsigned int cid)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_gprs *gprs =3D gc->gprs;
 	GSList *l;
 	struct pri_context *ctx;
 	dbus_bool_t value;
 =

-	if (gc->gprs =3D=3D NULL)
+	if (gprs =3D=3D NULL)
 		return;
 =

-	for (l =3D gc->gprs->contexts; l; l =3D l->next) {
+	for (l =3D gprs->contexts; l; l =3D l->next) {
 		ctx =3D l->data;
 =

 		if (ctx->context.cid !=3D cid)
@@ -2759,10 +2760,13 @@ void ofono_gprs_context_deactivated(struct ofono_gp=
rs_context *gc,
 	 * If "Attached" property was about to be signalled as TRUE but there
 	 * were still active contexts, try again to signal "Attached" property
 	 * to registered applications after active contexts have been released.
+	 *
+	 * "Attached" could also change to FALSE in case of LTE and getting
+	 * deactivated
 	 */
-	if (gc->gprs->flags & GPRS_FLAG_ATTACHED_UPDATE) {
-		gc->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
-		gprs_attached_update(gc->gprs);
+	if (on_lte(gprs) || gprs->flags & GPRS_FLAG_ATTACHED_UPDATE) {
+		gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
+		gprs_attached_update(gprs);
 	}
 }
 =

-- =

2.20.1

--===============8410117981351388974==--

