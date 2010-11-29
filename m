Content-Type: multipart/mixed; boundary="===============0524188624034593832=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Mark ofono/*.h symbolink links as built sources
Date: Mon, 29 Nov 2010 10:18:15 +0100
Message-ID: <1291022295.4795.13.camel@aeonflux>
In-Reply-To: <1291021336-32666-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0524188624034593832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> This forces automake/make to build them first if needed (as before).
> But it avoids marking every single header as a dependency of every
> single object. Thus we do not need a bogus full rebuild of the tree
> everytime a header is added.

I had this before, but it caused problems with make distcheck. So you
have double checked that this still works?

Regards

Marcel



--===============0524188624034593832==--

