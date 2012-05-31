Content-Type: multipart/mixed; boundary="===============6846182428130240856=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC 1/3] gprs-context: Add new driver entry
Date: Thu, 31 May 2012 11:59:06 +0200
Message-ID: <1338458348-335-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1338458348-335-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6846182428130240856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 6cae9a2..165792f 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -71,6 +71,8 @@ struct ofono_gprs_context_driver {
 	void (*deactivate_primary)(struct ofono_gprs_context *gc,
 					unsigned int id,
 					ofono_gprs_context_cb_t cb, void *data);
+	void (*release_primary)(struct ofono_gprs_context *gc,
+					unsigned int id);
 };
 =

 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
-- =

1.7.5.4


--===============6846182428130240856==--

