Content-Type: multipart/mixed; boundary="===============5541182852089521740=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: Don't modify the context if assign fails
Date: Tue, 10 Dec 2019 13:58:16 +0100
Message-ID: <20191210125816.24254-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5541182852089521740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

There was an issue while running LTE and the connection
manager tried to activate the context with CID 1 while
it got automatically activated at the same time with
CID 4.

When the automatic activation happened ofono_gprs_cid_activated
got called which tried to assign the context, but that failed
since the driver context was considered in use
(by the activation call).
Eventhough it failed, the context was modified,
cid was set to 0 (making cid 1 leak).
Then release_context got called which clear pointers
assigned to the context.

A bit later the activation callback got called, in my case
activation failed. Due to the failure it tries to clean up
by calling context_settings_free, but unfortunately the pointers
where reset above causing ofono to segfault du to null pointer
derefs.

Instead we make sure assign_context does not touch the context
unless it succeeds. Then there is no need to call release_context
if assign fails.
That ensures the context being intact when the activation callback
gets called.

03:23:21 ofonod[545]: Aux: < \r\n+CGEV: ME PDN ACT 4\r\n\r\n+CTZE: +04,0,"1=
9/12/10,04:25:03"\r\n
03:23:21 ofonod[545]: drivers/ubloxmodem/network-registration.c:ctze_notify=
() tz +04 dst 0 time 19/12/10,04:25:03
03:23:21 ofonod[545]: src/network.c:ofono_netreg_time_notify() net time 201=
9-12-10 04:25:03 utcoff 3600 dst 0
03:23:22 ofonod[545]: Aux: > AT+CGDCONT?\r
03:23:22 ofonod[545]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_activate=
_primary() cid 1

Connection manager requests activation, will mark the context in use and as=
sign
it cid 1.

03:23:22 ofonod[545]: Aux: < \r\n+CGDCONT: 1,"IP","m2m.tele2.com","",0,0,0,=
0,0,0\r\n
03:23:22 ofonod[545]: Aux: < +CGDCONT: 4,"IP","m2m.tele2.com.mnc003.mcc248.=
gprs","100.69.174.133",0,0,0,0,0,0\r\n
03:23:22 ofonod[545]: Aux: < \r\nOK\r\n
03:23:22 ofonod[545]: drivers/atmodem/gprs.c:at_cgdcont_read_cb() ok 1
03:23:22 ofonod[545]: src/gprs.c:ofono_gprs_cid_activated() cid 4
03:23:22 ofonod[545]: Can't assign context to driver for APN.

Since its marked in use above, we fail to assign it cid 4. When that fails
the cid is cleared an all context pointers are set to NULL.

03:23:22 ofonod[545]: Aux: > AT+CGDCONT=3D1,"IP","m2m.tele2.com"\r
03:23:22 ofonod[545]: Aux: < \r\nOK\r\n
03:23:22 ofonod[545]: drivers/ubloxmodem/gprs-context.c:cgdcont_cb() ok 1
03:23:22 ofonod[545]: Aux: > AT+CGACT=3D1,1\r
03:23:22 ofonod[545]: Aux: < \r\n+CME ERROR: 100\r\n
03:23:22 ofonod[545]: drivers/ubloxmodem/gprs-context.c:cgact_enable_cb() o=
k 0
03:23:22 ofonod[545]: src/gprs.c:pri_activate_callback() 0x853480
03:23:22 ofonod[545]: src/gprs.c:pri_activate_callback() Activating context=
 failed with error: Unknown error

Activation callback, and it failed. Will try to clean up, but the pointers =
are
NULL'ed...

Dec 10 03:23:22 ofonod[545]: Aborting (signal 11) [/usr/sbin/ofonod]
---
 src/gprs.c | 64 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 2d3a99e6..223c777f 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -223,23 +223,11 @@ static gboolean gprs_context_string_to_type(const cha=
r *str,
 	return FALSE;
 }
 =

-static gboolean assign_context(struct pri_context *ctx, unsigned int use_c=
id)
+static struct ofono_gprs_context *
+find_avail_gprs_context(struct pri_context *ctx)
 {
-	struct l_uintset *used_cids =3D ctx->gprs->used_cids;
 	GSList *l;
 =

-	if (used_cids =3D=3D NULL)
-		return FALSE;
-
-	if (!use_cid)
-		use_cid =3D l_uintset_find_unused_min(used_cids);
-
-	if (use_cid > l_uintset_get_max(used_cids))
-		return FALSE;
-
-	l_uintset_put(used_cids, use_cid);
-	ctx->context.cid =3D use_cid;
-
 	for (l =3D ctx->gprs->context_drivers; l; l =3D l->next) {
 		struct ofono_gprs_context *gc =3D l->data;
 =

@@ -257,24 +245,45 @@ static gboolean assign_context(struct pri_context *ct=
x, unsigned int use_cid)
 				gc->type !=3D ctx->type)
 			continue;
 =

-		ctx->context_driver =3D gc;
-		ctx->context_driver->inuse =3D TRUE;
+		return gc;
+	}
 =

-		if (ctx->context.proto =3D=3D OFONO_GPRS_PROTO_IPV4V6 ||
-				ctx->context.proto =3D=3D OFONO_GPRS_PROTO_IP)
-			gc->settings->ipv4 =3D g_new0(struct ipv4_settings, 1);
+	return NULL;
+}
 =

-		if (ctx->context.proto =3D=3D OFONO_GPRS_PROTO_IPV4V6 ||
-				ctx->context.proto =3D=3D OFONO_GPRS_PROTO_IPV6)
-			gc->settings->ipv6 =3D g_new0(struct ipv6_settings, 1);
+static gboolean assign_context(struct pri_context *ctx, unsigned int use_c=
id)
+{
+	struct l_uintset *used_cids =3D ctx->gprs->used_cids;
+	struct ofono_gprs_context *gc;
 =

-		return TRUE;
-	}
+	if (used_cids =3D=3D NULL)
+		return FALSE;
 =

-	l_uintset_take(used_cids, ctx->context.cid);
-	ctx->context.cid =3D 0;
+	if (!use_cid)
+		use_cid =3D l_uintset_find_unused_min(used_cids);
 =

-	return FALSE;
+	if (use_cid > l_uintset_get_max(used_cids))
+		return FALSE;
+
+	gc =3D find_avail_gprs_context(ctx);
+	if (gc =3D=3D NULL)
+		return FALSE;
+
+	l_uintset_put(used_cids, use_cid);
+	ctx->context.cid =3D use_cid;
+
+	ctx->context_driver =3D gc;
+	ctx->context_driver->inuse =3D TRUE;
+
+	if (ctx->context.proto =3D=3D OFONO_GPRS_PROTO_IPV4V6 ||
+			ctx->context.proto =3D=3D OFONO_GPRS_PROTO_IP)
+		gc->settings->ipv4 =3D g_new0(struct ipv4_settings, 1);
+
+	if (ctx->context.proto =3D=3D OFONO_GPRS_PROTO_IPV4V6 ||
+			ctx->context.proto =3D=3D OFONO_GPRS_PROTO_IPV6)
+		gc->settings->ipv6 =3D g_new0(struct ipv6_settings, 1);
+
+	return TRUE;
 }
 =

 static void release_context(struct pri_context *ctx)
@@ -2032,7 +2041,6 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *gpr=
s, unsigned int cid,
 =

 	if (assign_context(pri_ctx, cid) =3D=3D FALSE) {
 		ofono_warn("Can't assign context to driver for APN.");
-		release_context(pri_ctx);
 		return;
 	}
 =

-- =

2.20.1

--===============5541182852089521740==--

