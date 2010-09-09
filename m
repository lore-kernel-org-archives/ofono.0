Content-Type: multipart/mixed; boundary="===============2905342889938832055=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 06/12] Add internal api __ofono_call_forwarding_is_busy
Date: Thu, 09 Sep 2010 05:31:50 -0700
Message-ID: <1284035516-21359-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284035516-21359-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2905342889938832055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    5 +++++
 src/ofono.h           |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 4e77144..3e9265b 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1092,6 +1092,11 @@ static void cf_unregister_ss_controls(struct ofono_c=
all_forwarding *cf)
 	__ofono_ussd_ssc_unregister(cf->ussd, "004");
 }
 =

+gboolean __ofono_call_forwarding_is_busy(struct ofono_call_forwarding *cf)
+{
+	return cf->pending ? TRUE : FALSE;
+}
+
 int ofono_call_forwarding_driver_register(const struct ofono_call_forwardi=
ng_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
diff --git a/src/ofono.h b/src/ofono.h
index 41ba115..c3329a6 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -167,6 +167,9 @@ void __ofono_atom_free(struct ofono_atom *atom);
 gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
 =

 #include <ofono/call-forwarding.h>
+
+gboolean __ofono_call_forwarding_is_busy(struct ofono_call_forwarding *cf);
+
 #include <ofono/call-meter.h>
 #include <ofono/call-settings.h>
 #include <ofono/cbs.h>
-- =

1.7.0.4


--===============2905342889938832055==--

