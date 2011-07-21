Content-Type: multipart/mixed; boundary="===============3423376654047855244=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 1/4] cdma-connman: pass username and password to drivers
 while activating cdma-connman
Date: Thu, 21 Jul 2011 06:40:41 +0200
Message-ID: <1311223244-26904-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1311223244-26904-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3423376654047855244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-connman.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/cdma-connman.h b/include/cdma-connman.h
index 22252e0..6a1c9ff 100644
--- a/include/cdma-connman.h
+++ b/include/cdma-connman.h
@@ -30,6 +30,9 @@ extern "C" {
 =

 struct ofono_cdma_connman;
 =

+#define OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH 63
+#define OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH 255
+
 typedef void (*ofono_cdma_connman_cb_t)(const struct ofono_error *error,
 						void *data);
 typedef void (*ofono_cdma_connman_up_cb_t)(const struct ofono_error *error,
@@ -47,6 +50,8 @@ struct ofono_cdma_connman_driver {
 						void *data);
 	void (*remove)(struct ofono_cdma_connman *cm);
 	void (*activate)(struct ofono_cdma_connman *cm,
+						const char *username,
+						const char *password,
 						ofono_cdma_connman_up_cb_t cb,
 						void *data);
 	void (*deactivate)(struct ofono_cdma_connman *cm,
-- =

1.7.1


--===============3423376654047855244==--

