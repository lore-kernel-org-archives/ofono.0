Content-Type: multipart/mixed; boundary="===============1205779689078294932=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: [PATCH] stk: Add null pointer check
Date: Fri, 25 Feb 2011 12:39:19 +0200
Message-ID: <1298630359-4774-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1205779689078294932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes a crash when SIM Session End is received while waiting for user respo=
nse to SELECT ITEM command.
---
 src/stk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index bc46b2f..cda378f 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -115,6 +115,9 @@ static int stk_respond(struct ofono_stk *stk, struct st=
k_response *rsp,
 	if (stk->driver->terminal_response =3D=3D NULL)
 		return -ENOSYS;
 =

+	if (stk->pending_cmd =3D=3D NULL)
+		return -EINVAL;
+
 	rsp->src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL;
 	rsp->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
 	rsp->number =3D stk->pending_cmd->number;
-- =

1.7.0.4


--===============1205779689078294932==--

