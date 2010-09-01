Content-Type: multipart/mixed; boundary="===============6049926595027826349=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 1/2] smsutil: use DECLARE_SMS_ADDR_STR in
 sms_assembly_backup_free
Date: Wed, 01 Sep 2010 18:59:31 +0300
Message-ID: <1283356772-18015-2-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1283356772-18015-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6049926595027826349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 9ca46f0..c8f6a4a 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2416,7 +2416,7 @@ static void sms_assembly_backup_free(struct sms_assem=
bly *assembly,
 {
 	char *path;
 	int seq;
-	char straddr[25];
+	DECLARE_SMS_ADDR_STR(straddr);
 =

 	if (!assembly->imsi)
 		return;
-- =

1.6.3.3



--===============6049926595027826349==--

