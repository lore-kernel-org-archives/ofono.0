Content-Type: multipart/mixed; boundary="===============7725751092636611065=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [P-CSCF PATCH 8/8] phonesim: add p-cscf parameters into context_up cb
Date: Wed, 27 Oct 2010 18:39:14 +0300
Message-ID: <1288193954-18402-8-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1288193954-18402-7-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7725751092636611065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/phonesim.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d2faf42..e249d1b 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -88,7 +88,7 @@ static void at_cgact_up_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 	cb(&error, ok ? gcd->interface : NULL, FALSE,
-			NULL, NULL, NULL, NULL, cbd->data);
+		NULL, NULL, NULL, NULL, NULL, cbd->data);
 }
 =

 static void at_cgact_down_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
@@ -130,7 +130,7 @@ static void phonesim_activate_primary(struct ofono_gprs=
_context *gc,
 error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, NULL, data);
 }
 =

 static void phonesim_deactivate_primary(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============7725751092636611065==--

