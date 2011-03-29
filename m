Content-Type: multipart/mixed; boundary="===============3370102111078369050=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/3] atom watch cleanup
Date: Tue, 29 Mar 2011 10:48:27 +0300
Message-ID: <1301384910-28272-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3370102111078369050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This patch set simplifies atom watch registration and removes
redundant code.

This approach also correctly handles the case when there are
multiple atoms of the same type (e.g. parallel probing of
alternate drivers or GPRS context drivers).

Br,

	MikaL

[PATCH 1/3] core: notify watches of already registered atoms
[PATCH 2/3] core: remove redundant code
[PATCH 3/3] atmodem: remove redundant code

 drivers/atmodem/sim-poll.c |   13 +------------
 src/call-barring.c         |    7 -------
 src/call-forwarding.c      |    7 -------
 src/call-settings.c        |    7 -------
 src/cbs.c                  |    7 -------
 src/gprs.c                 |    7 -------
 src/modem.c                |   16 +++++++++++++++-
 src/sms.c                  |   11 -----------
 src/voicecall.c            |    6 ------
 9 files changed, 16 insertions(+), 65 deletions(-)

--===============3370102111078369050==--

