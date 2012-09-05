Content-Type: multipart/mixed; boundary="===============2528698426102024287=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 4/4] atmodem: specify class for call barring query
Date: Wed, 05 Sep 2012 18:56:22 +0200
Message-ID: <1346864182-24464-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346864182-24464-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2528698426102024287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

class is specified when querying the call barring status if
the class is not the default (7 - voice, data and fax)
---
 drivers/atmodem/call-barring.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index 2efd4e9..a2417c7 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -89,7 +89,10 @@ static void at_call_barring_query(struct ofono_call_barr=
ing *cb,
 	if (strlen(lock) !=3D 2)
 		goto error;
 =

-	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2", lock);
+	if (cls =3D=3D 7)
+		snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2", lock);
+	else
+		snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2,,%d", lock, cls);
 =

 	if (g_at_chat_send(chat, buf, clck_prefix,
 				clck_query_cb, cbd, g_free) > 0)
-- =

1.7.9.5


--===============2528698426102024287==--

