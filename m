Content-Type: multipart/mixed; boundary="===============0971320140941000534=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 0/2] Build system patches
Date: Wed, 17 Oct 2018 15:52:23 +0200
Message-ID: <20181017135225.26573-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0971320140941000534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I posted these two patches half a year ago and was told that they
required review by Marcel.  Since Marcel made an appearance on the
mailing list today, I'll take the opportunity to resend these in the
hopes that they get the required review this time around.

/Jonas

Jonas Bonn (2):
  build: Install DBus policy in /usr/share/dbus-1/system.d
  configure.ac: simplify usage of PKG_CHECK_MODULES

 configure.ac | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

-- =

2.17.1


--===============0971320140941000534==--

