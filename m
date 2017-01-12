Content-Type: multipart/mixed; boundary="===============7484622545081438240=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] Patch #3 resubmitted
Date: Thu, 12 Jan 2017 15:09:17 +0100
Message-ID: <20170112140918.28845-1-c.ronco@kerlink.fr>
In-Reply-To: <04b5ad4f-b699-139f-ebb0-5a7365113eba@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7484622545081438240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I changed again gboolean for bool.

Christophe Ronco (1):
  qmimodem: query_passwd_state can be retried

 drivers/qmimodem/sim.c | 74 ++++++++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 60 insertions(+), 14 deletions(-)

-- =

2.11.0


--===============7484622545081438240==--

