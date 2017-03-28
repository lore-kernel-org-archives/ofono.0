Content-Type: multipart/mixed; boundary="===============3559854795888615154=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/2] SIM PIN provisionning
Date: Tue, 28 Mar 2017 16:56:44 +0200
Message-ID: <20170328145646.27448-1-c.ronco@kerlink.fr>
In-Reply-To: <2e708940-19b2-cd1c-cf9e-a57de95e1dfd@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3559854795888615154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The idea is to be able to "automatically" enter SIM PIN.
Automatically means without end-user action on DBUS.

When Ofono (src/sim.c) discovers that a SIM needs a PIN code,
it will call all SIM password provision plugins registered to try
to get current SIM needed password. =

If it gets a password, it will try to enter it without waiting for
end-user to call EnterPin method. Of course, this is tried only once to
avoid blocking SIM cards.

I have also written a SIM password plugin based on a key-value file.

Christophe Ronco (2):
  provision: add SIM PIN provisionning
  provision: add SIM PIN provisionning plugin

 Makefile.am                    |   9 ++-
 include/sim-passwd-provision.h |  41 +++++++++++
 plugins/sim-file-provision.c   | 156 +++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h                    |   5 ++
 src/sim-password-provision.c   |  80 +++++++++++++++++++++
 src/sim.c                      |  35 +++++++++
 6 files changed, 324 insertions(+), 2 deletions(-)
 create mode 100644 include/sim-passwd-provision.h
 create mode 100644 plugins/sim-file-provision.c
 create mode 100644 src/sim-password-provision.c

-- =

2.11.0


--===============3559854795888615154==--

