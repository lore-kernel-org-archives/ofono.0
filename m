Content-Type: multipart/mixed; boundary="===============2840112639003888190=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 19/21] gprs: Add gprs_get_status
Date: Wed, 29 Sep 2010 17:44:59 +0800
Message-ID: <1285753501-7668-20-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2840112639003888190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN server want to get latest GPRS status.
---
 include/gprs.h |    2 ++
 src/gprs.c     |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index 7985115..05cc086 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -86,6 +86,8 @@ unsigned int __ofono_gprs_add_status_watch(struct ofono_g=
prs *gprs,
 gboolean __ofono_gprs_remove_status_watch(struct ofono_gprs *gprs,
 						unsigned int id);
 =

+int ofono_gprs_get_status(struct ofono_gprs *gprs);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gprs.c b/src/gprs.c
index 1285a4b..e7fc768 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2063,6 +2063,14 @@ struct ofono_modem *ofono_gprs_context_get_modem(str=
uct ofono_gprs_context *gc)
 	return __ofono_atom_get_modem(gc->atom);
 }
 =

+int ofono_gprs_get_status(struct ofono_gprs *gprs)
+{
+	if (gprs =3D=3D NULL)
+		return -1;
+
+	return gprs->status;
+}
+
 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.7.0.4


--===============2840112639003888190==--

