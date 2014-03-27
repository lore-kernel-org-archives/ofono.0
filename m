Content-Type: multipart/mixed; boundary="===============3026488394676166705=="
MIME-Version: 1.0
From: Eric BOUXIROT <eric.bouxirot@azimut-monitoring.com>
Subject: Re: problem sim status
Date: Thu, 27 Mar 2014 22:34:29 +0100
Message-ID: <lh25hi$f72$1@ger.gmane.org>
In-Reply-To: <53348A7A.3040805@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3026488394676166705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Ah, its one of those modems that doesn't have a sim ready notification.
>  In that case you probably need to run CPIN queries as part of the modem
> power-up procedure.  See examples in plugins/zte.c and plugins/speedup.c
> (cfun_enable & sim_state_cb)

yes ! that's work !
do you mean this patch can be integrated in one ofono release ?
for thoses interested, i will send my patch in next minutes. (let me =

make it clean)


--===============3026488394676166705==--

