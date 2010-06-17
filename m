Content-Type: multipart/mixed; boundary="===============1788416346709475791=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] mbmmodem: Allow no response data for envelope.
Date: Thu, 17 Jun 2010 15:42:11 +0200
Message-ID: <1276782135-26871-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276782135-26871-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1788416346709475791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Partially reverts
http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dcommitdiff;h=3Df98c6=
dc91702c0d14c0afa2a4e32102d3105568d
---
 drivers/mbmmodem/stk.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mbmmodem/stk.c b/drivers/mbmmodem/stk.c
index cea902e..77bd7b5 100644
--- a/drivers/mbmmodem/stk.c
+++ b/drivers/mbmmodem/stk.c
@@ -52,8 +52,8 @@ static void mbm_stke_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 	ofono_stk_envelope_cb_t cb =3D cbd->cb;
 	GAtResultIter iter;
 	struct ofono_error error;
-	const guint8 *pdu;
-	gint len;
+	const guint8 *pdu =3D NULL;
+	gint len =3D 0;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 =

@@ -64,11 +64,9 @@ static void mbm_stke_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (g_at_result_iter_next(&iter, "*STKE:") =3D=3D FALSE)
-		goto error;
-
-	if (g_at_result_iter_next_hexstring(&iter, &pdu, &len) =3D=3D FALSE)
-		goto error;
+	if (g_at_result_iter_next(&iter, "*STKE:") =3D=3D TRUE)
+		if (g_at_result_iter_next_hexstring(&iter, &pdu, &len) =3D=3D FALSE)
+			goto error;
 =

 	cb(&error, pdu, len, cbd->data);
 	return;
-- =

1.7.1.86.g0e460.dirty


--===============1788416346709475791==--

