Content-Type: multipart/mixed; boundary="===============6344116767626833541=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] Extended modem.conf
Date: Tue, 27 Oct 2009 20:20:05 +0900
Message-ID: <1256642405.5768.14.camel@localhost.localdomain>
In-Reply-To: <632f5f310910270242g5d1f594bse3a9085e542d27a@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6344116767626833541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> Allright. This is the one to consider. I used the checkpatch.pl, which
> informed me of my wayward ways.
> =

> I read from previous mails that the signed-off is not needed, is that
> still in effect?

yes, that is still true. We are not using Signed-off-by statements.

> ---
>  gatchat/gattty.c    |   16 +++++++-------
>  plugins/atgen.c     |   48 ++++++++++++++++++++++++++++++++++++++--
>  plugins/modemconf.c |   59 +++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 111 insertions(+), 12 deletions(-)

please split this into two patches. One that modifies gatchat/ and then
the rest in a second patch.

Regards

Marcel



--===============6344116767626833541==--

