Content-Type: multipart/mixed; boundary="===============6631338651296111405=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH 2/4] gprs: Always call gprs_attached_update on context
 deactivation.
Date: Wed, 14 Aug 2019 20:24:42 +0200
Message-ID: <20190814182444.13508-2-richard.rojfors@gmail.com>
In-Reply-To: <20190814182444.13508-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6631338651296111405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

Since its registered context is a condition for being attached
when running LTE, we might need to update the attached state
when a context is deactivated. Otherwise we might remain
attached, and connection managers (at least connman) start
to hammer us to connect a context, eventhough it happens
automatically in LTE.
---
 src/gprs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 94d13f82..cb31e2d2 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2738,11 +2738,12 @@ void ofono_gprs_context_deactivated(struct ofono_gp=
rs_context *gc,
 	 * If "Attached" property was about to be signalled as TRUE but there
 	 * were still active contexts, try again to signal "Attached" property
 	 * to registered applications after active contexts have been released.
+	 *
+	 * ... or in the case of LTE where the attached state were a registered
+	 * context is a condition for being attached
 	 */
-	if (gc->gprs->flags & GPRS_FLAG_ATTACHED_UPDATE) {
-		gc->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
-		gprs_attached_update(gc->gprs);
-	}
+	gc->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
+	gprs_attached_update(gc->gprs);
 }
 =

 int ofono_gprs_context_driver_register(
-- =

2.20.1


--===============6631338651296111405==--

