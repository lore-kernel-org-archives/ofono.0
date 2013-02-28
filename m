Content-Type: multipart/mixed; boundary="===============5244612726147729063=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 10/10] hfp_hf_bluez5: Fix hard-coded hfp version
Date: Thu, 28 Feb 2013 15:52:52 -0300
Message-ID: <1362077572-28049-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5244612726147729063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes the hard-coded Handsfree Profile version to register
the external BlueZ profile.
---
 plugins/hfp_hf_bluez5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index ea2c848..c1f3ba2 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -484,8 +484,8 @@ static void connect_handler(DBusConnection *conn, void =
*user_data)
 {
 	DBG("Registering External Profile handler ...");
 =

-	bt_register_profile(conn, HFP_HS_UUID, HFP_VERSION_1_5, "hfp_hf",
-						HFP_EXT_PROFILE_PATH);
+	bt_register_profile(conn, HFP_HS_UUID, ofono_handsfree_get_version(),
+					"hfp_hf", HFP_EXT_PROFILE_PATH);
 }
 =

 static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
-- =

1.7.11.7


--===============5244612726147729063==--

