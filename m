Content-Type: multipart/mixed; boundary="===============8391518946218734056=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] mbm: D5530 gets bogus +GCAP, not +CGAP
Date: Mon, 30 Aug 2010 16:36:31 +0300
Message-ID: <1283175391-20915-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8391518946218734056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/mbm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index d0e084f..46cf7a0 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -158,7 +158,7 @@ static void mbm_quirk_d5530(struct ofono_modem *modem)
 	/* Try to ignore them. */
 	g_at_chat_register(data->modem_port, "D5530", d5530_notify,
 				FALSE, NULL, NULL);
-	g_at_chat_register(data->modem_port, "+CGAP:", d5530_notify,
+	g_at_chat_register(data->modem_port, "+GCAP:", d5530_notify,
 				FALSE, NULL, NULL);
 }
 =

-- =

1.7.0.4


--===============8391518946218734056==--

