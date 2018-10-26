Content-Type: multipart/mixed; boundary="===============6732005915101144331=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 8/9] atmodem: prevent use of uninitialized value
Date: Fri, 26 Oct 2018 12:13:18 +0200
Message-ID: <20181026101319.27709-9-jonas@norrbonn.se>
In-Reply-To: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6732005915101144331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jonas Bonn <jonas@southpole.se>

Move initialization of 'dcs' ahead of 'content' fetch to prevent using
uninitialized 'dcs' in ofono_ussd_notify.
---
 drivers/atmodem/ussd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index f1907a00..8416bec6 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -117,12 +117,12 @@ static void cusd_parse(GAtResult *result, struct ofon=
o_ussd *ussd)
 	if (!g_at_result_iter_next_number(&iter, &status))
 		return;
 =

-	if (!g_at_result_iter_next_string(&iter, &content))
-		goto out;
-
 	if (!g_at_result_iter_next_number(&iter, &dcs))
 		dcs =3D 0;
 =

+	if (!g_at_result_iter_next_string(&iter, &content))
+		goto out;
+
 	if (!cbs_dcs_decode(dcs, NULL, NULL, &charset, NULL, NULL, NULL)) {
 		ofono_error("Unsupported USSD data coding scheme (%02x)", dcs);
 		status =3D 4; /* Not supported */
-- =

2.17.1


--===============6732005915101144331==--

