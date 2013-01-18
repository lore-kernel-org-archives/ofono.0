Content-Type: multipart/mixed; boundary="===============4164236191763793697=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 00/10] HFP HF: Service Level/Codec negotiation
Date: Fri, 18 Jan 2013 20:21:46 -0300
Message-ID: <1358551316-27305-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358435591-14757-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4164236191763793697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Second group of patches related to HFP external profile.

The following patches contain the HFP 1.6 codec negotiation.

Changed between v0-v1:
* deleted media.[ch], functions moved to bluez5.[ch]
* replaced 'bluetooth_' prefix by 'bt_' for BlueZ 5 functions
* splitted HFP SLC patches
* new oFono D-Bus utility function to parse dictionaries

Claudio Takahasi (2):
  hfp_hf: Register the HFP modem
  hfp_hf: Add service level negotiation

Vinicius Costa Gomes (8):
  dbus: Add ofono_dbus_iter_parse_properties()
  bluez5: Rename register/unregister profile
  hfp_hf: Add NewConnection arguments parsing
  hfpmodem: Add support for storing the supported codecs
  hfpmodem: Implement hfp_slc_info_free
  phonesim: Use hfp_slc_info_free()
  hfpmodem: Send the AT+BAC command with the supported codecs
  hfp_hf: Add support for codec negotiation

 drivers/hfpmodem/slc.c  |  29 +++-
 drivers/hfpmodem/slc.h  |  10 +-
 include/dbus.h          |   6 +
 plugins/bluez5.c        |  39 ++++-
 plugins/bluez5.h        |  12 +-
 plugins/hfp_hf_bluez4.c |   2 +-
 plugins/hfp_hf_bluez5.c | 417 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 plugins/phonesim.c      |  12 +-
 src/dbus.c              |  90 +++++++++++
 9 files changed, 598 insertions(+), 19 deletions(-)

-- =

1.7.11.7


--===============4164236191763793697==--

