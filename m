Content-Type: multipart/mixed; boundary="===============7942810940451855911=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] simfs: Reset op_source in simfs_read_block.
Date: Sat, 29 Jan 2011 01:29:17 +0100
Message-ID: <1296260961-15155-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7942810940451855911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the block is not in cache or if this is the last block of a last
op in the queue, then fs->op_source might be left with the wrong
value.
---
 src/simfs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index b77e1dc..35045a1 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -269,6 +269,8 @@ static gboolean sim_fs_op_read_block(gpointer user_data)
 	int end_block;
 	unsigned short read_bytes;
 =

+	fs->op_source =3D 0;
+
 	start_block =3D op->offset / 256;
 	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
 =

-- =

1.7.1.86.g0e460.dirty


--===============7942810940451855911==--

