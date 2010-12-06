Content-Type: multipart/mixed; boundary="===============6373238392978176210=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 03/14] atmodem: cleanup DBG messages
Date: Mon, 06 Dec 2010 18:12:31 -0200
Message-ID: <1291666362-19128-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6373238392978176210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/call-settings.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index 05c9438..7e1b422 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -164,7 +164,7 @@ static void clip_query_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	g_at_result_iter_skip_next(&iter);
 	g_at_result_iter_next_number(&iter, &status);
 =

-	DBG("clip_query_cb: network: %d", status);
+	DBG("network: %d", status);
 =

 	cb(&error, status, cbd->data);
 }
@@ -214,7 +214,7 @@ static void colp_query_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	g_at_result_iter_skip_next(&iter);
 	g_at_result_iter_next_number(&iter, &status);
 =

-	DBG("colp_query_cb: network: %d", status);
+	DBG("network: %d", status);
 =

 	cb(&error, status, cbd->data);
 }
@@ -263,7 +263,7 @@ static void clir_query_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	g_at_result_iter_next_number(&iter, &override);
 	g_at_result_iter_next_number(&iter, &network);
 =

-	DBG("clir_query_cb: override: %d, network: %d", override, network);
+	DBG("override: %d, network: %d", override, network);
 =

 	cb(&error, override, network, cbd->data);
 }
@@ -343,7 +343,7 @@ static void colr_query_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	if (g_at_result_iter_next_number(&iter, &status) =3D=3D FALSE)
 		goto error;
 =

-	DBG("colr_query_cb: network: %d", status);
+	DBG("network: %d", status);
 =

 	cb(&error, status, cbd->data);
 	return;
-- =

1.7.3.2


--===============6373238392978176210==--

