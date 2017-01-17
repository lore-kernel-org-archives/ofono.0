Content-Type: multipart/mixed; boundary="===============4923171896238372223=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] use g_timeout_add instead of usleep
Date: Tue, 17 Jan 2017 11:29:03 +0100
Message-ID: <20170117102904.970-1-c.ronco@kerlink.fr>
In-Reply-To: <9c2461b9-0b37-9b8d-ce56-833f4fb2e1fc@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4923171896238372223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is another version of the patch using g_timeout_add.
Compare to what is done in at_util_sim_state_query, I choose to wait
only 20ms between attempts (2s in at_util_sim_state_query).
On my modem, I manage to recover from temporary error after 7 to 10
tries (less than 2 seconds).
Let me know if you prefer a bigger wait before retry.

Christophe Ronco (1):
  qmimodem: query_passwd_state can be retried

 drivers/qmimodem/sim.c | 95 ++++++++++++++++++++++++++++++++++++++++++----=
----
 1 file changed, 81 insertions(+), 14 deletions(-)

-- =

2.11.0


--===============4923171896238372223==--

