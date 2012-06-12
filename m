Content-Type: multipart/mixed; boundary="===============2541379246215297739=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 1/6] mmsutil: Add delivery report to send_req struct
Date: Tue, 12 Jun 2012 16:04:10 +0200
Message-ID: <1339509855-7467-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1339509855-7467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2541379246215297739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/mmsutil.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/mmsutil.h b/src/mmsutil.h
index 79c74db..6c7b37f 100644
--- a/src/mmsutil.h
+++ b/src/mmsutil.h
@@ -105,6 +105,7 @@ struct mms_send_req {
 	char *to;
 	time_t date;
 	char *content_type;
+	gboolean dr;
 };
 =

 struct mms_send_conf {
-- =

1.7.4.1


--===============2541379246215297739==--

