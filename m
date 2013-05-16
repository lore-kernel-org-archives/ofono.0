Content-Type: multipart/mixed; boundary="===============8565461956081349355=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 13/22] hfp_ag_bluez5: Register HFP AG version 1.6
Date: Thu, 16 May 2013 14:16:33 -0300
Message-ID: <1368724602-27781-14-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8565461956081349355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 4523165..58785d1 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -285,7 +285,7 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *data)
 	if (modems->next !=3D NULL)
 		return;
 =

-	bt_register_profile(conn, HFP_AG_UUID, HFP_VERSION_1_5, "hfp_ag",
+	bt_register_profile(conn, HFP_AG_UUID, HFP_VERSION_1_6, "hfp_ag",
 					HFP_AG_EXT_PROFILE_PATH, NULL, 0);
 }
 =

-- =

1.7.9.5


--===============8565461956081349355==--

