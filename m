Content-Type: multipart/mixed; boundary="===============5070603893984700725=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 4/6] doc: Add ReportChanged signal description
Date: Wed, 12 Sep 2012 15:55:11 +0200
Message-ID: <1347458113-29039-5-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1347458113-29039-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5070603893984700725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/message-api.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/message-api.txt b/doc/message-api.txt
index 2922e5d..033253c 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -31,6 +31,14 @@ Signals		PropertyChanged(string name, variant value)
 			The only expected property change is for the
 			message status.

+		ReportChanged(string type, variant status, dict details)
+
+			Signal that is sent when a report has been received and
+			processed. It contains the type of the report
+			("delivery_report" or other), the global status of the
+			report (delivered/partially_delivered/not_delivered) and
+			provide exact status details as a dictionary.
+
 Properties	string Status [readonly]

 			The status of the message.  Possible values are
--
1.7.9.5


--===============5070603893984700725==--

