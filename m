Content-Type: multipart/mixed; boundary="===============0247002747306070192=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Re: [PATCH 01/12] dbus: add gnss interface definition
Date: Fri, 18 Mar 2011 14:19:51 +0200
Message-ID: <1300450791.9383.3.camel@poutijar-desktop>
In-Reply-To: <4D82DEEB.4010203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0247002747306070192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 2011-03-18 at 06:26 +0200, Denis Kenzior wrote:
> Hi Jarko,
> =

> On 03/11/2011 06:22 AM, Jarko Poutiainen wrote:
> > ---
> >  include/dbus.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > =

> > diff --git a/include/dbus.h b/include/dbus.h
> > index 19a138a..bf3e8a4 100644
> > --- a/include/dbus.h
> > +++ b/include/dbus.h
> > @@ -56,6 +56,8 @@ extern "C" {
> >  #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
> >  #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
> >  #define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationRep=
orting"
> > +#define OFONO_AS_NAVIGATION_INTERFACE "org.ofono.AssistedSatelliteNavi=
gation"
> =

> Please name this OFONO_GNSS_INTERFACE
> =

Ok

> > +#define OFONO_POSITIONING_REQUEST_INTERFACE "org.ofono.PositioningRequ=
estAgent"
> =

> Please name this OFONO_GNSS_POSR_INTERFACE or
> OFONO_GNSS_POSR_AGENT_INTERFACE
> =

> Or feel free to suggest a better name, but the current names are getting
> too big
> =

Ok I'll use OFONO_GNSS_POSR_AGENT_INTERFACE
> >  =

> >  /* CDMA Interfaces */
> >  #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCa=
llManager"
> =

> Regards,
> -Denis

Br,
Jarko


--===============0247002747306070192==--

