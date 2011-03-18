Content-Type: multipart/mixed; boundary="===============6159983563266242875=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 06/12] doc:Add AT commands for Network support
Date: Fri, 18 Mar 2011 13:30:52 +0100
Message-ID: <1300451458-6749-7-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300451458-6749-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6159983563266242875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index 2bec5e4..74b54ab 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -121,4 +121,12 @@ GPRS:
 	+CGCLASS	GPRS Mobile Station Class
 	+DR		Data Compression Reporting
 	+DS		Data Compression
-	=

\ No newline at end of file
+Network:
+--------
+	*CNTI		Network RAT capabilities
+	+COPS		PLMN selection
+	+CPOL		Preferred PLMN list
+	+CREG		Network registration
+	+CSQ		Signal quality
+	+CTZU		Automatic Time Zone Update
+	+CTZR		Time Zone Reporting
-- =

1.7.1


--===============6159983563266242875==--

