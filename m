Content-Type: multipart/mixed; boundary="===============6106150331404569203=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH v3 0/3] gemalto: Improve init process
Date: Thu, 13 Apr 2017 10:05:44 +0200
Message-ID: <1492070747-7252-1-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <7eef3738-fff5-2447-67c5-72958938f5ed@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6106150331404569203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Set of three patches improving Gemalto init. =

Denis' comments taken into account, I use sim_state_query to handle =

sim detection.

First patch cleans unused/untested interfaces.
Second patch fixes airplane mode.
Third patch improves sim detection with use of sim_state_query.

Changes in v3:
 - Replace URCs/callback mess with sim_state_query
 - Fix coding style

Vincent Cesson (3):
  gemalto: Clean post init functions
  gemalto: Change offline mode, keep USIM available
  gemalto: Use sim_state_query for sim detection

 plugins/gemalto.c | 125 ++++++++++++++++++++++++++++++++++++++------------=
----
 1 file changed, 89 insertions(+), 36 deletions(-)

-- =

1.9.1


--===============6106150331404569203==--

