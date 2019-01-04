Content-Type: multipart/mixed; boundary="===============7015525213897639565=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: PPP broken by 6fc119d9eaee5f9cc37a5a7198d1c55ef98fd645
Date: Fri, 04 Jan 2019 21:54:42 +0100
Message-ID: <CAKSBH7FNWdrCZm42YZRdSZCYCvoGGJ8AiLvS7HY9AqA_zCfjkQ@mail.gmail.com>
In-Reply-To: <b7e415c0-e006-ebad-8d10-387b8a2b2916@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7015525213897639565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin, Denis,

On Fri, Jan 4, 2019 at 4:22 PM Martin Hundeb=C3=B8ll <martin@geanix.com> =
wrote:
>
> Hi Giacinto,
>
> On 04/01/2019 15.48, Giacinto Cifelli wrote:
> >> On 04/01/2019, Giacinto Cifelli <gciofono@gmail.com> wrote:
> >>>> The comments for a88662d23c45f49d9af5a508d4d0a778950b2420 made me
> >>>> suspect it is this part of the patch that broke it:
> >>>>
> >>>> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> >>>> index df9cd0ef..3fe38217 100644
> >>>> --- a/gatchat/ppp_lcp.c
> >>>> +++ b/gatchat/ppp_lcp.c
> >>>> @@ -279,6 +279,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data
> >>>> *pppcp,
> >>>>                                  *new_len =3D 4;
> >>>>
> >>>>                                  return RCR_NAK;
> >>>> +
> >>>> +                       case G_AT_PPP_AUTH_METHOD_NONE:
> >>>> +                               return RCR_REJECT;
> >
> > can you change your code to:
> >       return RCR_ACCEPT;
> >
> > this is what I posted in the first attempt to commit, but Denis
> > objected that a reject would be in order.
> > I still believe that an accept would select as before the default
> > operation at the end of the function, which is just... return
> > RCR_ACCEPT; (line 354 on the latest commit as of today)
> >
> > If this works, I can submit a new patch, or you can do it.
>
> It doesn't work, because the early return skips the call to
> ppp_set_auth() in the last switch block.
>
> Calling the function before returning works though:
>
> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index 3fe38217..4aa63207 100644
> --- a/gatchat/ppp_lcp.c
> +++ b/gatchat/ppp_lcp.c
> @@ -281,7 +281,8 @@ static enum rcr_result lcp_rcr(struct pppcp_data *ppp=
cp,
>                                  return RCR_NAK;
>
>                          case G_AT_PPP_AUTH_METHOD_NONE:
> -                               return RCR_REJECT;
> +                               ppp_set_auth(ppp,
> ppp_option_iter_get_data(&iter));
> +                               return RCR_ACCEPT;

what if we turn a blind eye and skip the case
G_AT_PPP_AUTH_METHOD_NONE, as proposed by Philippe at the beginning of
this thread?
Then the code should run onto the ppp_set_auth, and also strange
network behaviors can be handled.

>                          }
>                          break;
>                  }
>
>
>
> // Martin

Regards,
GIacinto

--===============7015525213897639565==--

