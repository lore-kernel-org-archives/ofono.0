Content-Type: multipart/mixed; boundary="===============1814458908834356906=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 1/6] service: Use MMS_META_UUID_SUFFIX
Date: Wed, 12 Sep 2012 15:55:08 +0200
Message-ID: <1347458113-29039-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1347458113-29039-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1814458908834356906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/service.c b/src/service.c
index b3ecc1e..ab88370 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1514,15 +1514,17 @@ static void load_messages(struct mms_service *servi=
ce)
 		return;

 	while ((file =3D g_dir_read_name(dir)) !=3D NULL) {
-		const size_t suffix_len =3D 7;
 		char *uuid;
+		size_t uuid_len;

-		if (g_str_has_suffix(file, ".status") =3D=3D FALSE)
+		if (g_str_has_suffix(file, MMS_META_UUID_SUFFIX) =3D=3D FALSE)
 			continue;
-		if (strlen(file) - suffix_len =3D=3D 0)
+
+		uuid_len =3D strlen(file) - MMS_META_UUID_SUFFIX_LEN;
+		if (uuid_len =3D=3D 0)
 			continue;

-		uuid =3D g_strndup(file, strlen(file) - suffix_len);
+		uuid =3D g_strndup(file, uuid_len);

 		process_message_on_start(service, uuid);

--
1.7.9.5


--===============1814458908834356906==--

