Content-Type: multipart/mixed; boundary="===============3783275510247040819=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 0/6] hfp_hf_bluez5: Add support for Transparent SCO
Date: Thu, 15 Aug 2013 23:26:03 -0300
Message-ID: <1376619969-15080-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3783275510247040819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the delay.

This series adds support for using transparent SCO, necessary for
wideband speech, the main feature is that it should do the right thing
even if the kernel doesn't have code for this.

The last two patches add some missing method implementations to the
Profile1 interface. One is more or less clear that there's nothing to
do, the other is less clear.

For .Cancel(): we only receive the .Cancel() message if the we will
not receive the NewConnection() call, so there's nothing to cancel for
the ofono side.

For .Release(): right now, this is doing nothing. Perhaps it would be
worth changing it to stop listening for SCO connections. Which would
mean to only start listening when the profile is registered. Does this
make sense?

Cheers,
Vinicius

Vinicius Costa Gomes (6):
  bluetooth: Add define for SCO voice settings
  handsfree-audio: Add setting SCO air mode
  handsfree-audio: Add support for detecting Transparent SCO support
  handsfree-audio: Set the voice setting for outgoing connections
  hfp_hf_bluez5: Handle org.bluez.Profile1.Cancel()
  hfp_hf_bluez5: Handle org.bluez.Profile1.Release()

 include/handsfree-audio.h |  2 +-
 plugins/hfp_hf_bluez5.c   | 10 +++-------
 src/bluetooth.h           |  9 +++++++++
 src/handsfree-audio.c     | 49 +++++++++++++++++++++++++++++++++++++++++--=
----
 4 files changed, 56 insertions(+), 14 deletions(-)

-- =

1.8.3.4


--===============3783275510247040819==--

