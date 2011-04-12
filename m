Content-Type: multipart/mixed; boundary="===============6115064324263762327=="
MIME-Version: 1.0
From: Vijay.Nayani@elektrobit.com
Subject: RE: [RFC PATCH 08/20] include: add set preferred ue mode api
Date: Tue, 12 Apr 2011 13:10:49 +0300
Message-ID: <AA48DD8077D5D945A49BD1782C1140F1EBB1FC@fioues08.ebgroup.elektrobit.com>
In-Reply-To: <4DA357DC.80309@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6115064324263762327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, =


> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

> Sent: 11 April 2011 22:35
> To: ofono(a)ofono.org
> Cc: Nayani Vijay
> Subject: Re: [RFC PATCH 08/20] include: add set preferred ue mode api
> =

> Hi Vijay,
> =

> On 04/11/2011 05:20 AM, Vijay Nayani wrote:
> > ---
> >  include/modem.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > =

> > diff --git a/include/modem.h b/include/modem.h index =

> 5a34370..e416f50 =

> > 100644
> > --- a/include/modem.h
> > +++ b/include/modem.h
> > @@ -51,6 +51,8 @@ void ofono_modem_reset(struct ofono_modem =

> *modem);  =

> > void ofono_modem_set_powered(struct ofono_modem *modem, =

> ofono_bool_t =

> > powered);  ofono_bool_t ofono_modem_get_powered(struct ofono_modem =

> > *modem);
> >  =

> > +void ofono_modem_set_preferred_ue_mode(struct ofono_modem =

> *modem, int =

> > +mode);
> > +
> =

> Are you assuming that the UE mode cannot be changed? If so, =

> doesn't this map to +CEMODE AT command? Doesn't it allow a =

> set operation to change the UE mode?
> =


We have made this currently read only as i don't see any usecase of this
being set from user side(settings or any other).
If a set provision need arises, this would bring in new API to driver
side as well to do the job. Also this would be purly apply for LTE.

> >  ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem);
> >  =

> >  ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem =

> > *modem);
> =

> Regards,
> -Denis
> =


Regards,
Vijay

--===============6115064324263762327==--

