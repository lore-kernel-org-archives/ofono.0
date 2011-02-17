Content-Type: multipart/mixed; boundary="===============3111413218493037875=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Fix reference handling in hfp_ag
Date: Thu, 17 Feb 2011 10:08:25 -0600
Message-ID: <4D5D47F9.5060205@gmail.com>
In-Reply-To: <1297958126-9156-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3111413218493037875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 02/17/2011 09:55 AM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> Hi, these patch fixes reference handling in hfp_ag.
> =

> First patch makes sure that GATServer properly disconnects client
> when modem is put offline. =

> =

> Second patch fixes a Glib warning about a socket closed twice.
> dun_gw may need something similar.
> =

> Fr=C3=A9d=C3=A9ric Dalleau (2):
>   emulator: unref GIOChannel after creation
>   hfp_ag: Do not close client fd on unref
> =

>  plugins/hfp_ag.c |    9 +--------
>  src/emulator.c   |    2 ++
>  2 files changed, 3 insertions(+), 8 deletions(-)
> =


Both patches have been applied, thanks.

Regards,
-Denis

--===============3111413218493037875==--

