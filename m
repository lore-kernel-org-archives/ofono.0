Content-Type: multipart/mixed; boundary="===============0696781172214061975=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH] gprs: Fix for gprs context conversion
Date: Thu, 02 Dec 2010 09:19:00 +0200
Message-ID: <1291274340-28556-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0696781172214061975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 610f3b2..58166f8 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -175,7 +175,7 @@ static gboolean gprs_context_string_to_type(const char =
*str,
 		return TRUE;
 	} else if (g_str_equal(str, "ims")) {
 		*out =3D OFONO_GPRS_CONTEXT_TYPE_IMS;
-		return FALSE;
+		return TRUE;
 	}
 =

 	return FALSE;
-- =

1.7.1


--===============0696781172214061975==--

