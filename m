Content-Type: multipart/mixed; boundary="===============2669313427832566633=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 1/2] hfp_hf_bluez5: Add local HFP version tracking
Date: Wed, 20 Feb 2013 19:26:18 -0300
Message-ID: <1361399179-16734-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2669313427832566633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fallback to HFP 1.5 if defer setup is not supported since it is not
possible to proceed with codec negotiation.
---
 plugins/hfp_hf_bluez5.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 5de6188..cc4e0a2 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -65,6 +65,7 @@ struct hfp {
 =

 static GDBusClient *bluez =3D NULL;
 static guint sco_watch =3D 0;
+static uint16_t local_hfp_version =3D HFP_VERSION_1_6;
 =

 static void hfp_debug(const char *str, void *user_data)
 {
@@ -502,9 +503,11 @@ static int sco_init(void)
 	}
 =

 	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
-				&defer_setup, sizeof(defer_setup)) < 0)
+				&defer_setup, sizeof(defer_setup)) < 0) {
 		ofono_warn("Can't enable deferred setup: %s (%d)",
 						strerror(errno), errno);
+		local_hfp_version =3D HFP_VERSION_1_5;
+	}
 =

 	if (listen(sk, 5) < 0) {
 		close(sk);
-- =

1.7.11.7


--===============2669313427832566633==--

