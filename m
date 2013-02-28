Content-Type: multipart/mixed; boundary="===============5821122490948788052=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 06/10] handsfree-audio: Reject SCO if Card is not ready
Date: Thu, 28 Feb 2013 15:52:48 -0300
Message-ID: <1362077572-28049-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5821122490948788052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Audio Card is being created when the NewConnection from BlueZ
Profile is received, and registered when the service level connection
negotiation finishes. This patch rejects SCO connection if the SCO
incoming connection arrives when the service level negotiation is
ongoing.
---
 src/handsfree-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 054c454..50aafc1 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -141,7 +141,7 @@ static gboolean sco_accept(GIOChannel *io, GIOCondition=
 cond,
 	bt_ba2str(&saddr.sco_bdaddr, local);
 =

 	card =3D card_find(remote, local);
-	if (card =3D=3D NULL) {
+	if (card =3D=3D NULL || card->path =3D=3D NULL) {
 		ofono_error("Rejecting SCO: Audio Card not found!");
 		close(nsk);
 		return TRUE;
-- =

1.7.11.7


--===============5821122490948788052==--

