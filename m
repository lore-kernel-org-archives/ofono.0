Content-Type: multipart/mixed; boundary="===============5986152021411530495=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] gprs-context: Remove unused field from struct
 ofono_gprs_primary_context
Date: Tue, 11 Oct 2016 00:07:27 +0300
Message-ID: <1476133647-18681-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5986152021411530495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index c4910f2..ab67326 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -55,7 +55,6 @@ enum ofono_gprs_auth_method {
 =

 struct ofono_gprs_primary_context {
 	unsigned int cid;
-	int direction;
 	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
-- =

1.9.1


--===============5986152021411530495==--

