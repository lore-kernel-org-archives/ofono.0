Content-Type: multipart/mixed; boundary="===============8189473606665559990=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 09/20] SMS: document handle_sms_status_report()
Date: Fri, 23 Jul 2010 13:59:57 -0700
Message-ID: <e4e5527b85b4b82ea6db7cd3cd9e1213f82004ee.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8189473606665559990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/sms.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 49f3e54..b53f880 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -887,6 +887,15 @@ static void handle_deliver(struct ofono_sms *sms, cons=
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


--===============8189473606665559990==--

