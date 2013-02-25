Content-Type: multipart/mixed; boundary="===============8792863821715354252=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 3/3] hfp_ag_bluez5: Change register profile call
Date: Mon, 25 Feb 2013 17:36:03 -0300
Message-ID: <1361824563-13618-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1361824563-13618-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8792863821715354252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index a81adfd..3c4a34e 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -181,7 +181,7 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *data)
 		return;
 =

 	bt_register_profile(conn, HFP_AG_UUID, HFP_VERSION_1_5, "hfp_ag",
-						HFP_AG_EXT_PROFILE_PATH);
+						HFP_AG_EXT_PROFILE_PATH, NULL);
 }
 =

 static gboolean sim_watch_remove(gpointer key, gpointer value,
-- =

1.7.9.5


--===============8792863821715354252==--

