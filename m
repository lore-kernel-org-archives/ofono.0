Content-Type: multipart/mixed; boundary="===============7175260629526922902=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] stemodem: fix possible memory leak
Date: Mon, 07 Feb 2011 15:02:52 -0800
Message-ID: <1297119772-17987-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7175260629526922902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/voicecall.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index ca275cd..dd5d009 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -491,6 +491,7 @@ static void ecav_notify(GAtResult *result, gpointer use=
r_data)
 =

 		vd->local_release &=3D ~(1 << existing_call->id);
 		vd->calls =3D g_slist_remove(vd->calls, l->data);
+		g_free(existing_call);
 		break;
 	}
 =

-- =

1.7.0.4


--===============7175260629526922902==--

