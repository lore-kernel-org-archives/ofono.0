Content-Type: multipart/mixed; boundary="===============0980434148941852495=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 04/12] service: Move mms_address_to_string() up
Date: Fri, 24 Aug 2012 15:06:03 +0200
Message-ID: <1345813571-15775-5-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345813571-15775-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0980434148941852495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/service.c b/src/service.c
index b073ca9..c3dc40a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -354,6 +354,19 @@ static gboolean mmap_file(const char *path, void **out=
_pdu, size_t *out_len)
 	return TRUE;
 }
 =

+static const char *mms_address_to_string(char *mms_address)
+{
+	unsigned int prefix_len;
+
+	if (g_str_has_suffix(mms_address, "/TYPE=3DPLMN") =3D=3D TRUE) {
+		prefix_len =3D strlen(mms_address) - 10;
+
+		mms_address[prefix_len] =3D '\0';
+	}
+
+	return (const char *) mms_address;
+}
+
 static gboolean send_message_get_recipients(DBusMessageIter *top_iter,
 						struct mms_message *msg)
 {
@@ -1702,19 +1715,6 @@ static void append_msg_attachments(DBusMessageIter *=
dict, const char *path,
 	}
 }
 =

-static const char *mms_address_to_string(char *mms_address)
-{
-	unsigned int prefix_len;
-
-	if (g_str_has_suffix(mms_address, "/TYPE=3DPLMN") =3D=3D TRUE) {
-		prefix_len =3D strlen(mms_address) - 10;
-
-		mms_address[prefix_len] =3D '\0';
-	}
-
-	return (const char *) mms_address;
-}
-
 static void append_msg_recipients(DBusMessageIter *dict,
 					struct mms_message *msg)
 {
-- =

1.7.9.5


--===============0980434148941852495==--

