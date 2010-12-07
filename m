Content-Type: multipart/mixed; boundary="===============2517965231902745856=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Mark ofono/*.h symbolink links as built sources
Date: Tue, 07 Dec 2010 11:13:25 +0100
Message-ID: <1291716805.4795.132.camel@aeonflux>
In-Reply-To: <1291650596-5554-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2517965231902745856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> This forces automake/make to build them first if needed (as before).
> But it avoids marking every single header as a dependency of every
> single object. Thus we do not need a bogus full rebuild of the tree
> everytime a header is added.
> ---
>  Makefile.am |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============2517965231902745856==--

