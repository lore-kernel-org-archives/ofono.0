Content-Type: multipart/mixed; boundary="===============8300550435699786665=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] Correction of previous patch
Date: Wed, 11 Jan 2017 11:06:47 +0100
Message-ID: <20170111100648.25936-1-c.ronco@kerlink.fr>
In-Reply-To: <43856c43-f49b-9bb7-4106-4f62d30b291c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8300550435699786665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Thanks again for code review. Here is another (I hope better) version
of the patch.
I changed gboolean for bool, because it is used more often than
gboolean in repository code.

Christophe

Christophe Ronco (1):
  qmimodem: get password state from modem

 drivers/qmimodem/sim.c | 178 +++++++++++++++++++++++++++++++++------------=
----
 1 file changed, 119 insertions(+), 59 deletions(-)

-- =

2.11.0


--===============8300550435699786665==--

