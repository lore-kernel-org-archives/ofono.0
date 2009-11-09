Content-Type: multipart/mixed; boundary="===============8092146439065662033=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 3/4] add function ofono_gprs_context_get_modem
Date: Mon, 09 Nov 2009 15:38:00 +0800
Message-ID: <1257752281-22251-3-git-send-email-martin.xu@intel.com>
In-Reply-To: <1257752281-22251-2-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8092146439065662033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    2 ++
 src/gprs.c             |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index b8c770d..2a788ef 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -76,6 +76,8 @@ void ofono_gprs_context_remove(struct ofono_gprs_context =
*gc);
 void ofono_gprs_context_set_data(struct ofono_gprs_context *gc, void *data=
);
 void *ofono_gprs_context_get_data(struct ofono_gprs_context *gc);
 =

+struct ofono_modem *ofono_gprs_context_get_modem(struct ofono_gprs_context=
 *gc);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gprs.c b/src/gprs.c
index 60d26ec..025b944 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1249,6 +1249,11 @@ void *ofono_gprs_context_get_data(struct ofono_gprs_=
context *gc)
 	return gc->driver_data;
 }
 =

+struct ofono_modem *ofono_gprs_context_get_modem(struct ofono_gprs_context=
 *gc)
+{
+	return __ofono_atom_get_modem(gc->atom);
+}
+
 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.6.1.3


--===============8092146439065662033==--

