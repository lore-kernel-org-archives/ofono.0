Content-Type: multipart/mixed; boundary="===============9019745773113002906=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/4] bugfixes + revectored isimodem GPRS context driver
Date: Wed, 10 Nov 2010 14:22:27 +0200
Message-ID: <1289391751-2844-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9019745773113002906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

The first two patches are bugfixes. The rest adapts the isimodem
GPRS context driver to the current multiple PDP context support
in oFono core.

Br,

	MikaL


[PATCH 1/4] gisi: fix crash bug in g_isi_remove_subscription
[PATCH 2/4] gisi: return NULL instead of asserting
[PATCH 3/4] isimodem: revector GPRS context driver
[PATCH 4/4] isigen: make number of PDP contexts configurable

 drivers/isimodem/gprs-context.c |  280 +++++++++++++++++------------------=
----
 gisi/client.c                   |    7 +-
 gisi/pep.c                      |    6 +-
 plugins/isigen.c                |   23 +++-
 plugins/udev.c                  |    6 +-
 5 files changed, 152 insertions(+), 170 deletions(-)

--===============9019745773113002906==--

