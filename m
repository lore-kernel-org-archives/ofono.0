Content-Type: multipart/mixed; boundary="===============8544124956114022191=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH] modemconf: default to grabbing the "Device" entry from the
 config file
Date: Fri, 02 Oct 2009 19:36:20 -0400
Message-ID: <20091002193620.42404dad@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8544124956114022191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Previously, we manually listed every driver entry that needed Device;
this meant that we needed to edit modemconf.c every time we added
a new modem plugin.  Sjoerd Simons discovered that mbm doesn't work
because it wasn't listed in modemconf, therefore Device was being
ignored.  This patch makes modemconf default to setting Device, with
exceptions made for certain plugin drivers.

A better way to fix this that I started working on would be to have
each driver plugin have a table of desired/required strings, and to
keep any knowledge of drivers out of udev.c and modemconf.c.  This
may be a bit of a challenge for udev.c, though.  Is this something
that people would like to see?

Signed-off-by: Andres Salomon <dilinger@collabora.co.uk>
---
 plugins/modemconf.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index 4795749..dce31e2 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -98,9 +98,7 @@ static struct ofono_modem *create_modem(GKeyFile *keyfile=
, const char *group)
 =

 	if (!g_strcmp0(driver, "phonesim"))
 		set_address(modem, keyfile, group);
-
-	if (!g_strcmp0(driver, "atgen") || !g_strcmp0(driver, "g1") ||
-						!g_strcmp0(driver, "calypso"))
+	else
 		set_device(modem, keyfile, group);
 =

 	g_free(driver);
-- =

1.6.4.3




--===============8544124956114022191==--

