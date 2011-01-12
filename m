Content-Type: multipart/mixed; boundary="===============3517821870172696254=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 19/21] gprs: Add gprs_get_status
Date: Wed, 12 Jan 2011 18:16:02 +0100
Message-ID: <1294852564-1258-20-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3517821870172696254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

DUN server want to get latest GPRS status.
---
 include/gprs.h |    2 ++
 src/gprs.c     |    9 +++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

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
index 895d95b..4ef33ef 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2487,6 +2487,15 @@ void ofono_gprs_context_set_type(struct ofono_gprs_c=
ontext *gc,
 	gc->type =3D type;
 }
 =

+
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

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============3517821870172696254==--

