Content-Type: multipart/mixed; boundary="===============0304425489117101490=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCHV2 0/1] qmimodem: fix roaming status report
Date: Fri, 07 Sep 2018 16:29:56 +0200
Message-ID: <1536330597-16693-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <dfb296c5-1f15-b7d9-790b-9150b0864c0c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0304425489117101490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I didn't remember I did only part of the job back in december. Sorry for th=
at.
Here is a corrected version of the patch.
I saw once with a MC7430 a roaming information coming while not registered.
So patch is slightly modified to get roaming status information even if sta=
tus is not "registered".


Christophe Ronco (1):
  qmimodem: fix roaming status report

 drivers/qmimodem/network-registration.c | 47 ++++++++++++++++++++++++++++-=
----
 1 file changed, 40 insertions(+), 7 deletions(-)

-- =

2.7.4


--===============0304425489117101490==--

