Content-Type: multipart/mixed; boundary="===============7468582532744824564=="
MIME-Version: 1.0
From: Pargada, Carlos <carlos.pargada@intel.com>
Subject: [PATCH]] gatchat: improve large file Downlink data transfer
Date: Thu, 20 Jan 2011 11:53:50 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F47006AA7B7@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7468582532744824564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix large file Downlink data transfer on IFX modem.
  Increase buffer size of ring buffer to support close received Packets fro=
m the Modem
  Set highest priority for write data on tun device


---
 gatchat/gatio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatio.c b/gatchat/gatio.c
index 9cfc998..9d44a78 100644
--- a/gatchat/gatio.c
+++ b/gatchat/gatio.c
@@ -197,7 +197,7 @@ static GAtIO *create_io(GIOChannel *channel, GIOFlags f=
lags)
 		io->use_write_watch =3D FALSE;
 	}
 =

-	io->buf =3D ring_buffer_new(4096);
+	io->buf =3D ring_buffer_new(8192);
 =

 	if (!io->buf)
 		goto error;
@@ -288,7 +288,7 @@ gboolean g_at_io_set_write_handler(GAtIO *io, GAtIOWrit=
eFunc write_handler,
 =

 	if (io->use_write_watch =3D=3D TRUE)
 		io->write_watch =3D g_io_add_watch_full(io->channel,
-				G_PRIORITY_DEFAULT,
+				G_PRIORITY_HIGH,
 				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				can_write_data, io,
 				write_watcher_destroy_notify);
-- =

1.6.6.1
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============7468582532744824564==--

