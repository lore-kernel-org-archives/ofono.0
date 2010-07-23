Content-Type: multipart/mixed; boundary="===============2268451818668815440=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 05/20] introduce DECLARE_SMS_ADDR_STR()
Date: Fri, 23 Jul 2010 13:59:53 -0700
Message-ID: <c8d46d04c81da20902f52f017b7081ef8f042545.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2268451818668815440==
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
 src/smsutil.h |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index f93ea5b..3f743ef 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2315,7 +2315,7 @@ static void sms_assembly_load(struct sms_assembly *as=
sembly,
 				const struct dirent *dir)
 {
 	struct sms_address addr;
-	char straddr[25];
+	DECLARE_SMS_ADDR_STR(straddr);
 	guint16 ref;
 	guint8 max;
 	guint8 seq;
@@ -2392,7 +2392,7 @@ static gboolean sms_assembly_store(struct sms_assembl=
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
index fbe3c72..59297a0 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -438,6 +438,12 @@ gboolean sms_decode_unpacked_stk_pdu(const unsigned ch=
ar *pdu, int len,
 gboolean sms_encode(const struct sms *in, int *len, int *tpdu_len,
 			unsigned char *pdu);
 =

+/*
+ * Length is based on the address being 12 hex characters plus a
+ * terminating NUL char. See sms_assembly_extract_address().
+ */
+#define DECLARE_SMS_ADDR_STR(a) char a[25]
+
 gboolean sms_decode_address_field(const unsigned char *pdu, int len,
 					int *offset, gboolean sc,
 					struct sms_address *out);
-- =

1.6.6.1


--===============2268451818668815440==--

