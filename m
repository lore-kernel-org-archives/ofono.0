Content-Type: multipart/mixed; boundary="===============6628107405604213251=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 0/3] Provision the PPP authentication method from mbpi
Date: Tue, 24 Jun 2014 11:57:03 +0200
Message-ID: <1403603826-17021-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6628107405604213251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

My patch to the mobile-broadband-provider-info database DTD to add an
attribute indicating the authentication method to use was accepted by
the maintainers[1] and merged in their tree[2].

This set of patches adds support for the new attribute in the mbpi
plugin so new GPRS contexts can be correctly provisioned.  If the
authentication method is unspecified in the mbpi database we default
to CHAP (i.e.: previous behaviour).

[1] https://bugzilla.gnome.org/show_bug.cgi?id=3D731907
[2] https://git.gnome.org/browse/mobile-broadband-provider-info/commit/?id=
=3D752ccc5cdb34f427eefc26513a4c8e359883298f

Philip Paeps (3):
  include: add auth method to the provisioning API
  mbpi: add support for provisioning the auth method
  gprs: provision the authentication method

 include/gprs-provision.h |    1 +
 plugins/mbpi.c           |   35 +++++++++++++++++++++++++++++++++++
 src/gprs.c               |    2 ++
 3 files changed, 38 insertions(+)

-- =

1.7.10.4


--===============6628107405604213251==--

