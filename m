Content-Type: multipart/mixed; boundary="===============3082577345099144651=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [P-CSCF PATCH 4/8] ifx: add p-cscf parameters into context_up cb
Date: Wed, 27 Oct 2010 18:39:10 +0300
Message-ID: <1288193954-18402-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1288193954-18402-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3082577345099144651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/ifxmodem/gprs-context.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 2a2b8df..54a466f 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -124,12 +124,12 @@ static void failed_setup(struct ofono_gprs_context *g=
c,
 =

 	if (!result) {
 		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL, NULL,
-						NULL, NULL, gcd->cb_data);
+					NULL, NULL, NULL, gcd->cb_data);
 		return;
 	}
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	gcd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL, gcd->cb_data);
+	gcd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL, NULL, gcd->cb_data);
 }
 =

 static void session_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -158,7 +158,8 @@ static void session_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		interface =3D "invalid";
 =

 	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, gcd->address,
-				STATIC_IP_NETMASK, NULL, dns, gcd->cb_data);
+				STATIC_IP_NETMASK, NULL, dns, NULL,
+				gcd->cb_data);
 =

 	gcd->up_cb =3D NULL;
 	gcd->cb_data =3D NULL;
@@ -342,7 +343,7 @@ static void ifx_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 				setup_cb, gc, NULL) > 0)
 		return;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL, data);
 }
 =

 static void deactivate_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
-- =

1.7.1


--===============3082577345099144651==--

