Content-Type: multipart/mixed; boundary="===============1726904217817633718=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 1/2] stkutil: convert img to xpm
Date: Thu, 22 Jul 2010 12:53:19 -0700
Message-ID: <20100722125319.73372158@kcaccard-MOBL3>
In-Reply-To: <4C486DF8.3090905@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1726904217817633718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jul 2010 11:12:40 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Also, XPM is pretty flexible here, there's no need to use 0-9 digits
> only.  For instance, you can do two look up tables, one for images with
> LUTs up to 64 entries and another for LUTs with more.  E.g.
> =

> A-Za-z0-9@$ and 'aa ab ac .. pp' or something like that.

I realize this - this was an implementation choice to keep the code
less complex, thinking that it would be better to favor that vs.
saving some bytes on the xpm.

--===============1726904217817633718==--

