Content-Type: multipart/mixed; boundary="===============3745419648274100298=="
MIME-Version: 1.0
From: Krzysztof Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 1/5] doc: Extend Features property
Date: Mon, 17 Mar 2014 16:47:26 +0100
Message-ID: <1395071250-19440-2-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1395071250-19440-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3745419648274100298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Wilk <Krzysztofx.Wilk@intel.com>

---
 doc/handsfree-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
index d6ffca5..94e9a8f 100644
--- a/doc/handsfree-api.txt
+++ b/doc/handsfree-api.txt
@@ -45,6 +45,12 @@ Properties	array{string} Features [readonly]
 				"voice-recognition"
 				"attach-voice-tag"
 				"echo-canceling-and-noise-reduction"
+				"three-way-calling"
+				"release-all-held"
+				"release-specified-active-call"
+				"private-chat"
+				"create-multiparty"
+				"transfer"
 =

 		boolean InbandRinging [readonly]
 =

-- =

1.7.11.7

Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052


--===============3745419648274100298==--

