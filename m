Content-Type: multipart/mixed; boundary="===============8549205407484547260=="
MIME-Version: 1.0
From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/6] Phonet: small pipe protocol fixes
Date: Fri, 25 Feb 2011 19:23:36 +0000
Message-ID: <20110225.112406.246526410.davem@davemloft.net>
In-Reply-To: <20110225.112055.260096987.davem@davemloft.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8549205407484547260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: David Miller <davem@davemloft.net>
Date: Fri, 25 Feb 2011 11:20:55 -0800 (PST)

> From: "R=C3=A9mi Denis-Courmont" <remi.denis-courmont@nokia.com>
> Date: Fri, 25 Feb 2011 11:13:41 +0200
> =

>> This patch series cleans up and fixes a number of small bits in the
>> Phonet pipe code, especially the experimental pipe controller. Once
>> this small bits are sorted out, I will try to fix the controller
>> protocol implementation proper so that we do not need the
>> compile-time (experimental) flag anymore.
> =

> All applied thanks.
> =

> If you want to start using GIT to push phonet changes to me, frankly I
> would welcome that :-)

BTW, I had to add the following patch to fix a build warning:

--------------------
phonet: Protect pipe_do_remove() with appropriate ifdefs.

It is only used when CONFIG_PHONET_PIPECTRLR is not set.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/phonet/pep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index b8c31fc..875e86c 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -849,6 +849,7 @@ drop:
 	return err;
 }
 =

+#ifndef CONFIG_PHONET_PIPECTRLR
 static int pipe_do_remove(struct sock *sk)
 {
 	struct pep_sock *pn =3D pep_sk(sk);
@@ -870,6 +871,7 @@ static int pipe_do_remove(struct sock *sk)
 =

 	return pn_skb_send(sk, skb, NULL);
 }
+#endif
 =

 /* associated socket ceases to exist */
 static void pep_sock_close(struct sock *sk, long timeout)
-- =

1.7.4.1


--===============8549205407484547260==--

