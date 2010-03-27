Content-Type: multipart/mixed; boundary="===============1133908296952475216=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] ppp: allow empty secret for chap challenge
Date: Fri, 26 Mar 2010 21:36:49 -0700
Message-ID: <1269664610-31900-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269664610-31900-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1133908296952475216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just do a checksum over the identifier if we have an empty password
for our chap secret.
---
 gatchat/ppp_auth.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index 6c3913e..95b2f96 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -83,7 +83,8 @@ static void chap_process_challenge(struct auth_data *auth=
, guint8 *packet)
 	if (!checksum)
 		return;
 	g_checksum_update(checksum, &header->identifier, 1);
-	g_checksum_update(checksum, (guchar *) secret, strlen(secret));
+	if (secret)
+		g_checksum_update(checksum, (guchar *) secret, strlen(secret));
 	g_checksum_update(checksum, &header->data[1], header->data[0]);
 =

 	/* transmit a response packet */
-- =

1.6.6.1


--===============1133908296952475216==--

