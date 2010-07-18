Content-Type: multipart/mixed; boundary="===============5097834731060711740=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: [PATCH 4/4] make bluetooth.{c,h} a static library
Date: Sun, 18 Jul 2010 20:05:22 -0300
Message-ID: <20100718230522.GB3406@vigoh>
In-Reply-To: <1279494072.4572.10.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5097834731060711740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2010-07-18 16:01:12 -0700]:

> Hi Gustavo,
> =

> >  Makefile.am         |    7 +++----
> >  plugins/bluetooth.c |    3 ---
> >  2 files changed, 3 insertions(+), 7 deletions(-)
> =

> why are we doing this exactly? If I missed it, please explain it again
> since I am not sure that I agree.

We are doing this for the DUN daemon. As you guys said to me it will be
separated daemon in oFono sources, so we need bluetooth.c as a static
library to reuse it in the DUN daemon.

-- =

Gustavo F. Padovan
http://padovan.org

--===============5097834731060711740==--

