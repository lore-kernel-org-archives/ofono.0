Content-Type: multipart/mixed; boundary="===============0691284193726027073=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 12/17] sms: document SMS Message's D-Bus 'To' property
Date: Thu, 05 Aug 2010 17:55:34 -0700
Message-ID: <e7c3a19fc4bdf3a1238b2a4e1a50ca1fea2f432c.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0691284193726027073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 doc/sms-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/sms-api.txt b/doc/sms-api.txt
index 2bf588f..70eb492 100644
--- a/doc/sms-api.txt
+++ b/doc/sms-api.txt
@@ -109,3 +109,8 @@ Properties	string State
 =

 			Current transmission state {queued, wsr, done,
 			canceling, cancelled, failed, expired}
+
+		string To
+
+			Destination number to which the message is
+			being sent.
-- =

1.6.6.1


--===============0691284193726027073==--

