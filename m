Content-Type: multipart/mixed; boundary="===============0036889128790481795=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC sim-ready-v1 PATCH 0/3] ofono_sim_ready_notify
Date: Tue, 19 Oct 2010 12:56:45 +0300
Message-ID: <AANLkTin1JQ_uKQP9mFXW03tiQQihCk_EJnA5RbTP-aw9@mail.gmail.com>
In-Reply-To: <1287481415.3316.138.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0036889128790481795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/10/19 Marcel Holtmann <marcel@holtmann.org>:
> so how do we handle AT command based modems that have no extra
> indication of SIM ready state? Are we stuck with quirks in the atmodem
> SIM driver or can we push these into the modem plugins?

I forgot to mention that in 0 patch, but I added a dummy delay as the
default way to handle the problem in atmodem sim driver:

>>By default the driver don't trust the modem to do the right thing and
>>adds a delay of 1000 milliseconds after entering the PIN/PUK.  It is
>>possible to remove the delay by adding a suitable quirk in
>>at_wait_for_ready().

I wonder if the delay is long enough. Someone complained in
bugs.meego.com that Nokia Test Network SIM cards are so slow they
don't work with the oFono in Meego 1.1 (0.26 with n900 plugin
patches), but they probably are not the slowest SIMs that you can
find.

-- =

Pekka.Pessi mail at nokia.com

--===============0036889128790481795==--

