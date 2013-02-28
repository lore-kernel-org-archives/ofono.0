Content-Type: multipart/mixed; boundary="===============7733367987682549722=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 07/10] handsfree-audio: Reject SCO if agent is unavailable
Date: Thu, 28 Feb 2013 15:52:49 -0300
Message-ID: <1362077572-28049-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7733367987682549722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch rejects the incoming SCO connection if there isn't a
Handsfree Audio Agent registered.
---
 src/handsfree-audio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 50aafc1..50bd861 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -126,6 +126,12 @@ static gboolean sco_accept(GIOChannel *io, GIOConditio=
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


--===============7733367987682549722==--

