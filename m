Content-Type: multipart/mixed; boundary="===============7531834081540253563=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 12:46:00 -0500
Message-ID: <200909021246.01315.denkenz@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C968003549@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7531834081540253563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > I know why you want this, but I'm still against the counter being an
> > oFono driver API.  There needs to be a proper kernel interface that
> > signals the application when an interface has gone away with the rx/tx
> > details.  This way we handle this generically for all modems without
> > relying on some intrinsic hardware capabilities.
>
> This still doesn't solve the case where the modem is accessed from a PC
> client and forwards PPP data as that data will not go through any network
> interface, e.g. BT DUN or USB tethering.

The cases you describe imply that oFono is not even in control of the gprs =

context.  How would we track/report the tx/rx statistics in that case?

>
> The modem is really in the best position to provide the most reliable
> information on data usage. You can still use statistics from the network
> interfaces as a fall-back in case the modem can not provide this
> information.

I don't disagree, but not every modem can track these statistics and this =

isn't described by 27.007.  I suggest the initial support should be enabled=
 by =

the modem driver implementing a custom D-Bus interface and expose these =

details however it wishes.

Regards,
-Denis

--===============7531834081540253563==--

