Content-Type: multipart/mixed; boundary="===============0940799398736642924=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 2/2] main: add capabilities for phonet
Date: Mon, 01 Nov 2010 17:53:02 +0200
Message-ID: <1288626782-16009-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288626782-16009-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0940799398736642924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Phonet sockets require CAP_SYS_ADMIN and SO_BINDTODEVICE socket
option requires CAP_NET_RAW.
---
 src/main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/main.c b/src/main.c
index 93149bc..eca008e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -140,7 +140,8 @@ int main(int argc, char **argv)
 	/* Drop capabilities */
 	capng_clear(CAPNG_SELECT_BOTH);
 	capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
-				CAP_NET_BIND_SERVICE, CAP_NET_ADMIN, -1);
+				CAP_NET_BIND_SERVICE, CAP_NET_ADMIN,
+				CAP_NET_RAW, CAP_SYS_ADMIN, -1);
 	capng_apply(CAPNG_SELECT_BOTH);
 #endif
 =

-- =

1.7.0.4


--===============0940799398736642924==--

