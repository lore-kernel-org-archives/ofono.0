Content-Type: multipart/mixed; boundary="===============5944935050563895341=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stkutil: fix crash issue cause by null length of text
 string
Date: Fri, 10 Dec 2010 10:48:14 -0600
Message-ID: <4D0259CE.1000804@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D40188136D95B11@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5944935050563895341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/07/2010 04:58 AM, Lucas, GuillaumeX wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
> =

> According to 3GPP TS 31.124 a null length for the text string
> should be allowed. An empty string must be returned to the
> user in this case.
> ---
>  src/stkutil.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> =


Patch has been applied, but please re-run the unit tests when you change
stkutil.  You actually broke a few ;)

Regards,
-Denis

--===============5944935050563895341==--

