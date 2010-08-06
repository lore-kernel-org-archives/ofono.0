Content-Type: multipart/mixed; boundary="===============0708331284992530155=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 04/17] sms: document handle_sms_status_report()
Date: Thu, 05 Aug 2010 17:55:26 -0700
Message-ID: <a7ee0a16f4cd0740c5e7968daa157edc1662242f.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0708331284992530155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/sms.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index dce7d36..d0563d0 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -930,6 +930,15 @@ static void handle_deliver(struct ofono_sms *sms, cons=
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


--===============0708331284992530155==--

