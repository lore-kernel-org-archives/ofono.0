Content-Type: multipart/mixed; boundary="===============0892039955786879036=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 10/12] doc: Add AT commands for SIM
Date: Fri, 18 Mar 2011 13:30:56 +0100
Message-ID: <1300451458-6749-11-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300451458-6749-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0892039955786879036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index 647d269..97ff009 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -184,4 +184,16 @@ Device:
 	+GMR		Request Revision Identification
 	+CGSN		Request product serial number identification
 	+CKPD		Keypad control
-
+SIM	=

+----
+	+CPBR		Read phonebook entries
+	+CPBS		Select phonebook memory storage
+	+CPBW		Write phonebook entry
+	+CPBF		Find Phonebook Entries
+	+CPIN		Enter PIN
+	+CRSM		Restricted SIM access
+	+CSIM		Generic SIM access
+	+CASIM		SIM Slot
+	+CRES		Restore Settings (SMS)
+	+CSAS		Save Settings  (SMS)
+	+CCID		Request SIM Card Identification
-- =

1.7.1


--===============0892039955786879036==--

