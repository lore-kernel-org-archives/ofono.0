Content-Type: multipart/mixed; boundary="===============2515880637032906048=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isimodem-ussd PATCH 1/5] ussd.h: +CUSD is documented in 27.007
 section 7.15
Date: Thu, 16 Sep 2010 20:32:45 +0300
Message-ID: <1284658369-1988-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284658369-1988-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2515880637032906048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 include/ussd.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/ussd.h b/include/ussd.h
index 360ef00..82057f2 100644
--- a/include/ussd.h
+++ b/include/ussd.h
@@ -28,6 +28,7 @@ extern "C" {
 =

 #include <ofono/types.h>
 =

+/* 3GPP TS 27.007 section 7.15, values for <m> */
 enum ofono_ussd_status {
 	OFONO_USSD_STATUS_NOTIFY =3D 0,
 	OFONO_USSD_STATUS_ACTION_REQUIRED =3D 1,
-- =

1.7.0.4


--===============2515880637032906048==--

