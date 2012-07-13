Content-Type: multipart/mixed; boundary="===============1475010583691059281=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC_v2 1/3] gprs-context: Add new driver entry
Date: Fri, 13 Jul 2012 15:44:26 +0200
Message-ID: <1342187068-10418-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1342187068-10418-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1475010583691059281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index a5e7564..27d4b49 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -71,6 +71,8 @@ struct ofono_gprs_context_driver {
 	void (*deactivate_primary)(struct ofono_gprs_context *gc,
 					unsigned int id,
 					ofono_gprs_context_cb_t cb, void *data);
+	void (*detach_shutdown)(struct ofono_gprs_context *gc,
+					unsigned int id);
 };
 =

 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
-- =

1.7.5.4


--===============1475010583691059281==--

