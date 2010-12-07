Content-Type: multipart/mixed; boundary="===============5042482478724468009=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] stkutil: fix crash issue cause by null length of text
 string
Date: Tue, 07 Dec 2010 21:25:07 +0100
Message-ID: <AANLkTikgaovsefEfAtzTpHURD9yDuLbzEVrRquPrU4F7@mail.gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D40188136D95B11@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5042482478724468009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 7 December 2010 11:58, Lucas, GuillaumeX <guillaumex.lucas@intel.com> =
wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
>
> According to 3GPP TS 31.124 a null length for the text string
> should be allowed. An empty string must be returned to the
> user in this case.

Can you give the circumstances in which the crash happens?  stk.c is
already checking for NULL texts and we shouldn't confuse the empty
data object and empty string.  Maybe another check is missing
somewhere in stk.c.

Best regards

--===============5042482478724468009==--

