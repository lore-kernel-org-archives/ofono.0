Content-Type: multipart/mixed; boundary="===============7057932984461339998=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 08/11] STK:Send USSD internal apis
Date: Wed, 01 Sep 2010 04:00:33 -0700
Message-ID: <1283338836-13572-8-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7057932984461339998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index d95f2f2..43368d5 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -163,9 +163,18 @@ gboolean __ofono_modem_remove_atom_watch(struct ofono_=
modem *modem,
 void __ofono_atom_free(struct ofono_atom *atom);
 =

 #include <ofono/call-barring.h>
+
+gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
+
 #include <ofono/call-forwarding.h>
+
+gboolean __ofono_call_forwarding_is_busy(struct ofono_call_forwarding *cf);
+
 #include <ofono/call-meter.h>
 #include <ofono/call-settings.h>
+
+gboolean __ofono_call_settings_is_busy(struct ofono_call_settings *cs);
+
 #include <ofono/cbs.h>
 #include <ofono/devinfo.h>
 #include <ofono/phonebook.h>
@@ -235,6 +244,13 @@ gboolean __ofono_ssn_mt_watch_remove(struct ofono_ssn =
*ssn, int id);
 =

 #include <ofono/ussd.h>
 =

+enum ofono_ussd_failure{
+	OFONO_USSD_FAILURE_NONE =3D 0x0,
+	OFONO_USSD_FAILURE_USER_TERMINATED,
+	OFONO_USSD_FAILURE_RETURN_ERROR,
+	OFONO_USSD_FAILURE_TIMED_OUT,
+};
+
 typedef gboolean (*ofono_ussd_ssc_cb_t)(int type,
 					const char *sc,
 					const char *sia, const char *sib,
@@ -245,6 +261,10 @@ typedef gboolean (*ofono_ussd_passwd_cb_t)(const char =
*sc,
 					const char *old, const char *new,
 					DBusMessage *msg, void *data);
 =

+typedef void (*ofono_ussd_request_cb_t)(int error, int dcs,
+                                        const unsigned char *str,
+                                        int str_len, void *data);
+
 gboolean __ofono_ussd_ssc_register(struct ofono_ussd *ussd, const char *sc,
 					ofono_ussd_ssc_cb_t cb, void *data,
 					ofono_destroy_func destroy);
@@ -255,6 +275,12 @@ gboolean __ofono_ussd_passwd_register(struct ofono_uss=
d *ussd, const char *sc,
 					ofono_destroy_func destroy);
 void __ofono_ussd_passwd_unregister(struct ofono_ussd *ussd, const char *s=
c);
 =

+gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd);
+
+int __ofono_ussd_initiate(struct ofono_ussd *ussd, int dcs,
+                          const unsigned char *str, int str_len,
+                          ofono_ussd_request_cb_t cb, void *user_data);
+
 #include <ofono/netreg.h>
 =

 typedef void (*ofono_netreg_status_notify_cb_t)(int status, int lac, int c=
i,
-- =

1.7.0.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============7057932984461339998==--

