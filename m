Content-Type: multipart/mixed; boundary="===============2807487050963865202=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 0/4] Add Serial and Type property to dundee
Date: Tue, 05 Jun 2012 15:48:15 +0200
Message-ID: <1338904099-13612-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2807487050963865202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

The first patch is fixes an obvious typo in the introspection.

The next three patches punch a whole through the DUN device
abstraction. If a Bluetooth device supports PAN and DUN at the same
time, there is no real good reason to offer both services to
user. ConnMan needs to figure out if a device supports both profile
(and then picking PAN). For this we need to provide an device
identifier. This API estension is modeled after the modem API, where
we have to do the same thing for HFP.

cheers,
daniel

Daniel Wagner (4):
  dundee: Fix signal name
  dundee: Add Serial and Type documantation
  dundee: Add Serial property
  dundee: Add Type property

 doc/dundee-api.txt |   12 ++++++++++++
 dundee/bluetooth.c |   11 +++++++++++
 dundee/device.c    |   27 +++++++++++++++++++++++++++
 dundee/dundee.h    |    9 +++++++++
 dundee/manager.c   |    2 +-
 5 files changed, 60 insertions(+), 1 deletion(-)

-- =

1.7.10.130.g36e6c


--===============2807487050963865202==--

