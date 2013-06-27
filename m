Content-Type: multipart/mixed; boundary="===============2099451633950670270=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/2] hfp_hf_bluez5: Fix SDP record with correct features
Date: Thu, 27 Jun 2013 14:45:58 +0200
Message-ID: <1372337158-20173-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1372337158-20173-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2099451633950670270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 7c663b5..40d8ce0 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -636,7 +636,8 @@ static const GDBusMethodTable profile_methods[] =3D {
 =

 static void connect_handler(DBusConnection *conn, void *user_data)
 {
-	uint16_t features =3D HFP_SDP_HF_FEATURE_3WAY |
+	uint16_t features =3D HFP_SDP_HF_FEATURE_ECNR |
+				HFP_SDP_HF_FEATURE_3WAY |
 				HFP_SDP_HF_FEATURE_CLIP |
 				HFP_SDP_HF_FEATURE_REMOTE_VOLUME_CONTROL;
 =

-- =

1.7.9.5


--===============2099451633950670270==--

