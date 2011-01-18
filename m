Content-Type: multipart/mixed; boundary="===============2369989021465004950=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] gatchat: Fix issue after removing deprecated functions
Date: Tue, 18 Jan 2011 19:11:52 +0100
Message-ID: <1295374312-14132-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2369989021465004950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatio.c b/gatchat/gatio.c
index 9cfc998..53896df 100644
--- a/gatchat/gatio.c
+++ b/gatchat/gatio.c
@@ -145,6 +145,7 @@ gsize g_at_io_write(GAtIO *io, const gchar *data, gsize=
 count)
 		return 0;
 	}
 =

+	g_io_channel_flush(io->channel, NULL);
 	g_at_util_debug_chat(FALSE, data, bytes_written,
 				io->debugf, io->debug_data);
 =

-- =

1.7.1


--===============2369989021465004950==--

