Content-Type: multipart/mixed; boundary="===============2702775503900201156=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 7/7] TODO: mark task 'cancel pending SMS' as done
Date: Fri, 04 Feb 2011 13:02:44 -0200
Message-ID: <1296831764-6554-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296831764-6554-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2702775503900201156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/TODO b/TODO
index 13a6baa..8790209 100644
--- a/TODO
+++ b/TODO
@@ -31,15 +31,6 @@ SMS
   Priority: Low
   Complexity: C8
 =

-- See / Cancel pending SMS messages over DBus.  When oFono sends SMS messa=
ges
-  the method call is only returned when the message has been submitted to =
the
-  network.  Instead we should return an object path and allow cancellation=
 of
-  pending messages.
-
-  Priority: High
-  Complexity: C2
-  Owner: Yang Gu <yang.gu@intel.com>
-
 - Asynchronously acknowledge SMS DELIVER messages sent by the SMS driver
   to core using ofono_sms_deliver_notify().  This may require the struct
   ofono_sms_driver to be extended with one more function pointer like:
-- =

1.7.4


--===============2702775503900201156==--

