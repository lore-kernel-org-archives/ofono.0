Content-Type: multipart/mixed; boundary="===============8601319656025521426=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/4] Fix: Handle callsetup=0 when no waiting or dialing call
Date: Mon, 16 Nov 2009 22:10:54 +0800
Message-ID: <1258380654.5437.0.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8601319656025521426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When call=3D1 and callsetup=3D0, if no waiting or dialing call, the call
is active and no need to notify status change.
---
 drivers/hfpmodem/voicecall.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 52bec36..ba4b4d5 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -767,6 +767,11 @@ static void ciev_callsetup_notify(struct
ofono_voicecall *vc,
 			goto out;
 		}
 =

+		/* If call=3D1 and no call is waiting or dialing, the call
+		 * is active. */
+		if (waiting =3D=3D NULL && dialing =3D=3D NULL)
+			goto out;
+
 		 /*
 		 * If call=3D1, in the waiting case we have to poll, since we
 		 * have no idea whether a waiting call gave up or we accepted
-- =

1.6.2.5




--===============8601319656025521426==--

