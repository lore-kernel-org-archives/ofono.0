Content-Type: multipart/mixed; boundary="===============7918073259838111526=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [RFC at-export 0/2] Export AT-modem functions to other drivers
Date: Mon, 22 Apr 2019 09:44:39 +0200
Message-ID: <20190422074441.11854-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7918073259838111526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I'm writing a custom network-registration driver for uBlox modems and
I'd like to know if you will choke on the following approach:

i)  export method implementations from atmodem driver
ii) set up uBlox netreg vtable with custom probe method and exported
atmodem implementations for rest

If you can't accept this approach, please let me know of an alternative
method that would be preferable that (hopefully) doesn't entail just
copying all the code from one driver to the other (1000+ lines to keep
in sync going forward).

Best regards,
Jonas

PS:  This is an RFC... patches are not quite done.  That said, feel free
to patch review if you've got a moment; the final result shouldn't
differ all that much from what's here.

Jonas Bonn (2):
  atmodem: export generic netreg funcs
  ublox: network-registration atom

 drivers/atmodem/network-registration.c    |  16 +-
 drivers/atmodem/network-registration.h    |  17 +
 drivers/ubloxmodem/network-registration.c | 413 ++++++++++++++++++++++
 drivers/ubloxmodem/ubloxmodem.c           |   2 +
 drivers/ubloxmodem/ubloxmodem.h           |   3 +
 5 files changed, 444 insertions(+), 7 deletions(-)
 create mode 100644 drivers/atmodem/network-registration.h
 create mode 100644 drivers/ubloxmodem/network-registration.c

-- =

2.20.1


--===============7918073259838111526==--

