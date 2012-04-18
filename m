Content-Type: multipart/mixed; boundary="===============6237620871939322281=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv3 01/10] service: remove files when unable to decode received
 msg
Date: Wed, 18 Apr 2012 15:27:39 +0200
Message-ID: <1334755668-27458-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1334755668-27458-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6237620871939322281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove files when message is not decodable.
---
 src/service.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index f148252..7f2a302 100644
--- a/src/service.c
+++ b/src/service.c
@@ -961,6 +961,7 @@ static gboolean load_message_from_store(const char *ser=
vice_id,
 	gboolean read_status;
 	char *data_path =3D NULL;
 	gboolean success =3D FALSE;
+	gboolean tainted =3D FALSE;
 	void *pdu;
 	size_t len;

@@ -984,6 +985,7 @@ static gboolean load_message_from_store(const char *ser=
vice_id,
 	if (mms_message_decode(pdu, len, msg) =3D=3D FALSE) {
 		mms_error("Failed to decode %s", data_path);
 		munmap(pdu, len);
+		tainted =3D TRUE;
 		goto out;
 	}

@@ -1019,6 +1021,9 @@ out:

 	mms_store_meta_close(service_id, uuid, meta, FALSE);

+	if (tainted =3D=3D TRUE)
+		mms_store_remove(service_id, uuid);
+
 	return success;
 }

--
1.7.4.1


--===============6237620871939322281==--

