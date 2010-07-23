Content-Type: multipart/mixed; boundary="===============7707260028109127184=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 06/20] _assembly_encode_address: export and rename
Date: Fri, 23 Jul 2010 13:59:54 -0700
Message-ID: <ebfe4b1dd715e2ebe6c155d2c32bce0f42a5014f.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7707260028109127184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

The new name better reflects the function's purpose.

We need to export it, as for generating unique message naming (for
persistence and D-Bus object naming), we'll be using the
address.
---
 src/smsutil.c |    7 +++----
 src/smsutil.h |    2 ++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 3f743ef..969c1b7 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2294,8 +2294,7 @@ static gboolean sms_assembly_extract_address(const ch=
ar *straddr,
 	return sms_decode_address_field(pdu, len, &offset, FALSE, out);
 }
 =

-static gboolean sms_assembly_encode_address(const struct sms_address *in,
-						char *straddr)
+gboolean sms_address_to_hex_string(const struct sms_address *in, char *str=
addr)
 {
 	unsigned char pdu[12];
 	int offset =3D 0;
@@ -2397,7 +2396,7 @@ static gboolean sms_assembly_store(struct sms_assembl=
y *assembly,
 	if (!assembly->imsi)
 		return FALSE;
 =

-	if (sms_assembly_encode_address(&node->addr, straddr) =3D=3D FALSE)
+	if (sms_address_to_hex_string(&node->addr, straddr) =3D=3D FALSE)
 		return FALSE;
 =

 	len =3D sms_serialize(buf, sms);
@@ -2420,7 +2419,7 @@ static void sms_assembly_backup_free(struct sms_assem=
bly *assembly,
 	if (!assembly->imsi)
 		return;
 =

-	if (sms_assembly_encode_address(&node->addr, straddr) =3D=3D FALSE)
+	if (sms_address_to_hex_string(&node->addr, straddr) =3D=3D FALSE)
 		return;
 =

 	for (seq =3D 0; seq < node->max_fragments; seq++) {
diff --git a/src/smsutil.h b/src/smsutil.h
index 59297a0..28b5604 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -506,6 +506,8 @@ GSList *sms_assembly_add_fragment(struct sms_assembly *=
assembly,
 					const struct sms_address *addr,
 					guint16 ref, guint8 max, guint8 seq);
 void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
+gboolean sms_address_to_hex_string(const struct sms_address *in,
+				   char *straddr);
 =

 struct status_report_assembly *status_report_assembly_new(const char *imsi=
);
 void status_report_assembly_free(struct status_report_assembly *assembly);
-- =

1.6.6.1


--===============7707260028109127184==--

