Content-Type: multipart/mixed; boundary="===============1286831068700599488=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stk: wait longer in DisplayText when confirmation requested.
Date: Tue, 23 Nov 2010 14:35:41 +0100
Message-ID: <1290519341-25378-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1286831068700599488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index ac2e646..88b162c 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1273,6 +1273,9 @@ static gboolean handle_command_display_text(const str=
uct stk_command *cmd,
 		return TRUE;
 	}
 =

+	if (qualifier & (1 << 7))
+		timeout =3D stk->timeout * 1000;
+
 	if (dt->duration.interval)
 		timeout =3D duration_to_msecs(&dt->duration);
 =

-- =

1.7.1.86.g0e460.dirty


--===============1286831068700599488==--

