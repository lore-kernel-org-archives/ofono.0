Content-Type: multipart/mixed; boundary="===============8823085956955204121=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 3/3] doc: fix a kill-yank error
Date: Fri, 21 Jan 2011 14:44:06 +0200
Message-ID: <1295613846-19309-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1295613846-19309-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8823085956955204121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/smartmessaging-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/smartmessaging-api.txt b/doc/smartmessaging-api.txt
index 36065b4..637a5ef 100644
--- a/doc/smartmessaging-api.txt
+++ b/doc/smartmessaging-api.txt
@@ -50,7 +50,7 @@ Methods		void ReceiveAppointment(array{byte} appointment,=
 dict info)
 		void ReceiveBusinessCard(array{byte} card, dict info)
 =

 			Requests the agent to process a new SMS that has
-			arrived containing a vCalendar object.  The info
+			arrived containing a vCard object.  The info
 			dictionary contains 'Sender', 'LocalSentTime' and
 			'SentTime' properties.
 =

-- =

1.7.1


--===============8823085956955204121==--

