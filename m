Content-Type: multipart/mixed; boundary="===============2642580763549913452=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 2/5] cdma-connman: Add bearer notification public function
 declaration
Date: Fri, 02 Dec 2011 15:00:51 +0100
Message-ID: <1322834454-451-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1322834454-451-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2642580763549913452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-connman.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/cdma-connman.h b/include/cdma-connman.h
index 7a115bf..ae84d40 100644
--- a/include/cdma-connman.h
+++ b/include/cdma-connman.h
@@ -59,6 +59,9 @@ struct ofono_cdma_connman_driver {
 						void *data);
 };
 =

+void ofono_cdma_connman_bearer_notify(struct ofono_cdma_connman *cm,
+					int bearer);
+
 int ofono_cdma_connman_driver_register(
 				const struct ofono_cdma_connman_driver *d);
 void ofono_cdma_connman_driver_unregister(
-- =

1.7.1


--===============2642580763549913452==--

