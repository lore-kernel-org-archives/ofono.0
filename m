Content-Type: multipart/mixed; boundary="===============8791552490647755450=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/2] Add provisioning plugin from configuration file
Date: Fri, 17 Feb 2017 15:44:46 +0100
Message-ID: <20170217144448.23940-1-c.ronco@kerlink.fr>
In-Reply-To: <37f5cc31-9dc8-a46d-9595-1c42d7658bd7@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8791552490647755450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The goal of this plugin is to provision APN and other internet context deta=
ils
from a configuration file.

The modification from what I sent yesterday:
 - do not use storage functions anymore
 - changed section names to be able to add other type of sections in the fu=
ture

Christophe Ronco (2):
  provision: add plugin to provision from config file
  plugins: support for provisioning from config file

 Makefile.am              |   4 ++
 plugins/file-provision.c | 170 +++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 174 insertions(+)
 create mode 100644 plugins/file-provision.c

-- =

2.11.0


--===============8791552490647755450==--

