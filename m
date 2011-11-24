Content-Type: multipart/mixed; boundary="===============6393188521109717055=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/7] cdma-netreg: Add 'serving_system' entry point to
 cdma-netreg to get SID
Date: Thu, 24 Nov 2011 18:46:21 +0100
Message-ID: <1322156784-10402-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322156784-10402-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6393188521109717055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-netreg.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
index 31ed289..529dab5 100644
--- a/include/cdma-netreg.h
+++ b/include/cdma-netreg.h
@@ -36,12 +36,19 @@ enum cdma_netreg_status {
 =

 struct ofono_cdma_netreg;
 =

+typedef void (*ofono_cdma_netreg_serving_system_cb_t)(
+				const struct ofono_error *error,
+				const char *sid,
+				void *data);
+
 struct ofono_cdma_netreg_driver {
 	const char *name;
 	int (*probe)(struct ofono_cdma_netreg *cdma_netreg,
 				unsigned int vendor,
 				void *data);
 	void (*remove)(struct ofono_cdma_netreg *cdma_netreg);
+	void (*serving_system)(struct ofono_cdma_netreg *cdma_netreg,
+			ofono_cdma_netreg_serving_system_cb_t cb, void *data);
 };
 =

 void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *netreg,
-- =

1.7.1


--===============6393188521109717055==--

