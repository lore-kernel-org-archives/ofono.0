Content-Type: multipart/mixed; boundary="===============8493644817037457044=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 05/19] sms: document handle_sms_status_report()
Date: Tue, 03 Aug 2010 16:50:54 -0700
Message-ID: <7b2bbdc43c9f236371818587e8a9177973260da5.1280879410.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8493644817037457044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/sms.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 39d4a32..8d9a55e 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -859,6 +859,15 @@ static void handle_deliver(struct ofono_sms *sms, cons=
t struct sms *incoming)
 	g_slist_free(l);
 }
 =

+
+/*
+ * Handle a delivery/status report has been received for an SMS
+ * apparently sent from here.
+ *
+ * We need to find the message in the SMS manager's
+ * waiting-for-acknoledge queue (sms->tx_wfaq) and remove it. As well,
+ * fill out history for it.
+ */
 static void handle_sms_status_report(struct ofono_sms *sms,
 						const struct sms *incoming)
 {
-- =

1.6.6.1


--===============8493644817037457044==--

