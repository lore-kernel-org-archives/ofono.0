Content-Type: multipart/mixed; boundary="===============2632004090288301174=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 14/16] gprs: Add gprs_get_status
Date: Wed, 11 Aug 2010 10:26:39 +0800
Message-ID: <1281493601-14351-15-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2632004090288301174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that DUN server could get latest GPRS status.
---
 include/gprs.h |    2 ++
 src/gprs.c     |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index c0a0e2f..ca23c45 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -76,6 +76,8 @@ unsigned int __ofono_gprs_add_status_watch(struct ofono_g=
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
index b91a099..b3fad91 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1995,6 +1995,14 @@ struct ofono_modem *ofono_gprs_context_get_modem(str=
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


--===============2632004090288301174==--

