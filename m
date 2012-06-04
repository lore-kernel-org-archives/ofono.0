Content-Type: multipart/mixed; boundary="===============8963895774194333101=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 0/3] Prefer PAN over DUN
Date: Mon, 04 Jun 2012 16:11:29 +0200
Message-ID: <1338819092-28696-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8963895774194333101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

So here is the first oFono version for the "prefer pan over dun"
feature. Since this is a policy thing, it makes sense to place this
inside dundee and not inside ConnMan or BlueZ.

I am not really happy to pass in the UUIDs but I found it a lot nicer
than adding a 'filter' callback to struct bluetooth_profile. =


Another idea how to implement it I had was, adding a blacklist when
registering the profile.

Let's start with the simplest possible solution.

cheers,
daniel

Daniel Wagner (3):
  bluetooth: Add list of UUIDs to probe function
  bluetooth: Add PAN UUID
  dundee: Ignore DUN device if PAN is present

 dundee/bluetooth.c  |   11 ++++++++++-
 plugins/bluetooth.c |    8 +++++---
 plugins/bluetooth.h |    3 ++-
 plugins/hfp_hf.c    |    2 +-
 plugins/sap.c       |    2 +-
 5 files changed, 19 insertions(+), 7 deletions(-)

-- =

1.7.10.130.g36e6c


--===============8963895774194333101==--

