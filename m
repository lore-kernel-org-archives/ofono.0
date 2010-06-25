Content-Type: multipart/mixed; boundary="===============1147705275934814132=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 07/23] introduce DECLARE_SMS_ADDR_STR()
Date: Fri, 25 Jun 2010 16:15:29 -0700
Message-ID: <9ef38420df1d42245dd852123b5cd885cc770481.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1147705275934814132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Introduce DECLARE_SMS_ADDR_STR(), which declares a string variable of
the right size for passing to sms_assembly_decode_address(). This way
we detach each client having to have the knowledge of what the right
size is, leaving that decission to the infrastructure
provider. Updated couple of sites in smsutil.c to use it vs a raw
declaration.
---
 src/smsutil.c |    4 ++--
 src/smsutil.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 96c5001..78fabf5 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2314,7 +2314,7 @@ static void sms_assembly_load(struct sms_assembly *as=
sembly,
 				const struct dirent *dir)
 {
 	struct sms_address addr;
-	char straddr[25];
+	DECLARE_SMS_ADDR_STR(straddr);
 	guint16 ref;
 	guint8 max;
 	guint8 seq;
@@ -2391,7 +2391,7 @@ static gboolean sms_assembly_store(struct sms_assembl=
y *assembly,
 {
 	unsigned char buf[177];
 	int len;
-	char straddr[25];
+	DECLARE_SMS_ADDR_STR(straddr);
 =

 	if (!assembly->imsi)
 		return FALSE;
diff --git a/src/smsutil.h b/src/smsutil.h
index 9f43c0b..1c272bc 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -440,6 +440,9 @@ gboolean sms_decode_unpacked_stk_pdu(const unsigned cha=
r *pdu, int len,
 gboolean sms_encode(const struct sms *in, int *len, int *tpdu_len,
 			unsigned char *pdu);
 =

+enum { SMS_ADDR_STR_SIZE =3D 25 };
+#define DECLARE_SMS_ADDR_STR(a) char a[SMS_ADDR_STR_SIZE]
+
 gboolean sms_decode_address_field(const unsigned char *pdu, int len,
 					int *offset, gboolean sc,
 					struct sms_address *out);
-- =

1.6.6.1


--===============1147705275934814132==--

