Content-Type: multipart/mixed; boundary="===============6332123349762979923=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 4/5] add function ofono_gprs_context_get_modem
Date: Tue, 17 Nov 2009 23:49:12 +0800
Message-ID: <1258472953-2922-4-git-send-email-martin.xu@intel.com>
In-Reply-To: <1258472953-2922-3-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6332123349762979923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    2 ++
 src/gprs.c             |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 8b860c2..95b2bae 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -79,6 +79,8 @@ void ofono_gprs_context_update_settings(struct ofono_gprs=
_context *gc,
 					const char *dns,
 					const char *gateway);
 =

+struct ofono_modem *ofono_gprs_context_get_modem(struct ofono_gprs_context=
 *gc);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gprs.c b/src/gprs.c
index a64ff45..7d37389 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1720,3 +1720,8 @@ void ofono_gprs_context_update_settings(struct ofono_=
gprs_context *gc,
 	g_free(gc->settings.gateway);
 	gc->settings.gateway =3D g_strdup(gateway);
 }
+
+ struct ofono_modem *ofono_gprs_context_get_modem(struct ofono_gprs_contex=
t *gc)
+{
+	return __ofono_atom_get_modem(gc->atom);
+}
-- =

1.6.1.3


--===============6332123349762979923==--

