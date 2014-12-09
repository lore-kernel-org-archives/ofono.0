Content-Type: multipart/mixed; boundary="===============4155787498302773586=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/4] doc: Add AvailableTechnologies property
Date: Tue, 09 Dec 2014 13:34:36 +0100
Message-ID: <1418128479-5491-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1418128479-5491-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4155787498302773586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This new property in org.ofono.RadioSettings interface will hold the
possible values for radio access technology for the modem.
---
 doc/radio-settings-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
index 9f9256f..03868a9 100644
--- a/doc/radio-settings-api.txt
+++ b/doc/radio-settings-api.txt
@@ -45,6 +45,11 @@ Properties	string TechnologyPreference [readwrite]
 				"umts"	Only UMTS used for radio access.
 				"lte"	Only LTE used for radio access.
 =

+		array{string} AvailableTechnologies [readonly, optional]
+
+			List of values for TechnologyPreference property
+			supported by the modem.
+
 		string GsmBand [readwrite, optional]
 =

 			Frequency band in which the modem is allowed to
-- =

2.1.0


--===============4155787498302773586==--

