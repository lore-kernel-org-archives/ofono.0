Content-Type: multipart/mixed; boundary="===============7448196955988540932=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Andr=C3=A9?= Draszik <git@andred.net>
Subject: [PATCH v2] plugins: telit: send AT&C0 on both channels
Date: Tue, 07 Feb 2017 11:26:50 +0000
Message-ID: <20170207112650.10222-1-git@andred.net>
In-Reply-To: <20170207085757.4712-1-git@andred.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7448196955988540932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At least firmware version 12.00.405 on the UE910-EUR otherwise
closes the AT command port whenever the PPP connection is
dropped, and we'd be left in a funny state.

---
Changes in v2: Commit message updated
---
 plugins/telit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 742e06c0..0ae16408 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -249,9 +249,10 @@ static void cfun_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	/*
 	 * Switch data carrier detect signal off.
 	 * When the DCD is disabled the modem does not hangup anymore
-	 * after the data connection.
+	 * after the data connection. We need to do that on both channels.
 	 */
 	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
 =

 	data->have_sim =3D FALSE;
 	data->sms_phonebook_added =3D FALSE;
-- =

2.11.0


--===============7448196955988540932==--

