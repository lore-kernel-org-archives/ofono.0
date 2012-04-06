Content-Type: multipart/mixed; boundary="===============4893512400490286008=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH v1 1/2] service: remove files when unable to decode received
 msg
Date: Fri, 06 Apr 2012 16:02:46 +0200
Message-ID: <1333720967-17878-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1333720967-17878-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4893512400490286008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index f148252..851db34 100644
--- a/src/service.c
+++ b/src/service.c
@@ -984,7 +984,12 @@ static gboolean load_message_from_store(const char *se=
rvice_id,
 	if (mms_message_decode(pdu, len, msg) =3D=3D FALSE) {
 		mms_error("Failed to decode %s", data_path);
 		munmap(pdu, len);
-		goto out;
+		g_free(state);
+
+		mms_store_meta_close(service_id, uuid, meta, FALSE);
+		mms_store_remove(service_id, uuid);
+
+		return FALSE;
 	}

 	munmap(pdu, len);
--
1.7.4.1


--===============4893512400490286008==--

