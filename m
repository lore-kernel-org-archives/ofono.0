Content-Type: multipart/mixed; boundary="===============8075126975795601248=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/3] voicecall: Force callheld update after calls swap
Date: Tue, 20 Mar 2012 19:27:52 -0500
Message-ID: <4F692088.4070308@gmail.com>
In-Reply-To: <1331740853-3994-3-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8075126975795601248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/14/2012 11:00 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> In HFP spec, a callheld indicator update should be sent after swapping
> calls, even if it stays to 1 (AG has both active and held calls).
> ---
>  src/voicecall.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 files changed, 74 insertions(+), 4 deletions(-)
> =


Patch has been applied, just had to fix a minor whitespace violation.

Regards,
-Denis

--===============8075126975795601248==--

