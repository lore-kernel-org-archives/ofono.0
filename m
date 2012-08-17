Content-Type: multipart/mixed; boundary="===============8270865679001608539=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 12/12] doc: Add ReportChanged signal description
Date: Fri, 17 Aug 2012 16:35:13 +0200
Message-ID: <1345214113-25597-13-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345214113-25597-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8270865679001608539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/message-api.txt |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/message-api.txt b/doc/message-api.txt
index 2922e5d..274bb98 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -31,6 +31,13 @@ Signals		PropertyChanged(string name, variant value)
 			The only expected property change is for the
 			message status.
 =

+		ReportChanged(string type, variant recipient, variant status)
+
+			Signal that is sent when a report has been received and
+			processed. It contains the type of the report
+			("delivery_report" or other), the recipient concerned
+			and its new status.
+
 Properties	string Status [readonly]
 =

 			The status of the message.  Possible values are
-- =

1.7.9.5


--===============8270865679001608539==--

