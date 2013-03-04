Content-Type: multipart/mixed; boundary="===============9169447173342873464=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 6/6] handsfree-audio: Reject SCO if agent is unavailable
Date: Mon, 04 Mar 2013 17:48:53 -0300
Message-ID: <1362430133-6870-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362430133-6870-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9169447173342873464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch rejects the incoming SCO connection if there isn't a
Handsfree Audio Agent registered.
---
 src/handsfree-audio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 857c258..73c6183 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -123,6 +123,12 @@ static gboolean sco_accept(GIOChannel *io, GIOConditio=
n cond,
 	if (nsk < 0)
 		return TRUE;
 =

+	if (agent =3D=3D NULL) {
+		ofono_error("Reject SCO: Agent not registered");
+		close(nsk);
+		return TRUE;
+	}
+
 	bt_ba2str(&saddr.sco_bdaddr, remote);
 =

 	memset(&saddr, 0, sizeof(saddr));
-- =

1.7.11.7


--===============9169447173342873464==--

