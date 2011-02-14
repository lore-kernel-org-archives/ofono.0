Content-Type: multipart/mixed; boundary="===============8161238373061707943=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [V3 PATCH 3/3] Huawei: set Huawei EM770W modem device to 00
Date: Mon, 14 Feb 2011 14:28:25 -0600
Message-ID: <4D599069.3010501@gmail.com>
In-Reply-To: <1297503675-32491-3-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8161238373061707943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 02/12/2011 03:41 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> Device 00 is ppp port. Setting it as 01, my Huawei EM770W modem PPP
> connection can't work
> ---
>  plugins/ofono.rules |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =


This contradicts commit bb58a729073abcb6c5b0b2fb8b120973dfa42a07.

We really need a proper fix for this.

Regards,
-Denis

--===============8161238373061707943==--

