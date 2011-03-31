Content-Type: multipart/mixed; boundary="===============5873798508384612118=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: isimodem: remove atoms that fail to probe
Date: Thu, 31 Mar 2011 11:28:52 +0300
Message-ID: <1301560133-13303-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5873798508384612118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here's a patch to immediately free any atoms that failed
to probe.

Br,

	MikaL

[PATCH 1/1] isimodem: remove atoms that fail to probe

 drivers/isimodem/audio-settings.c       |    4 +++-
 drivers/isimodem/call-barring.c         |    4 +++-
 drivers/isimodem/call-forwarding.c      |    4 +++-
 drivers/isimodem/call-settings.c        |    4 +++-
 drivers/isimodem/cbs.c                  |    5 ++++-
 drivers/isimodem/devinfo.c              |    4 +++-
 drivers/isimodem/gprs-context.c         |    6 ++++--
 drivers/isimodem/gprs.c                 |    1 +
 drivers/isimodem/network-registration.c |    7 +++----
 drivers/isimodem/phonebook.c            |    4 +++-
 drivers/isimodem/radio-settings.c       |    4 +++-
 drivers/isimodem/sim.c                  |    1 +
 drivers/isimodem/sms.c                  |    5 ++++-
 drivers/isimodem/ussd.c                 |    4 +++-
 drivers/isimodem/voicecall.c            |    4 +++-
 15 files changed, 44 insertions(+), 17 deletions(-)

--===============5873798508384612118==--

