Content-Type: multipart/mixed; boundary="===============3181424084116622809=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v5 0/4]
Date: Wed, 12 May 2021 11:17:02 +0200
Message-ID: <615ae9a1-060f-4f61-4e7d-f6b4bc872863@norrbonn.se>
In-Reply-To: <20210512074053.6718-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3181424084116622809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

If we're going to get anywhere with this, the onus probably falls on you =

to do some cleanup work on these patches.  I'll write some comments on =

the patches and maybe you can munge those into the commit messages...?

Bing Jupiter has been running this modem (uBlox SARA R4) for well over a =

year with these patches so they are somewhat tested.  That said, this =

modem isn't without issues, but it appears to me that those are mostly =

firmware related at this point.  Yeah, not great advertising for the =

product; probably best to stay away from it altogether, really...

/Jonas

On 12/05/2021 09:40, Bing Jupiter wrote:
> Cleaned up comments and resubmit
> =

> Bing Jupiter (4):
>    Detect SARA R4 QMI device
>    Detect SARA R4 QMI device
>    Detect SARA R4 QMI device
>    Detect SARA R4 QMI device
> =

>   drivers/atmodem/vendor.h |  1 +
>   drivers/qmimodem/gprs.c  | 10 ++++++++++
>   plugins/gobi.c           | 11 ++++++++++-
>   plugins/udevng.c         | 42 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 63 insertions(+), 1 deletion(-)
>=20
--===============3181424084116622809==--

