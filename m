Content-Type: multipart/mixed; boundary="===============1754253187562231348=="
MIME-Version: 1.0
From: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
Subject: [PATCH 1/4] doc: Add ModemAccessTechnology property
Date: Thu, 28 Oct 2010 01:14:51 -0700
Message-ID: <1288253694-25800-2-git-send-email-Rajesh.Nagaiah@elektrobit.com>
In-Reply-To: <1288253694-25800-1-git-send-email-Rajesh.Nagaiah@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1754253187562231348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/modem-api.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index c48375e..f5a3026 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -43,6 +43,15 @@ Properties	boolean Powered [readwrite]
 			modem. The Emergency is true if an emergency call or
 			related operation is currently active.
 =

+		string ModemAccessTechnology [readonly]
+
+			Contains current access techonology of the modem.
+			Possible values are:
+			"gsm" - the current modem access technology is GSM
+			"cdma" - the current modem access technology is CDMA
+
+			By default oFono uses "gsm" setting.
+
 		string Name [readonly, optional]
 =

 			Friendly name of the modem device.
-- =

1.7.0.4


--===============1754253187562231348==--

