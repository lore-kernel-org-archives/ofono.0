Content-Type: multipart/mixed; boundary="===============3424182271099834445=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 3/3] hfp_hf_bluez5: Register the SDP record with correct
 features
Date: Tue, 23 Apr 2013 18:21:52 -0300
Message-ID: <1366752112-8007-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366752112-8007-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3424182271099834445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 826796f..06b6fd3 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -636,10 +636,15 @@ static const GDBusMethodTable profile_methods[] =3D {
 =

 static void connect_handler(DBusConnection *conn, void *user_data)
 {
+	uint16_t features =3D HFP_SDP_HF_FEATURE_3WAY |
+				HFP_SDP_HF_FEATURE_CLIP |
+				HFP_SDP_HF_FEATURE_REMOTE_VOLUME_CONTROL |
+				HFP_SDP_HF_FEATURE_WIDEBAND_SPEECH;
+
 	DBG("Registering External Profile handler ...");
 =

 	bt_register_profile(conn, HFP_HS_UUID, HFP_VERSION_1_6, "hfp_hf",
-					HFP_EXT_PROFILE_PATH, NULL, 0);
+					HFP_EXT_PROFILE_PATH, NULL, features);
 }
 =

 static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
-- =

1.8.2.1


--===============3424182271099834445==--

