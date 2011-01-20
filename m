Content-Type: multipart/mixed; boundary="===============3799650337108999345=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 3/3] Huawei: set Huawei EM770W modem device to 00
Date: Thu, 20 Jan 2011 16:22:53 -0200
Message-ID: <AANLkTikJJcoD0mVaAn0h=78iRUOMm5merLp-2ZDFswU-@mail.gmail.com>
In-Reply-To: <1295502354-19270-3-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3799650337108999345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin

On Thu, Jan 20, 2011 at 3:45 AM,  <martin.xu@intel.com> wrote:
> From: Martin Xu <martin.xu@intel.com>
>
> Device 00 is ppp port. Setting it as 01, my Huawei EM770W modem PPP
> connection can't work
> ---
> =C2=A0plugins/ofono.rules | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)

We have to decide what to do here. Look at this commit:

commit bb58a729073abcb6c5b0b2fb8b120973dfa42a07
Author: M. Dietrich <mdt@emdete.de>
Date:   Fri Dec 10 19:25:17 2010 +0100

    huawei: set huawei em770 modem device to 01

    device 00 is ppp capable while 01 is not. 01 does everything
    else fine so ofono works with it flawlessly.



regards,
Lucas De Marchi

--===============3799650337108999345==--

