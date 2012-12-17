Content-Type: multipart/mixed; boundary="===============1587898022594701113=="
MIME-Version: 1.0
From: Mingli Wu <mingli@southpole.se>
Subject: [PATCH 0/3] Telit HE910
Date: Mon, 17 Dec 2012 17:22:15 +0100
Message-ID: <1355761338-9081-1-git-send-email-mingli@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1587898022594701113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

I've been working on the Telit HE910 modem too, as I see from
the mailing list that you have been.

Allow me to send a coule of patches that I have in progress and
that are needed for things to work.  Could you take a look at
these and possibily incorporate them into ofono in a way that's
acceptable to upstream?

The first patch in the series is similar to what you sent to
the mailing list today but sets more options... I can't recall
if setting only baud rate was insufficient, right now, so I'll
just send the entire patch.

Thanks,
Mingli Wu

Mingli Wu (3):
  Support Telit cdc acm device
  Drop checking whether +CMER is supported.
  Delay 10 seconds between CFUN=3D4 and CFUN=3D1

 drivers/atmodem/network-registration.c |    2 -
 include/modem.h                        |    3 +
 plugins/telit.c                        |  101 ++++++++++++++++++++++++++++=
+++-
 plugins/udevng.c                       |   30 +++++++++-
 src/modem.c                            |   11 ++++
 5 files changed, 143 insertions(+), 4 deletions(-)

-- =

1.7.9.5


--===============1587898022594701113==--

