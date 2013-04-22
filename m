Content-Type: multipart/mixed; boundary="===============0679790076096196064=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/3] hfp_hf_bluez5: Register the SDP record with correct
 features
Date: Mon, 22 Apr 2013 14:54:12 -0300
Message-ID: <1366653252-19791-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366653252-19791-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0679790076096196064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2b9275b..d975a42 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -636,10 +636,19 @@ static const GDBusMethodTable profile_methods[] =3D {
 =

 static void connect_handler(DBusConnection *conn, void *user_data)
 {
+	struct bt_profile_info optional;
+
+	memset(&optional, 0, sizeof(optional));
+
+	optional.features =3D HFP_SDP_HF_FEATURE_3WAY |
+				HFP_SDP_HF_FEATURE_CLIP |
+				HFP_SDP_HF_FEATURE_REMOTE_VOLUME_CONTROL |
+				HFP_SDP_HF_FEATURE_WIDEBAND_SPEECH;
+
 	DBG("Registering External Profile handler ...");
 =

-	bt_register_profile(conn, HFP_HS_UUID, HFP_VERSION_1_6, "hfp_hf",
-						HFP_EXT_PROFILE_PATH);
+	bt_register_profile_full(conn, HFP_HS_UUID, HFP_VERSION_1_6, "hfp_hf",
+					HFP_EXT_PROFILE_PATH, &optional);
 }
 =

 static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
-- =

1.8.2.1


--===============0679790076096196064==--

