Content-Type: multipart/mixed; boundary="===============0586833517908569516=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [emergency PATCH 2/2] doc/modem: add experimental Emergency property
Date: Thu, 02 Sep 2010 18:38:59 +0300
Message-ID: <1283441939-19098-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283441939-19098-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0586833517908569516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/modem-api.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index d7c2caf..c48375e 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -37,6 +37,12 @@ Properties	boolean Powered [readwrite]
 			Boolean representing the rf state of the modem.
 			Online is false in flight mode.
 =

+		boolean Emergency [readonly, optional, experimental]
+
+			Boolean representing the emergency mode of the
+			modem. The Emergency is true if an emergency call or
+			related operation is currently active.
+
 		string Name [readonly, optional]
 =

 			Friendly name of the modem device.
-- =

1.7.0.4


--===============0586833517908569516==--

