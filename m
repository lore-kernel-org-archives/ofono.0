Content-Type: multipart/mixed; boundary="===============0693422521332217753=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 5/6] handsfree-audio: Reject SCO if Card is not ready
Date: Mon, 04 Mar 2013 17:48:52 -0300
Message-ID: <1362430133-6870-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362430133-6870-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0693422521332217753==
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
index 14872b0..857c258 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -138,7 +138,7 @@ static gboolean sco_accept(GIOChannel *io, GIOCondition=
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


--===============0693422521332217753==--

