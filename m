Content-Type: multipart/mixed; boundary="===============5291845706407954469=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] zte: use AT+CFUN=1;+CFUN=4 in enable
Date: Mon, 08 Nov 2010 19:46:57 +0200
Message-ID: <1289238417-21476-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5291845706407954469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Direct +CFUN transition 0 -> 4 gets SIM in inconsistent state.
---
 plugins/zte.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index 07f8466..83602eb 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -184,7 +184,8 @@ static int zte_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
 						NULL, NULL, NULL);
 =

-	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
+	/* Direct transition 0 -> 4 leaves SIM hosed */
+	g_at_chat_send(data->aux, "AT+CFUN=3D1;+CFUN=3D4", none_prefix,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
-- =

1.7.1


--===============5291845706407954469==--

