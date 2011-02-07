Content-Type: multipart/mixed; boundary="===============6190217544385347543=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 16:01:33 -0600
Message-ID: <4D506BBD.8070101@gmail.com>
In-Reply-To: <1297079813-26573-1-git-send-email-andre.matos.ste@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6190217544385347543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On 02/07/2011 05:56 AM, Andre Matos wrote:
> From: Andre Carvalho de Matos <andre.carvalho.matos@stericsson.com>
> =

> transfer method should fail if you have a multiparty call, according to 2=
2.091
> section 8.11
> ---
>  src/voicecall.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

I pushed my own version of the fix upstream.  Thanks for catching this one.

Regards,
-Denis

--===============6190217544385347543==--

