Content-Type: multipart/mixed; boundary="===============0443333429625594544=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 0/8] HFP HF: Service Level/Codec negotiation
Date: Thu, 17 Jan 2013 12:13:03 -0300
Message-ID: <1358435591-14757-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0443333429625594544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Second group of patches related to HFP external profile.

The following patches contain the HFP 1.6 codec negotiation.

Remaining HFP HF patches:
git://git.infradead.org/users/cktakahasi/ofono.git HF-20130117

Claudio Takahasi (3):
  hfp_hf: Add NewConnection arguments parsing
  hfp_hf: Register the HFP modem
  hfp_hf: Add service level negotiation

Vinicius Costa Gomes (5):
  hfpmodem: Add version defines for HFP 1.6
  hfpmodem: Add support for sending the supported codecs
  hfpmodem: Add support for storing the supported codecs
  hfpmodem: Send the AT+BAC command with the supported codecs
  hfp_hf: Add support for codec negotiation

 Makefile.am             |   3 +-
 drivers/hfpmodem/slc.c  |  54 ++++++-
 drivers/hfpmodem/slc.h  |  13 +-
 plugins/bluez5.c        |  81 ++++++++++
 plugins/bluez5.h        |   3 +
 plugins/hfp_hf_bluez4.c |   5 +-
 plugins/hfp_hf_bluez5.c | 408 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 plugins/media.c         |  63 ++++++++
 plugins/media.h         |  29 ++++
 plugins/phonesim.c      |  12 +-
 10 files changed, 658 insertions(+), 13 deletions(-)
 create mode 100644 plugins/media.c
 create mode 100644 plugins/media.h

-- =

1.7.11.7


--===============0443333429625594544==--

