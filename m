Content-Type: multipart/mixed; boundary="===============2255897369829413162=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [V3 PATCH 3/3] Huawei: set Huawei EM770W modem device to 00
Date: Tue, 15 Feb 2011 15:03:13 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD369E4E97@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4D599069.3010501@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2255897369829413162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis/Marcel:
> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Tuesday, February 15, 2011 4:28 AM
> To: ofono(a)ofono.org
> Cc: Xu, Martin
> Subject: Re: [V3 PATCH 3/3] Huawei: set Huawei EM770W modem device to 00
> =

> Hi Martin,
> =

> On 02/12/2011 03:41 AM, martin.xu(a)intel.com wrote:
> > From: Martin Xu <martin.xu@intel.com>
> >
> > Device 00 is ppp port. Setting it as 01, my Huawei EM770W modem PPP
> > connection can't work
> > ---
> >  plugins/ofono.rules |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> =

> This contradicts commit bb58a729073abcb6c5b0b2fb8b120973dfa42a07.
I can't quite understand why Dietrich needs to this commit. We formal confi=
gure can just make EM770W works.
Could you help on this?

--===============2255897369829413162==--

