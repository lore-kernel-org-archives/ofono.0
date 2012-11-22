Content-Type: multipart/mixed; boundary="===============5858675962283300339=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 00/11] External HFP Profile
Date: Thu, 22 Nov 2012 14:53:17 -0300
Message-ID: <1353606808-25032-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5858675962283300339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BlueZ supports now external profile registration, see:
bluez/doc/profile-api.txt

This patch series has the initial implementation of the HFP external
profile in oFono. HandsfreeAgent and HandsfreeGateway interfaces were
removed from BlueZ.

The next step: implement SCO connection handling in oFono.

Claudio Takahasi (11):
  hfp_hf: Add HFP external Profile registration
  hfp_hf: Add BlueZ Profile handler
  hfp_hf: Add parsing of Profile NewConnection call
  hfp_hf: Add SLC setup
  hfp_hf: Add Profile1 Release
  hfp_hf: Remove HandsfreeAgent and HandsfreeGateway
  hfp_hf: Register HFP modem dynamically
  hfp_hf: Fix updating alias
  bluetooth: Reuse D-Bus dictionary parser function
  hfp_hf: Add Version and Features parsing
  bluetooth: Use generic function to parse dict

 plugins/bluetooth.c | 245 ++++++++++++++++++++++---------
 plugins/bluetooth.h |  10 +-
 plugins/hfp_hf.c    | 404 +++++++++++++++++++++++++-----------------------=
----
 3 files changed, 379 insertions(+), 280 deletions(-)

-- =

1.7.11.7


--===============5858675962283300339==--

