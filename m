Content-Type: multipart/mixed; boundary="===============4019833099036258040=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 11/11] gprs: Add API to set a 'detach'notification callback
Date: Mon, 04 Jul 2011 18:06:42 +0200
Message-ID: <1309795602-26046-12-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309795602-26046-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4019833099036258040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c  |   28 ++++++++++++++++++++++++++++
 src/ofono.h |    5 +++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index f6090ba..a8b8e7d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -155,6 +155,7 @@ struct gprs_private_context {
 	union {
 		__ofono_gprs_private_context_activate_cb_t act;
 		__ofono_gprs_private_context_deactivate_cb_t deact;
+		__ofono_gprs_private_context_detached_cb_t detach;
 	};
 	void *cb_data;
 };
@@ -1502,6 +1503,10 @@ static void gprs_attached_update(struct ofono_gprs *=
gprs)
 =

 		if (stk_context) {
 			gprs_private_context_release(stk_context);
+
+			if (stk_context->detach)
+				stk_context->detach(stk_context->cb_data);
+
 			g_free(stk_context);
 			stk_context =3D NULL;
 		}
@@ -2210,6 +2215,10 @@ static void gprs_context_unregister(struct ofono_ato=
m *atom)
 =

 	if (stk_context && stk_context->context_driver =3D=3D gc) {
 		gprs_private_context_release(stk_context);
+
+		if (stk_context->detach)
+			stk_context->detach(stk_context->cb_data);
+
 		g_free(stk_context);
 		stk_context =3D NULL;
 	}
@@ -2287,6 +2296,10 @@ void ofono_gprs_context_deactivated(struct ofono_gpr=
s_context *gc,
 =

 	if (stk_context && stk_context->context_driver =3D=3D gc) {
 		gprs_private_context_release(stk_context);
+
+		if (stk_context->detach)
+			stk_context->detach(stk_context->cb_data);
+
 		g_free(stk_context);
 		stk_context =3D NULL;
 	}
@@ -3240,3 +3253,18 @@ int __ofono_gprs_private_context_deactivate(struct o=
fono_gprs *gprs,
 				deactivate_request_callback, stk_context);
 	return 0;
 }
+
+int __ofono_gprs_private_context_set_detached_notify(struct ofono_gprs *gp=
rs,
+				__ofono_gprs_private_context_detached_cb_t cb,
+				void *data)
+{
+	if (stk_context =3D=3D NULL)
+		return -ENOENT;
+
+	if (stk_context->context_driver->gprs !=3D gprs)
+		return -EINVAL;
+
+	stk_context->detach =3D cb;
+	stk_context->cb_data =3D data;
+	return 0;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 274912d..9ea16c5 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -248,6 +248,7 @@ typedef void (*__ofono_gprs_private_context_activate_cb=
_t)(int error,
 						const char *interface,
 						const char *ip,
 						void *data);
+typedef void (*__ofono_gprs_private_context_detached_cb_t)(void *data);
 =

 int __ofono_gprs_private_context_deactivate(struct ofono_gprs *gprs,
 				__ofono_gprs_private_context_deactivate_cb_t cb,
@@ -258,6 +259,10 @@ int __ofono_gprs_private_context_activate(struct ofono=
_gprs *gprs,
 				__ofono_gprs_private_context_activate_cb_t cb,
 				void *data);
 =

+int __ofono_gprs_private_context_set_detached_notify(struct ofono_gprs *gp=
rs,
+				__ofono_gprs_private_context_detached_cb_t cb,
+				void *data);
+
 #include <ofono/radio-settings.h>
 #include <ofono/audio-settings.h>
 #include <ofono/ctm.h>
-- =

1.7.1


--===============4019833099036258040==--

