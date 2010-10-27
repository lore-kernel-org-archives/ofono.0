Content-Type: multipart/mixed; boundary="===============7411886349227373128=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [P-CSCF PATCH 7/8] ste: add NULL p-cscf parameter into context_up cb
Date: Wed, 27 Oct 2010 18:39:13 +0300
Message-ID: <1288193954-18402-7-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1288193954-18402-6-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7411886349227373128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/stemodem/gprs-context.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index d3a50a9..f967512 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -290,11 +290,11 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 				conn->interface);
 		CALLBACK_WITH_SUCCESS(cb, NULL, FALSE, rsp.ip_address,
 				rsp.subnet_mask, rsp.default_gateway,
-				dns, cbd->data);
+				dns, NULL, cbd->data);
 	} else {
 		CALLBACK_WITH_SUCCESS(cb, conn->interface,
 				FALSE, rsp.ip_address, rsp.subnet_mask,
-				rsp.default_gateway, dns, cbd->data);
+				rsp.default_gateway, dns, NULL, cbd->data);
 	}
 =

 	return;
@@ -308,7 +308,8 @@ error:
 	if (conn)
 		conn->cid =3D 0;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL,
+				cbd->data);
 }
 =

 static void ste_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -328,7 +329,7 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		gcd->active_context =3D 0;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, NULL, cbd->data);
 		return;
 	}
 =

@@ -357,7 +358,7 @@ error:
 	gcd->active_context =3D 0;
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL,
-				NULL, NULL, cbd->data);
+				NULL, NULL, NULL, cbd->data);
 }
 =

 static void ste_gprs_activate_primary(struct ofono_gprs_context *gc,
@@ -400,7 +401,7 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL, data);
 }
 =

 static void ste_gprs_deactivate_primary(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============7411886349227373128==--

