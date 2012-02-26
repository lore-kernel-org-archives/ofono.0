Content-Type: multipart/mixed; boundary="===============1846618649763348443=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: [PATCH] hso: Don't access freed data, in hso_set_online
Date: Sun, 26 Feb 2012 17:43:56 +0000
Message-ID: <1330278236-1335-1-git-send-email-neil@ossau.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1846618649763348443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hso.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/hso.c b/plugins/hso.c
index 4834c56..697beaa 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -422,7 +422,7 @@ static void hso_set_online(struct ofono_modem *modem, o=
fono_bool_t online,
 =

 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 =

 static void hso_pre_sim(struct ofono_modem *modem)
-- =

1.7.9


--===============1846618649763348443==--

