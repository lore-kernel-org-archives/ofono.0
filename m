Content-Type: multipart/mixed; boundary="===============6828403136206476403=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 2/3] hfp_hf_bluez5: Change register profile call
Date: Mon, 25 Feb 2013 17:36:02 -0300
Message-ID: <1361824563-13618-2-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1361824563-13618-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6828403136206476403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 7057d71..ebe411a 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -529,7 +529,7 @@ static void connect_handler(DBusConnection *conn, void =
*user_data)
 	DBG("Registering External Profile handler ...");
 =

 	bt_register_profile(conn, HFP_HS_UUID, local_hfp_version, "hfp_hf",
-						HFP_EXT_PROFILE_PATH);
+						HFP_EXT_PROFILE_PATH, NULL);
 }
 =

 static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
-- =

1.7.9.5


--===============6828403136206476403==--

