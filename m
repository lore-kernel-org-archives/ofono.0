Content-Type: multipart/mixed; boundary="===============3320117330498507642=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: Re: [PATCH v3 7/7] gps: add documentation
Date: Wed, 26 Jan 2011 19:10:30 -0300
Message-ID: <20110126221030.GA18330@nodo3>
In-Reply-To: <20110126214745.GA2192@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3320117330498507642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 26, 2011 at 07:47:46PM -0200, Gustavo F. Padovan wrote:
> Hi Rafael,
> =

> * Rafael Ignacio Zurita <rafael.zurita@profusion.mobi> [2011-01-26 12:3=
2:54 -0300]:
> =

> > ---
> >  Makefile.am                  |    3 +-
> >  doc/gps-api.txt              |   49 ++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 51 insertions(+), 1 deletions(-)
> >  create mode 100644 doc/gps-api.txt
> >  mode change 100755 =3D> 100644 test/test-location-reporting
> > =

> > diff --git a/Makefile.am b/Makefile.am
> > index 49bf8f3..2ebf9e6 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -399,7 +399,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt =
doc/release-faq.txt \
> >  			doc/phonebook-api.txt doc/radio-settings-api.txt \
> >  			doc/sim-api.txt doc/stk-api.txt \
> >  			doc/audio-settings-api.txt doc/text-telephony-api.txt \
> > -			doc/calypso-modem.txt doc/message-api.txt
> > +			doc/calypso-modem.txt doc/message-api.txt \
> > +			doc/gps-api.txt
> =

> What about call this location-report-api.txt?

Yes, that could be more consistent.

> =

> >  =

> >  =

> >  test_scripts =3D test/backtrace \
> > diff --git a/doc/gps-api.txt b/doc/gps-api.txt
> > new file mode 100644
> > index 0000000..85b0669
> > --- /dev/null
> > +++ b/doc/gps-api.txt
> > @@ -0,0 +1,49 @@
> > +Location Reporting hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service		org.ofono
> > +Interface	org.ofono.LocationReporting
> > +Object path	[variable prefix]/{modem0,modem1,...}
> > +
> > +Methods		dict GetProperties()
> > +
> > +			Returns all Gps properties. See the
> > +			properties section for available properties.
> > +
> > +			Possible Errors: [service].Error.InProgress
> > +					 [service].Error.Failed
> > +
> > +		void RegisterAgent(object path)
> > +
> > +			Registers an agent which will be called with the
> > +			gps file descriptor.
> > +
> > +		void UnregisterAgent(object path)
> > +
> > +			Unregisters an agent.
> > +
> =

> You are missing Enable() and Disable() methods here, you can't just enabl=
e the
> GPS device when registering the Agent.

Why no? I followed the comments for the new API :
http://lists.ofono.org/pipermail/ofono/2011-January/007477.html
which suggests :

An external client registers an Agent with this
interface.  Internally this triggers the driver function to bring up the
GPS device and return the file descriptor to the core.  The core takes
care of calling the Agent with the file descriptor using DBus FD passing
mechanisms.

> =

> > +Properties	string Type [readonly]
> > +
> > +			Holds the type of the device (e.g. "nmea")
> =

> Then you also need a Enabled property here.
> =

> > +
> > +LocationReportingAgent Hierarchy [experimental]
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service		unique name
> > +Interface	org.ofono.LocationReportingAgent
> > +Object path	freely definable
> > +
> > +Methods		void ReceiveGpsFileDescriptor(int32 fd)
> =

> I think you get rid of this method an make Enable() return the file descr=
iptor
> you want. Input from Marcel and Denis here would be good.

If so then you would like to see the previous proposal, my version 2 of
the gps patches, which does you like.


Rafael Zurita

--===============3320117330498507642==--

