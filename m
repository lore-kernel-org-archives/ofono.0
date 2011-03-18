Content-Type: multipart/mixed; boundary="===============3665581767253518025=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Fix a memory leak reported by cppcheck.
Date: Fri, 18 Mar 2011 14:18:02 +0100
Message-ID: <1300454282-21431-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3665581767253518025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 5524932..e781399 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3344,7 +3344,7 @@ void sms_tx_backup_free(const char *imsi, unsigned lo=
ng id,
 	len =3D scandir(path, &entries, NULL, versionsort);
 =

 	if (len < 0)
-		return;
+		goto nodir_exit;
 =

 	/* skip '..' and '.' entries */
 	while (len-- > 2) {
@@ -3362,6 +3362,8 @@ void sms_tx_backup_free(const char *imsi, unsigned lo=
ng id,
 	g_free(entries);
 =

 	rmdir(path);
+
+nodir_exit:
 	g_free(path);
 }
 =

-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============3665581767253518025==--

