Content-Type: multipart/mixed; boundary="===============3408175727278128092=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 05/12] doc:Add AT commands for GPRS
Date: Fri, 18 Mar 2011 13:30:51 +0100
Message-ID: <1300451458-6749-6-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300451458-6749-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3408175727278128092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index 735d626..2bec5e4 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -100,4 +100,25 @@ Call management:
 	+VTS		DTMF and tone generation
 	+CACM		Accumulated Call Meter
 	+COLP		Connected Line Identification Presentation
+GPRS:
+-----
+	+CGACT		PDP context activate or deactivate
+	+CGATT		PS attach or detach
+	+CGCMOD		PDP Context Modify
+	+CGDCONT	Define PDP Context
+	+CGEQREQ	3G Quality of Service Profile (Requested)
+	+CGEQMIN	3G Quality of Service Profile (Minimum acceptable)
+	+CGEQNEG	3G Quality of Service Profile (Negotiated) =

+	+CGQREQ		Quality of Service Profile (Requested)
+	+CGQMIN		Quality of Service Profile (Minimum Acceptable)
+	+CGREG		GPRS network registration status
+	+CGDSCONT	Define Secondary PDP Context
+	+CGDATA		Enter Data State
+	+CGTFT		Traffic Flow Template
+	+CGCMOD		PDP Context Modify
+	+CGCLASS	GPRS Mobile Station Class
+	+CGPADDR	Show PDP address
+	+CGCLASS	GPRS Mobile Station Class
+	+DR		Data Compression Reporting
+	+DS		Data Compression
 	=

\ No newline at end of file
-- =

1.7.1


--===============3408175727278128092==--

