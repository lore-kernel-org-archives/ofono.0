Content-Type: multipart/mixed; boundary="===============3555531776392807954=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/2] Add Suspended property to GPRS
Date: Wed, 08 Sep 2010 12:16:59 +0300
Message-ID: <1283937421-19465-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3555531776392807954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

The following patches add the Suspended property to the
GPRS atom and implement it in the isimodem driver. The
property is opt-in for drivers that have the relevant
information. The value is read-only and defaults to false.

GPRS class B modems are not able to support simultaneous
GPRS data transfer with other services, such as voice call
or SMS. GPRS services may also be suspended if the network
does not support DTM, if the modem has poor network coverage,
or because of signalling procedures such as location or
routing area updates. While GPRS services are suspended,
the modem remains attached to the cellular network and all
PDP contexts remain established. Data transfer, however,
is not possible.

Some discussion:

The isimodem driver will currently suppress changes in the
property value for short-lived suspended states caused by SMS
transmission or other signalling. It would also be possible
to do the suppression in the oFono core in a generic way.
Alternatively, all the state changes and their reasons could
also be exposed to oFono clients. However, my feeling is
that the information might not be available in a sufficiently
coherent way from the different modems. Anyway, I'm open to
suggestions.

Br,

	MikaL


[PATCH 1/2] Add Suspended property to GPRS atom
[PATCH 2/2] isimodem: Implement Suspended property

 doc/connman-api.txt      |   19 ++++++++++++
 drivers/isimodem/debug.c |   25 +++++++++++++++
 drivers/isimodem/debug.h |    2 +
 drivers/isimodem/gpds.h  |   17 ++++++++++
 drivers/isimodem/gprs.c  |   74 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 include/gprs.h           |    1 +
 src/gprs.c               |   21 +++++++++++++
 7 files changed, 158 insertions(+), 1 deletions(-)

--===============3555531776392807954==--

