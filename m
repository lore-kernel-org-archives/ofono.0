Content-Type: multipart/mixed; boundary="===============3061729984812255668=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 6/8] simutil: add ID of EFadn
Date: Tue, 12 Oct 2010 18:18:12 +0300
Message-ID: <1286896694-3054-7-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1286896694-3054-6-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3061729984812255668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index bd8e4ac..6496146 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -32,6 +32,7 @@ enum sim_fileid {
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
 	SIM_EFSDN_FILEID =3D 0x6f49,
+	SIM_EFADN_FILEID =3D 0x6f3a,
 	SIM_EFEST_FILEID =3D 0x6f56,
 	SIM_EFAD_FILEID =3D 0x6fad,
 	SIM_EFPHASE_FILEID =3D 0x6fae,
-- =

1.6.3.3



--===============3061729984812255668==--

