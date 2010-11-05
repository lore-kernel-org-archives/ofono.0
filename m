Content-Type: multipart/mixed; boundary="===============4811498348429047323=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 1/3] doc: addidng documentation for basic assisted gps
Date: Fri, 05 Nov 2010 20:47:12 +0100
Message-ID: <1288986432.9615.132.camel@aeonflux>
In-Reply-To: <4CD459DB.1030705@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4811498348429047323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >  doc/assistedgps-manager-api.txt |  114 +++++++++++++++++++++++++++++++=
++++++++
> >  1 files changed, 114 insertions(+), 0 deletions(-)
> >  create mode 100644 doc/assistedgps-manager-api.txt
> > =

> > diff --git a/doc/assistedgps-manager-api.txt b/doc/assistedgps-manager-=
api.txt
> > new file mode 100644
> > index 0000000..b09c8b1
> > --- /dev/null
> > +++ b/doc/assistedgps-manager-api.txt
> > @@ -0,0 +1,114 @@
> > +AgpsManager hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service		org.ofono
> > +Interface	org.ofono.AgpsManager
> =

> So in general I'm currently against introducing this API as oFono
> official API.  I suggest prefixing this with an IFX specific identifier.
>  Maybe modem.ifx.AgpsManager.

I would actually go one step further and call this com.infineon.Agps or
something like that.

As I stated this many times, before we make this a generic oFono API, we
need at least three types of modems that support this kind of feature
and find the common API.

For me this is clearly IFX and ISI right now. And it looks to me that
Sjur has also shown interested, so the third one might be STE/MBM.

Regards

Marcel



--===============4811498348429047323==--

