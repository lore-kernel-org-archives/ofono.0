Content-Type: multipart/mixed; boundary="===============2914879082637019835=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 04/11] __ofono_call_forwarding_is_busy internal api for
 STK-Send USSD
Date: Wed, 01 Sep 2010 04:00:29 -0700
Message-ID: <1283338836-13572-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2914879082637019835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 4e77144..b3ca6a1 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1092,6 +1092,11 @@ static void cf_unregister_ss_controls(struct ofono_c=
all_forwarding *cf)
 	__ofono_ussd_ssc_unregister(cf->ussd, "004");
 }
 =

+gboolean __ofono_call_forwarding_is_busy( struct ofono_call_forwarding *cf)
+{
+	return cf->pending ? TRUE: FALSE;
+}
+
 int ofono_call_forwarding_driver_register(const struct ofono_call_forwardi=
ng_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
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


--===============2914879082637019835==--

