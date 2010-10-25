Content-Type: multipart/mixed; boundary="===============8758273311776244875=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/4] simutil: add Efbdn fileid to sim_fileid enum
Date: Mon, 25 Oct 2010 04:34:14 -0700
Message-ID: <1288006457-5415-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1288006457-5415-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8758273311776244875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index 50ad418..5b56099 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -32,6 +32,7 @@ enum sim_fileid {
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
 	SIM_EFSDN_FILEID =3D 0x6f49,
+	SIM_EFBDN_FILEID =3D 0x6f4d,
 	SIM_EFADN_FILEID =3D 0x6f3a,
 	SIM_EFEST_FILEID =3D 0x6f56,
 	SIM_EFAD_FILEID =3D 0x6fad,
-- =

1.7.0.4


--===============8758273311776244875==--

