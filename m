Content-Type: multipart/mixed; boundary="===============0990333115053908547=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 01/14] Fix whitespace weirdness
Date: Tue, 12 Mar 2019 12:09:55 +0100
Message-ID: <20190312111008.29258-2-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0990333115053908547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/network-registration.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 2482dfc3..1704f98c 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1559,12 +1559,12 @@ static void creg_notify(GAtResult *result, gpointer=
 user_data)
 					option_query_tech_cb, tq, g_free) > 0)
 			return;
 		break;
-    case OFONO_VENDOR_GEMALTO:
-              if (g_at_chat_send(nd->chat, "AT^SMONI",
-                                      smoni_prefix,
-                                      gemalto_query_tech_cb, tq, g_free) >=
 0)
-                      return;
-              break;
+	case OFONO_VENDOR_GEMALTO:
+		if (g_at_chat_send(nd->chat, "AT^SMONI",
+			      smoni_prefix,
+			      gemalto_query_tech_cb, tq, g_free) > 0)
+			return;
+		break;
 	}
 =

 	g_free(tq);
-- =

2.19.1


--===============0990333115053908547==--

