Content-Type: multipart/mixed; boundary="===============6166826912117425217=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: nokia-modem (N900) not detected after migration to udevng
Date: Thu, 07 Sep 2017 17:51:37 -0700
Message-ID: <20170908005137.GB3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6166826912117425217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I've been debugging why the n900 modem is not recognized by ofono
for a few days now, and have determined that the cause is because the
calls in udevng to udev_device_get_devnode return NULL. It seems that
the nokia-modem driver does not create any device nodes under /dev.

This seems to be a regression in functionality since the move to
udevng as previous versions of ofono seem to detect the n900 modem
correctly (right before this commit 3ac449e25fc8cb9880c48b8f309189c6a644f20=
0)
This issue occurs from this commit onwards, including the latest commit
as of this mail.

https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/udevng.=
c#n1316

-Clayton


--===============6166826912117425217==--

