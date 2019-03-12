Content-Type: multipart/mixed; boundary="===============3130776528554144083=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 12/14] Separate ATE and AT+CMEE commands
Date: Tue, 12 Mar 2019 12:10:06 +0100
Message-ID: <20190312111008.29258-13-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3130776528554144083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The TOBY L4 doesn't seem to like seeing these two commands on the same
line...
---
 plugins/ublox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 038b55d5..7a93adb2 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -281,7 +281,9 @@ static int ublox_enable(struct ofono_modem *modem)
 	/* The modem can take a while to wake up if just powered on. */
 	g_at_chat_set_wakeup_command(data->aux, "AT\r", 1000, 11000);
 =

-	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
+	g_at_chat_send(data->aux, "ATE0", none_prefix,
+					NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "AT+CMEE=3D1", none_prefix,
 					NULL, NULL, NULL);
 =

 	if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
-- =

2.19.1


--===============3130776528554144083==--

