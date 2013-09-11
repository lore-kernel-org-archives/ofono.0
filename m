Content-Type: multipart/mixed; boundary="===============4249747788209402856=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 5/7] handsfree-audio: Fix keeping the socket open without
 defer_setup
Date: Tue, 10 Sep 2013 21:09:44 -0300
Message-ID: <1378858186-683-5-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1378858186-683-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4249747788209402856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As we won't allow any card to be registered when the kernel doesn't
support defer_setup, we don't need to have the listening SCO socket
open in this case.
---
 src/handsfree-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 4d2c21f..a1d9714 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -214,9 +214,12 @@ static int sco_init(void)
 =

 	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
 				&defer_setup, sizeof(defer_setup)) < 0) {
+		int err =3D -errno;
 		defer_setup =3D 0;
 		ofono_warn("Can't enable deferred setup: %s (%d)",
 						strerror(errno), errno);
+		close(sk);
+		return err;
 	}
 =

 	memset(&voice, 0, sizeof(voice));
-- =

1.8.4


--===============4249747788209402856==--

