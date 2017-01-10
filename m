Content-Type: multipart/mixed; boundary="===============2877440305443888897=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/4] Add pin_send feature to qmimodem sim driver
Date: Tue, 10 Jan 2017 09:38:43 +0100
Message-ID: <20170110083847.28309-1-c.ronco@kerlink.fr>
In-Reply-To: <bbe2809f-f6c8-46c0-1be0-1e411172fa6d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2877440305443888897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previous patch broken down in 4 patches and aligned with current HEAD
I hope I have fixed the coding rules problems present in my first patch
version.

Christophe Ronco (4):
  qmimodem: get password state from modem
  qmimodem: add pin_send feature
  qmimodem: query_passwd_state can be retried
  udevng: Sierra modems use SIM driver

 drivers/qmimodem/sim.c | 287 +++++++++++++++++++++++++++++++++++++++------=
----
 drivers/qmimodem/uim.h |  11 ++
 plugins/udevng.c       |   2 -
 3 files changed, 239 insertions(+), 61 deletions(-)

-- =

2.11.0


--===============2877440305443888897==--

