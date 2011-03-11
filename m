Content-Type: multipart/mixed; boundary="===============8663305752539869790=="
MIME-Version: 1.0
From: Paavo Leinonen <paavo.leinonen@tieto.com>
Subject: [PATCH] atmodem: fix PB reading when fields are omitted
Date: Fri, 11 Mar 2011 14:25:47 +0200
Message-ID: <1299846347-8644-1-git-send-email-paavo.leinonen@tieto.com>
In-Reply-To: <1299655650-7929-1-git-send-email-paavo.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8663305752539869790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix SIM PB reading when numeric fields have been omitted.

---

Hi,

Here is the fix for SIM PB reading as proposed.

BR,
Paavo

 drivers/atmodem/phonebook.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
index 97213db..ebac563 100644
--- a/drivers/atmodem/phonebook.c
+++ b/drivers/atmodem/phonebook.c
@@ -172,10 +172,10 @@ static void at_cpbr_notify(GAtResult *result, gpointe=
r user_data)
 			continue;
 		}
 =

-		g_at_result_iter_next_number(&iter, &hidden);
+		g_at_result_iter_next_number_default(&iter, 0, &hidden);
 		parse_text(&iter, &group, current);
 		g_at_result_iter_next_string(&iter, &adnumber);
-		g_at_result_iter_next_number(&iter, &adtype);
+		g_at_result_iter_next_number_default(&iter, 0, &adtype);
 		parse_text(&iter, &secondtext, current);
 		parse_text(&iter, &email, current);
 		parse_text(&iter, &sip_uri, current);
-- =

1.7.1


--===============8663305752539869790==--

