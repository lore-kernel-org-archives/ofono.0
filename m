Content-Type: multipart/mixed; boundary="===============1825846976442851706=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] stemodem: Always run +CGACT? when we get +CGEV.
Date: Fri, 14 Jan 2011 12:18:04 +0100
Message-ID: <1295003884-11243-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1825846976442851706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

Remove checks for certain values of CGEV, and instead we will
always run CGACT? to check what contexts that are active.
---
 drivers/stemodem/gprs-context.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 1762fb3..a084cd4 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -531,13 +531,9 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
 		return;
 =

-	if (g_str_has_prefix(event, "NW REACT ") ||
-			g_str_has_prefix(event, "NW DEACT ") ||
-			g_str_has_prefix(event, "ME DEACT ")) {
-		/* Ask what primary contexts are active now */
-		g_at_chat_send(gcd->chat, "AT+CGACT?", cgact_prefix,
-				ste_cgact_read_cb, gc, NULL);
-	}
+	/* Ask what primary contexts are active now */
+	g_at_chat_send(gcd->chat, "AT+CGACT?", cgact_prefix,
+			ste_cgact_read_cb, gc, NULL);
 }
 =

 static int ste_gprs_context_probe(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============1825846976442851706==--

