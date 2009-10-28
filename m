Content-Type: multipart/mixed; boundary="===============2237021419201711557=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: [PATCH 2/3] Inline release_id in voicecall.c
Date: Wed, 28 Oct 2009 08:42:03 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089B924EED@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2237021419201711557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Inline release_id() in voicecall.c

---
 drivers/atmodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index f0c8d93..51b3a19 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -104,7 +104,7 @@ static unsigned int alloc_next_id(struct voicecall_data=
 *d)
 	return 0;
 }
 =

-static void release_id(struct voicecall_data *d, unsigned int id)
+static inline void release_id(struct voicecall_data *d, unsigned int id)
 {
 	d->id_list &=3D ~(0x1 << id);
 }
-- =

1.6.2.5


Regards,
Zhenhua
=20

--===============2237021419201711557==--

