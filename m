Content-Type: multipart/mixed; boundary="===============5080328816093833529=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] ctm: use ofono_error instead of DBG for errors
Date: Wed, 15 Dec 2010 19:06:53 -0200
Message-ID: <1292447213-16751-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5080328816093833529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ctm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ctm.c b/src/ctm.c
index 1df34c2..2c82c2e 100644
--- a/src/ctm.c
+++ b/src/ctm.c
@@ -90,7 +90,7 @@ static void ctm_set_enabled_callback(const struct ofono_e=
rror *error,
 	DBusMessage *reply;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Error setting ctm enabled property");
+		ofono_error("Error setting ctm enabled property");
 =

 		reply =3D __ofono_error_failed(ctm->pending);
 		__ofono_dbus_pending_reply(&ctm->pending, reply);
@@ -116,7 +116,7 @@ static void ctm_query_enabled_callback(const struct ofo=
no_error *error,
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBusMessage *reply;
 =

-		DBG("Error during ctm enabled query");
+		ofono_error("Error during ctm enabled query");
 =

 		reply =3D __ofono_error_failed(ctm->pending);
 		__ofono_dbus_pending_reply(&ctm->pending, reply);
-- =

1.7.3.2


--===============5080328816093833529==--

