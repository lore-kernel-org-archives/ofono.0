Content-Type: multipart/mixed; boundary="===============7610585092397518819=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH 2/5] cdma-voicecall: Add CDMA MO Call Support
Date: Fri, 03 Dec 2010 13:34:26 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3ABEC@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1291411231.6615.207.camel@dardoyle-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7610585092397518819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Dara,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org =

> [mailto:ofono-bounces(a)ofono.org] On Behalf Of Dara Spieker-Doyle
> Sent: 03 December 2010 13:21
 =

> > > +enum cdma_call_status {
> > > +	CDMA_CALL_STATUS_ACTIVE =3D 0,
> > > +	CDMA_CALL_STATUS_DIALING =3D 1,
> > > +	CDMA_CALL_STATUS_ALERTING =3D 2,
> > > +	CDMA_CALL_STATUS_INCOMING =3D 4,
> > =

> > Should be 3 ?
> =

> Yes indeed. I will fix this, thank you for catching it.
>  =

> > > +	CDMA_CALL_STATUS_DISCONNECTED
> > > +};
> > =

> > We can use the existing gsm call status itself ?
> > Just that we wont use the HELD and WAITING status in CDMA.
> =

> In this early phase of CDMA support in oFono, we would like =

> to evolve it in its own right for a while, per the offline =

> conversation from the MeeGo Conference in Dublin. On a case =

> by case basis, for items of large architectural impact, we =

> intend to evaluate potential re-use upfront.
> The plan is to allow smaller items like this for now, until =

> the related feature has matured sufficiently that they can be =

> re-factored correctly if applicable.
 =

I agree with the fact that we should evolve it in its own right.
But with these kind of straight forward cases, where the GSM values
are a superset of the CDMA values and these value definitions being
internal to ofono, we should try to to reuse the values rather than
creating new ones exclusive for CDMA.
Thats my view, Denis/Marcel any comments ?

BR,
Rajesh

--===============7610585092397518819==--

