Content-Type: multipart/mixed; boundary="===============2612625385275561777=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/13] doc: Update property name to match code.
Date: Wed, 13 Oct 2010 15:54:07 +0200
Message-ID: <1286978056-16600-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286978056-16600-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2612625385275561777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index f5b9ebc..e4993c1 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -55,10 +55,10 @@ Signals		PropertyChanged(string property, variant value)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

-Properties	string IdleText
+Properties	string IdleModeText
 =

 			Contains the text to be used when the home screen is
-			idle.  This text is set by the SIM and can be changed
+			idle.  This text is set by the SIM and can change
 			at any time.
 =

 		array{struct{string, byte}} MainMenu
-- =

1.7.1.86.g0e460.dirty


--===============2612625385275561777==--

