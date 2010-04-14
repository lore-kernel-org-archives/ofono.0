Content-Type: multipart/mixed; boundary="===============9223323965920460997=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: calypso does not power up from 0.17
Date: Wed, 14 Apr 2010 17:17:04 +0800
Message-ID: <4BC58810.6010901@intel.com>
In-Reply-To: <t2g359c5481004140152gdc106afcpfaaf00df4c75e9a@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9223323965920460997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 04/14/2010 04:52 PM, Nicola Mfb wrote:
> Hi!
>
> 0.16 is the last release that works (well) on the openmoko freerunner
> while from 0.17 to 0.20 I have:
>
> root(a)om-gta02 ~ $ dbus-send --system --dest=3Dorg.ofono --print-reply
> /freerunner org.ofono.Modem.SetProperty string:Powered
> variant:boolean:true
> Error org.ofono.Error.Timedout: Operation failure due to timeout
>
> I'm sorry I do not have much time in this period to dig deeply, anyway
> I found the commit that introduced the problem with git bisect.

You could set environment variable OFONO_AT_DEBUG to debug AT =

conversation, like:
	export set OFONO_AT_DEBUG=3D1

And I found the commit fb918d39ba275cdd327 in Jan 28th has changed the =

code to:
          if (read_count > 0 && rbytes =3D=3D 0 && err !=3D G_IO_ERROR_AGAI=
N)
                   return FALSE;

What's the err value in freerunner?

> Thanks and Regards
>
>       Niko
>
> commit aec5b8a44fa2fbece87441656eaf7ffb9a53fc6e
> Author: Denis Kenzior<denkenz@gmail.com>
> Date:   Thu Jan 14 10:25:14 2010 -0600
>
>      Fix: Make remote disconnect detection work
>
> diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
> index ea17335..8af927e 100644
> --- a/gatchat/gatchat.c
> +++ b/gatchat/gatchat.c
> @@ -801,7 +801,7 @@ static gboolean received_data(GIOChannel *channel,
> GIOCondition cond,
>          if (cond&  (G_IO_HUP | G_IO_ERR))
>                  return FALSE;
>
> -       if (err !=3D G_IO_ERROR_NONE&&  err !=3D G_IO_ERROR_AGAIN)
> +       if (rbytes =3D=3D 0&&  err !=3D G_IO_ERROR_AGAIN)
>                  return FALSE;
>
>          return TRUE;
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============9223323965920460997==--

