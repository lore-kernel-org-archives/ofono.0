Content-Type: multipart/mixed; boundary="===============5461256102375090286=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 07/12] Add internal api __ofono_call_settings_is_busy
Date: Thu, 09 Sep 2010 05:31:51 -0700
Message-ID: <1284035516-21359-8-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284035516-21359-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5461256102375090286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-settings.c |    5 +++++
 src/ofono.h         |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index ab20062..9c536e9 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -778,6 +778,11 @@ static void cs_unregister_ss_controls(struct ofono_cal=
l_settings *cs)
 		__ofono_ussd_ssc_unregister(cs->ussd, "77");
 }
 =

+gboolean __ofono_call_settings_is_busy(struct ofono_call_settings *cs)
+{
+	return cs->pending ? TRUE : FALSE;
+}
+
 static DBusMessage *generate_get_properties_reply(struct ofono_call_settin=
gs *cs,
 							DBusMessage *msg)
 {
diff --git a/src/ofono.h b/src/ofono.h
index c3329a6..9b8d938 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -172,6 +172,9 @@ gboolean __ofono_call_forwarding_is_busy(struct ofono_c=
all_forwarding *cf);
 =

 #include <ofono/call-meter.h>
 #include <ofono/call-settings.h>
+
+gboolean __ofono_call_settings_is_busy(struct ofono_call_settings *cs);
+
 #include <ofono/cbs.h>
 #include <ofono/devinfo.h>
 #include <ofono/phonebook.h>
-- =

1.7.0.4


--===============5461256102375090286==--

