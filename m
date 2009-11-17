Content-Type: multipart/mixed; boundary="===============1886561431404928241=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 3/5] ofono_gprs_context_update_settings
Date: Tue, 17 Nov 2009 23:49:11 +0800
Message-ID: <1258472953-2922-3-git-send-email-martin.xu@intel.com>
In-Reply-To: <1258472953-2922-2-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1886561431404928241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    8 ++++++++
 src/gprs.c             |   26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index c4ebd23..8b860c2 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -71,6 +71,14 @@ void ofono_gprs_context_remove(struct ofono_gprs_context=
 *gc);
 void ofono_gprs_context_set_data(struct ofono_gprs_context *gc, void *data=
);
 void *ofono_gprs_context_get_data(struct ofono_gprs_context *gc);
 =

+void ofono_gprs_context_update_settings(struct ofono_gprs_context *gc,
+					const char *interface,
+					const char *method,
+					const char *address,
+					const char *netmask,
+					const char *dns,
+					const char *gateway);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gprs.c b/src/gprs.c
index a8d8afa..a64ff45 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1694,3 +1694,29 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs)
 	return gprs->driver_data;
 }
 =

+void ofono_gprs_context_update_settings(struct ofono_gprs_context *gc,
+					const char *interface,
+					const char *method,
+					const char *address,
+					const char *netmask,
+					const char *dns,
+					const char *gateway)
+{
+	g_free(gc->settings.interface);
+	gc->settings.interface =3D g_strdup(interface);
+
+	g_free(gc->settings.method);
+	gc->settings.method =3D g_strdup(method);
+
+	g_free(gc->settings.address);
+	gc->settings.address =3D g_strdup(address);
+
+	g_free(gc->settings.netmask);
+	gc->settings.netmask =3D g_strdup(netmask);
+
+	g_free(gc->settings.dns);
+	gc->settings.dns =3D g_strdup(dns);
+
+	g_free(gc->settings.gateway);
+	gc->settings.gateway =3D g_strdup(gateway);
+}
-- =

1.6.1.3


--===============1886561431404928241==--

