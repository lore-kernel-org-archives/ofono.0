Content-Type: multipart/mixed; boundary="===============8816760078716912467=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/3] doc: add Lockdown property to Modem
Date: Wed, 22 Dec 2010 16:51:04 -0200
Message-ID: <1293043865-24968-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1293043865-24968-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8816760078716912467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/modem-api.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index b92e53c..45043b0 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -37,6 +37,15 @@ Properties	boolean Powered [readwrite]
 			Boolean representing the rf state of the modem.
 			Online is false in flight mode.
 =

+		boolean Lockdown [readwrite]
+
+			Boolean representing the lock state of the modem.
+			Setting it to true, makes the calling application hold
+			the modem lock and power it down. Setting to false
+			makes the it release the modem lock. Only the
+			application that holds the lock can power up the modem.
+			If the the application exits Lockdown is set to false.
+
 		boolean Emergency [readonly, optional, experimental]
 =

 			Boolean representing the emergency mode of the
-- =

1.7.3.4


--===============8816760078716912467==--

