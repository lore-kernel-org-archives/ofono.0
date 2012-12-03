Content-Type: multipart/mixed; boundary="===============2684076550358253997=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 00/14] External HFP Profile
Date: Mon, 03 Dec 2012 10:11:41 -0300
Message-ID: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353936429-9997-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2684076550358253997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BlueZ supports now external profile registration, see:
bluez/doc/profile-api.txt

This patch series has the initial implementation of the HFP external
profile in oFono. HandsfreeAgent and HandsfreeGateway interfaces were
removed from BlueZ.

Modem are being registered dinamically when the new connection is
notified instead of registering the modem when the Bluetooth device
is created/probed.

* Needs to be applied after "[PATCH v0 1/4] bluetooth: Fix reading
Bluetooth Adapters" series

Changes from RFC v1:
- Remove optional RequireAuthorization & RequireAuthentication to
  Register HFP profile.

Next actions:
 - Implement MediaTransport
 - MediaEndpoint set configuration

Development branch:
git://git.infradead.org/users/cktakahasi/ofono.git hfp


Claudio Takahasi (14):
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
  bluetooth: Fix memory leak of adapter_any_path
  hfp_hf: Handle connections before probe
  bluetooth: Fix memory leak of UUIDs list

 plugins/bluetooth.c | 268 +++++++++++++++++++++++--------
 plugins/bluetooth.h |  12 +-
 plugins/hfp_hf.c    | 451 +++++++++++++++++++++++++++---------------------=
----
 3 files changed, 446 insertions(+), 285 deletions(-)

-- =

1.7.11.7


--===============2684076550358253997==--

