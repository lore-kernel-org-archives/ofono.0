Content-Type: multipart/mixed; boundary="===============3481192713719808657=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: Re: [PATCH] ste: Use UTF-8 as a default character set
Date: Tue, 18 Jan 2011 17:10:23 +0200
Message-ID: <1295363423.10484.78.camel@lkunnasl-desktop>
In-Reply-To: <1295361134.3873.183.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3481192713719808657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, 2011-01-18 at 16:32 +0200, Marcel Holtmann wrote:
> Hi Lasse,
> =

> >  plugins/ste.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > =

> > diff --git a/plugins/ste.c b/plugins/ste.c
> > index 7bb7232..cc01f7b 100644
> > --- a/plugins/ste.c
> > +++ b/plugins/ste.c
> > @@ -247,7 +247,7 @@ static int ste_enable(struct ofono_modem *modem)
> >  		return -EIO;
> >  =

> >  	data->chat =3D g_at_chat_new_blocking(channel, syntax);
> > -	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
> > +	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1;+CSCS=3D\"UTF=
-8\"",
> >  			NULL, NULL, NULL, NULL);
> =

> is it guaranteed that every single STE modem supports UTF-8 character
> set?
> =

Based on information I have, yes, every single ste modem support UTF-8.

> I would rather see a new command checking for supported character sets
> and then picking the default. And intermixing with ATE is not really
> clean from my perspective.
You want this to be changed accordingly? I tried to to follow minimalism
in this simple change and not to introduce new functions. If command
fails for some reason, modem uses its default value, which is IRA. It
could be on a separate line, but still I would not add a call back for
it, nothing to do if the command fails. I prefer the patch I sent, but
you can decide =


> =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



--===============3481192713719808657==--

