Content-Type: multipart/mixed; boundary="===============4382663453868507685=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 4/6] cdma-connman: Add public api to notify connection is
 lost
Date: Wed, 02 Nov 2011 11:37:59 +0100
Message-ID: <1320230281-20743-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320230281-20743-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4382663453868507685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-connman.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/cdma-connman.h b/include/cdma-connman.h
index b8efe0b..7a115bf 100644
--- a/include/cdma-connman.h
+++ b/include/cdma-connman.h
@@ -64,6 +64,8 @@ int ofono_cdma_connman_driver_register(
 void ofono_cdma_connman_driver_unregister(
 				const struct ofono_cdma_connman_driver *d);
 =

+void ofono_cdma_connman_deactivated(struct ofono_cdma_connman *cm);
+
 struct ofono_cdma_connman *ofono_cdma_connman_create(
 						struct ofono_modem *modem,
 						unsigned int vendor,
-- =

1.7.1


--===============4382663453868507685==--

