Content-Type: multipart/mixed; boundary="===============4426921748258264718=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 8/8] call-settings: class applied is the class given by SS
 code.
Date: Wed, 22 Aug 2012 18:18:23 +0200
Message-ID: <1345652303-12866-8-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345652303-12866-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4426921748258264718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The default class is applied when no class is specified by SS code.
---
 src/call-settings.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index 51f96bf..d63d9d8 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -485,7 +485,7 @@ static void cw_ss_set_callback(const struct ofono_error=
 *error, void *data)
 		return;
 	}
 =

-	cs->driver->cw_query(cs, BEARER_CLASS_DEFAULT,
+	cs->driver->cw_query(cs, cs->ss_req_cls,
 				cw_ss_query_callback, cs);
 }
 =

@@ -533,13 +533,13 @@ static gboolean cw_ss_control(int type,
 			goto bad_format;
 	}
 =

-	cs->ss_req_cls =3D cls;
-	cs->pending =3D dbus_message_ref(msg);
-
 	/* For the default case use the more readily accepted value */
 	if (cls =3D=3D BEARER_CLASS_SS_DEFAULT)
 		cls =3D BEARER_CLASS_DEFAULT;
 =

+	cs->ss_req_cls =3D cls;
+	cs->pending =3D dbus_message_ref(msg);
+
 	switch (type) {
 	case SS_CONTROL_TYPE_REGISTRATION:
 	case SS_CONTROL_TYPE_ACTIVATION:
@@ -554,8 +554,7 @@ static gboolean cw_ss_control(int type,
 		 * according to 22.004 Appendix A, so CLASS_DEFAULT
 		 * is safe to use here
 		 */
-		cs->driver->cw_query(cs, BEARER_CLASS_DEFAULT,
-					cw_ss_query_callback, cs);
+		cs->driver->cw_query(cs, cls, cw_ss_query_callback, cs);
 		break;
 =

 	case SS_CONTROL_TYPE_DEACTIVATION:
-- =

1.7.9.5


--===============4426921748258264718==--

