Content-Type: multipart/mixed; boundary="===============0981060921539854277=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] It is better to use decode_at_error.
Date: Thu, 07 Jul 2011 18:39:03 +0200
Message-ID: <1310056743-10948-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0981060921539854277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/zte.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index 822098d..6a4b374 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -233,11 +233,10 @@ static void set_online_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
 =

-	if (ok)
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	else
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
 }
 =

 static void zte_set_online(struct ofono_modem *modem, ofono_bool_t online,
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============0981060921539854277==--

