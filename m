Content-Type: multipart/mixed; boundary="===============5057821761278193398=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 05/11] __ofono_call_settings_is_busy internal api for STK-Send
 USSD
Date: Wed, 01 Sep 2010 04:00:30 -0700
Message-ID: <1283338836-13572-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5057821761278193398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-settings.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index ab20062..e8c7248 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -778,6 +778,11 @@ static void cs_unregister_ss_controls(struct ofono_cal=
l_settings *cs)
 		__ofono_ussd_ssc_unregister(cs->ussd, "77");
 }
 =

+gboolean __ofono_call_settings_is_busy( struct ofono_call_settings *cs)
+{
+	return cs->pending ? TRUE: FALSE;
+}
+
 static DBusMessage *generate_get_properties_reply(struct ofono_call_settin=
gs *cs,
 							DBusMessage *msg)
 {
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


--===============5057821761278193398==--

