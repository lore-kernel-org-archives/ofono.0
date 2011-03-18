Content-Type: multipart/mixed; boundary="===============3100005024990183258=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 08/12] doc: Add AT commands for SMS
Date: Fri, 18 Mar 2011 13:30:54 +0100
Message-ID: <1300451458-6749-9-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300451458-6749-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3100005024990183258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index a0599df..6480577 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -138,3 +138,32 @@ Supplementary Services:
 	+CLIR		Calling line identification restriction
 	+CSSN		Supplementary Service Notifications
 	+CUSD		Unstructured supplementary service data
+SMS:
+----
+	+CMTI		A GSM/GPRS modem or mobile phone uses +CMTI to notify =

+			the computer / PC that a new SMS message has been =

+			received and the memory location where it is stored.
+	+CMT		A GSM/GPRS modem or mobile phone uses +CMT to forward
+			a newly received SMS message to the computer / PC.
+	+CGSMS		Select service for MO SMS messages
+	+CMGF		Message Format
+	+CMGS		Send Message
+	+CSCA		Service Centre Address
+	+CESP		Enter SMS Block Mode Protocol
+	+CMGC		Send Command
+	+CMGD		Delete Message
+	+CMGL		List Messages
+	+CMGR		Read Message
+	+CMGW		Write Message to Memory
+	+CMMS		More Messages to Send
+	+CMSS		Send Message from Storage
+	+CNMA		New Message Acknowledgement to ME/TA
+	+CNMI		New Message Indications to TE
+	+CPMS		Preferred Message Storage
+	+CSCS	 	Select TE Character Set
+	+CSCB		Select Cell Broadcast Message Types
+	+CSDH		Show Text Mode Parameters
+	+CSMP		Set Text Mode Parameters
+	+CSMS		Select Message Service
+	+CRES		Restore Settings (SMS)
+	+CSAS		Save Settings  (SMS)
-- =

1.7.1


--===============3100005024990183258==--

