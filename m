Content-Type: multipart/mixed; boundary="===============3644460215256726371=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 03/11] __ofono_call_barring_is_busy internal api for STK-Send
 USSD
Date: Wed, 01 Sep 2010 04:00:28 -0700
Message-ID: <1283338836-13572-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3644460215256726371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 7607f3f..b58499a 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -580,6 +580,11 @@ static void cb_unregister_ss_controls(struct ofono_cal=
l_barring *cb)
 	__ofono_ussd_passwd_unregister(cb->ussd, "353");
 }
 =

+gboolean __ofono_call_barring_is_busy( struct ofono_call_barring *cb)
+{
+	return cb->pending ? TRUE: FALSE;
+}
+
 static inline void cb_append_property(struct ofono_call_barring *cb,
 					DBusMessageIter *dict, int start,
 					int end, int cls, const char *property)
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


--===============3644460215256726371==--

