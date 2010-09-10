Content-Type: multipart/mixed; boundary="===============0013703545591910531=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH v2 4/4] sms_util: fix status report backuping to support
 uint msg_id
Date: Fri, 10 Sep 2010 17:28:22 +0300
Message-ID: <1284128902-16727-4-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1284128902-16727-3-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0013703545591910531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index a124f54..26c7951 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -46,7 +46,7 @@
 #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
 =

 #define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
-#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH "/%s-%i"
+#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH "/%s-%u"
 =

 #define SMS_ADDR_FMT "%24[0-9A-F]"
 =

@@ -2761,7 +2761,7 @@ static gboolean sr_assembly_add_fragment_backup(const=
 char *imsi,
 	if (sms_address_to_hex_string(addr, straddr) =3D=3D FALSE)
 		return FALSE;
 =

-	/* storagedir/%s/sms_sr/%s-%i */
+	/* storagedir/%s/sms_sr/%s-%u */
 	if (write_file((unsigned char *) node, len, SMS_BACKUP_MODE,
 			SMS_SR_BACKUP_PATH_FILE, imsi,
 			straddr, msg_id) !=3D len)
-- =

1.6.3.3



--===============0013703545591910531==--

