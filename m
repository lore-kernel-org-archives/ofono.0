Content-Type: multipart/mixed; boundary="===============5297508240071300291=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [PATCH] Fix compile warning at MeeGo The gcc version is MeeGo
 4.5.1
Date: Fri, 07 Jan 2011 10:53:25 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD34CC43F8@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1294335887.2501.7.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5297508240071300291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf
> Of Marcel Holtmann
> Sent: Friday, January 07, 2011 1:45 AM
> To: ofono(a)ofono.org
> Subject: Re: [PATCH] Fix compile warning at MeeGo The gcc version is MeeGo
> 4.5.1
> =

> Hi Martin,
> =

> >  src/call-forwarding.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> > index 512f223..36ba4f1 100644
> > --- a/src/call-forwarding.c
> > +++ b/src/call-forwarding.c
> > @@ -246,7 +246,7 @@ static gboolean is_cfu_enabled(struct
> ofono_call_forwarding *cf,
> >  static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
> >  {
> >  	gboolean cfu_voice;
> > -	struct ofono_call_forwarding_condition *cond;
> > +	struct ofono_call_forwarding_condition *cond =3D NULL;
> >
> >  	cfu_voice =3D is_cfu_enabled(cf, &cond);
> =

> I really hate trying to fix compiler warnings like this.
> =

>         /*
>          * For now we only support Voice, although Fax & all Data
>          * basic services are applicable as well.
>          */
>         for (; l; l =3D l->next) {
>                 cond =3D l->data;
> =

>                 if (cond->cls > BEARER_CLASS_VOICE)
>                         continue;
> =

>                 if (out)
>                         *out =3D cond;
> =

>                 return TRUE;
>         }
> =

>         return FALSE;
> =

> So this is clearly a false positive. The only why this would fail is
This is not a false positive, it is quite possible not to reach the "for(;;=
)" branch, and uninitialized the *cond.
I have added
*out =3D NULL;
Out of the branch, and found that the warning gone.
So here I think gcc is right, and we need the patch.

> when l->data is NULL, but even then cond is initialized properly.
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

--===============5297508240071300291==--

