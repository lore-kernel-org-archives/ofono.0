Content-Type: multipart/mixed; boundary="===============4925026254025157721=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH] include/gprs-context.h: declare struct ofono_modem
Date: Tue, 05 Sep 2017 16:20:30 +0200
Message-ID: <20170905142030.27790-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4925026254025157721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a warning.
./include/gprs-context.h:99:61: error: =E2=80=98struct ofono_modem=E2=80=99=
 declared
inside parameter list will not be visible outside of this definition
or declaration...
---
 include/gprs-context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 5f54aa6a6b94..38e5c09d9316 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -29,6 +29,7 @@ extern "C" {
 #include <ofono/types.h>
 =

 struct ofono_gprs_context;
+struct ofono_modem;
 =

 /*
  * ETSI 123.003, Section 9.1:
-- =

2.14.1


--===============4925026254025157721==--

