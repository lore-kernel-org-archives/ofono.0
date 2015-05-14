Content-Type: multipart/mixed; boundary="===============1345655187047211034=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 0/3] Add method to force re-provisioning of contexts
Date: Thu, 14 May 2015 18:39:07 +0200
Message-ID: <1431621550-25131-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1345655187047211034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches implement a way to force re-provisioning of the
ConnectionManager contexts. Although the idea is similar to a previous =

approach which was posted to the list, it is quite different as it
wipes all existing contexts and then runs the provisioning code. The
implemented method checks different conditions to make the reset safe
for clients.

Alfonso Sanchez-Beato (3):
  gprs: Add DBus method to reset contexts
  doc: Add description for ResetContexts method
  test: Add script for resetting contexts

 doc/connman-api.txt |  10 ++++
 src/gprs.c          | 144 +++++++++++++++++++++++++++++++++++++++++++-----=
----
 test/reset-contexts |  20 ++++++++
 3 files changed, 150 insertions(+), 24 deletions(-)
 create mode 100644 test/reset-contexts

-- =

2.1.4


--===============1345655187047211034==--

