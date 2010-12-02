Content-Type: multipart/mixed; boundary="===============4225342791281099413=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 3/3] doc: document frequency band selection
Date: Wed, 01 Dec 2010 23:55:59 -0200
Message-ID: <1291254959-5174-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1291254959-5174-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4225342791281099413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/radio-settings-api.txt |   43 ++++++++++++++++++++++++++++++++++++++++=
+++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
index e073d1d..216f534 100644
--- a/doc/radio-settings-api.txt
+++ b/doc/radio-settings-api.txt
@@ -46,6 +46,49 @@ Properties	string TechnologyPreference [readwrite]
 				"umts"	Only UMTS used for radio access.
 				"lte"	Only LTE used for radio acccess.
 =

+		string GsmBand [readwrite, optional]
+
+			Frequency band in which the modem is allowed to
+			operate when using "gsm" mode. Setting this property
+			has an imediate effect on modem only if
+			TechnologyPreference is set to "gsm".  Otherwise the
+			value is kept and applied whenever modem uses
+			this mode.
+
+			The possible values are:
+				"any"	Frequency band is selected
+					automatically by modem.
+				"850"	Operate only on 850 MHz.
+				"900P"	Operate only on 900 MHz, known as
+					Primary GSM-900 Band
+				"900E"	Operate only on 900 MHz, known as
+					Extended GSM-900 Band.
+				"1800"	Operate only on 1800 MHz, known as DCS.
+				"1900"	Operate only on 1900 MHz, known as PCS.
+
+		string UmtsBand [readwrite, optional]
+
+			Frequency band in which the modem is allowed to
+			operate when using "umts" mode. Setting this property
+			has an imediate effect on modem only if
+			TechnologyPreference is set to "umts".  Otherwise the
+			value is kept and applied whenever modem uses
+			this mode.
+
+			The possible values are:
+				"any"		Frequency band is selected
+						automatically by modem.
+				"850"		Operate only on 850 MHz, known
+						as CLR (class V).
+				"900"		Operate only on 900 MHz, known
+						as GSM (class VII).
+				"1700AWS"	Operate only on 1700 MHz, known
+						as AWS (class IV).
+				"1900"		Operate only on 1900 MHz, known
+						as PCS (class II).
+				"2100"		Operate only on 2100 MHz, known
+						as IMT (class I).
+
 		boolean	FastDormancy [readwrite, optional]
 =

 			This property will enable or disable the fast
-- =

1.7.3.2


--===============4225342791281099413==--

