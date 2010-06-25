Content-Type: multipart/mixed; boundary="===============5455647540592731747=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 08/23] export sms_assembly_encode_address
Date: Fri, 25 Jun 2010 16:15:30 -0700
Message-ID: <17909479c05535fa1100ecc9c0318ddab79cfc64.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5455647540592731747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

For generating unique message naming (for persistence and D-Bus object
naming), we'll be using the address. Instead of repeating the
functions, we reuse the same infrastructure used by the SMS assembly
code.
---
 src/smsutil.c |    4 ++--
 src/smsutil.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 78fabf5..cdf28f9 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2293,8 +2293,8 @@ static gboolean sms_assembly_extract_address(const ch=
ar *straddr,
 	return sms_decode_address_field(pdu, len, &offset, FALSE, out);
 }
 =

-static gboolean sms_assembly_encode_address(const struct sms_address *in,
-						char *straddr)
+gboolean sms_assembly_encode_address(const struct sms_address *in,
+				     char *straddr)
 {
 	unsigned char pdu[12];
 	int offset =3D 0;
diff --git a/src/smsutil.h b/src/smsutil.h
index 1c272bc..0d47385 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -505,6 +505,8 @@ GSList *sms_assembly_add_fragment(struct sms_assembly *=
assembly,
 					const struct sms_address *addr,
 					guint16 ref, guint8 max, guint8 seq);
 void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
+gboolean sms_assembly_encode_address(const struct sms_address *in,
+				     char *straddr);
 =

 struct status_report_assembly *status_report_assembly_new(const char *imsi=
);
 void status_report_assembly_free(struct status_report_assembly *assembly);
-- =

1.6.6.1


--===============5455647540592731747==--

