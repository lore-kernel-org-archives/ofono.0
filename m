Content-Type: multipart/mixed; boundary="===============1249188143627360093=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: RE: [PATCH 2/5] cdma-voicecall: Add CDMA MO Call Support
Date: Fri, 03 Dec 2010 13:20:31 -0800
Message-ID: <1291411231.6615.207.camel@dardoyle-desktop>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3AA1A@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1249188143627360093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh

On Fri, 2010-12-03 at 01:30 +0100, ext Rajesh.Nagaiah(a)elektrobit.com
wrote:

> > +enum cdma_call_status {
> > +	CDMA_CALL_STATUS_ACTIVE =3D 0,
> > +	CDMA_CALL_STATUS_DIALING =3D 1,
> > +	CDMA_CALL_STATUS_ALERTING =3D 2,
> > +	CDMA_CALL_STATUS_INCOMING =3D 4,
> =

> Should be 3 ?

Yes indeed. I will fix this, thank you for catching it.
 =

> > +	CDMA_CALL_STATUS_DISCONNECTED
> > +};
> =

> We can use the existing gsm call status itself ?
> Just that we wont use the HELD and WAITING status
> in CDMA.

In this early phase of CDMA support in oFono, we would like to evolve it
in its own right for a while, per the offline conversation from the
MeeGo Conference in Dublin. On a case by case basis, for items of large
architectural impact, we intend to evaluate potential re-use upfront.
The plan is to allow smaller items like this for now, until the related
feature has matured sufficiently that they can be re-factored correctly
if applicable.

Cheers
Dara


--===============1249188143627360093==--

