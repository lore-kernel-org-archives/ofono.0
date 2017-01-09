Content-Type: multipart/mixed; boundary="===============0564138216010231028=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/2] Fix Read Imsi feature for MC7430 modem
Date: Mon, 09 Jan 2017 09:34:05 +0100
Message-ID: <20170109083407.3980-1-c.ronco@kerlink.fr>
In-Reply-To: <6924828f-c0e0-f079-868f-e4c45f029c2d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0564138216010231028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Done in 2 patches:
 - Backup read imsi modem driver funtion by IMSI via EF read (what is done
now when read_insi is not defined in modem driver)
 - Implement read_imsi in qmimodem sim driver

Christophe Ronco (2):
  sim: backup driver read_imsi by IMSI via EF read
  qmimodem: Add read_imsi to qmimodem sim driver

 drivers/qmimodem/sim.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++=
----
 src/sim.c              | 33 ++++++++++++--------
 2 files changed, 97 insertions(+), 19 deletions(-)

-- =

2.11.0


--===============0564138216010231028==--

