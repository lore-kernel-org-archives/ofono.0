Content-Type: multipart/mixed; boundary="===============8322558336377621499=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] smsutil: do not allow larger file names
Date: Fri, 28 Jan 2011 00:48:59 -0200
Message-ID: <1296182939-32316-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8322558336377621499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If file name had anything in the name after addr-msgid, it would be
parsed as well. This is not what we want, since there could be temporary
files lying around.
---
 src/smsutil.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 3a54fe6..ae9da0d 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2713,6 +2713,7 @@ static void sr_assembly_load_backup(GHashTable *assem=
bly_table,
 	unsigned int *id_table_key;
 	char msgid_str[SMS_MSGID_LEN * 2 + 1];
 	unsigned char msgid[SMS_MSGID_LEN];
+	char endc;
 =

 	if (addr_dir->d_type !=3D DT_REG)
 		return;
@@ -2724,8 +2725,8 @@ static void sr_assembly_load_backup(GHashTable *assem=
bly_table,
 	 * Max of SMS address size is 12 bytes, hex encoded
 	 * Max of SMS SHA1 hash is 20 bytes, hex encoded
 	 */
-	if (sscanf(addr_dir->d_name, SMS_ADDR_FMT "-" SMS_MSGID_FMT,
-				straddr, msgid_str) < 2)
+	if (sscanf(addr_dir->d_name, SMS_ADDR_FMT "-" SMS_MSGID_FMT "%c",
+				straddr, msgid_str, &endc) !=3D 2)
 		return;
 =

 	if (sms_assembly_extract_address(straddr, &addr) =3D=3D FALSE)
-- =

1.7.3.5


--===============8322558336377621499==--

