Content-Type: multipart/mixed; boundary="===============3074207465817488248=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 05/12] Add internal api __ofono_call_barring_is_busy
Date: Thu, 09 Sep 2010 05:31:49 -0700
Message-ID: <1284035516-21359-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284035516-21359-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3074207465817488248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c |    5 +++++
 src/ofono.h        |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 7607f3f..a0ac689 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -580,6 +580,11 @@ static void cb_unregister_ss_controls(struct ofono_cal=
l_barring *cb)
 	__ofono_ussd_passwd_unregister(cb->ussd, "353");
 }
 =

+gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb)
+{
+	return cb->pending ? TRUE : FALSE;
+}
+
 static inline void cb_append_property(struct ofono_call_barring *cb,
 					DBusMessageIter *dict, int start,
 					int end, int cls, const char *property)
diff --git a/src/ofono.h b/src/ofono.h
index d95f2f2..41ba115 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -163,6 +163,9 @@ gboolean __ofono_modem_remove_atom_watch(struct ofono_m=
odem *modem,
 void __ofono_atom_free(struct ofono_atom *atom);
 =

 #include <ofono/call-barring.h>
+
+gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
+
 #include <ofono/call-forwarding.h>
 #include <ofono/call-meter.h>
 #include <ofono/call-settings.h>
-- =

1.7.0.4


--===============3074207465817488248==--

