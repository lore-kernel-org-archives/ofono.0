Content-Type: multipart/mixed; boundary="===============8561511038761691821=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/4] cdma-connman: add prototype to retrieve username and
 password
Date: Wed, 20 Jul 2011 11:26:37 +0200
Message-ID: <1311154000-32353-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1311154000-32353-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8561511038761691821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-connman.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/cdma-connman.h b/include/cdma-connman.h
index 22252e0..1439ea9 100644
--- a/include/cdma-connman.h
+++ b/include/cdma-connman.h
@@ -72,6 +72,10 @@ void ofono_cdma_connman_set_data(struct ofono_cdma_connm=
an *cm,
 						void *data);
 void *ofono_cdma_connman_get_data(struct ofono_cdma_connman *cm);
 =

+const char *ofono_cdma_connman_get_username(struct ofono_cdma_connman *cm);
+
+const char *ofono_cdma_connman_get_password(struct ofono_cdma_connman *cm);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============8561511038761691821==--

