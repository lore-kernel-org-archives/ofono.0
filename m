Content-Type: multipart/mixed; boundary="===============1538665107386308947=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH v3 7/7] gps: add documentation
Date: Wed, 26 Jan 2011 19:47:46 -0200
Message-ID: <20110126214745.GA2192@joana>
In-Reply-To: <1296055974-9640-8-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1538665107386308947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

* Rafael Ignacio Zurita <rafael.zurita@profusion.mobi> [2011-01-26 12:32:=
54 -0300]:

> ---
>  Makefile.am                  |    3 +-
>  doc/gps-api.txt              |   49 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 51 insertions(+), 1 deletions(-)
>  create mode 100644 doc/gps-api.txt
>  mode change 100755 =3D> 100644 test/test-location-reporting
> =

> diff --git a/Makefile.am b/Makefile.am
> index 49bf8f3..2ebf9e6 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -399,7 +399,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt do=
c/release-faq.txt \
>  			doc/phonebook-api.txt doc/radio-settings-api.txt \
>  			doc/sim-api.txt doc/stk-api.txt \
>  			doc/audio-settings-api.txt doc/text-telephony-api.txt \
> -			doc/calypso-modem.txt doc/message-api.txt
> +			doc/calypso-modem.txt doc/message-api.txt \
> +			doc/gps-api.txt

What about call this location-report-api.txt?

>  =

>  =

>  test_scripts =3D test/backtrace \
> diff --git a/doc/gps-api.txt b/doc/gps-api.txt
> new file mode 100644
> index 0000000..85b0669
> --- /dev/null
> +++ b/doc/gps-api.txt
> @@ -0,0 +1,49 @@
> +Location Reporting hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.LocationReporting
> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods		dict GetProperties()
> +
> +			Returns all Gps properties. See the
> +			properties section for available properties.
> +
> +			Possible Errors: [service].Error.InProgress
> +					 [service].Error.Failed
> +
> +		void RegisterAgent(object path)
> +
> +			Registers an agent which will be called with the
> +			gps file descriptor.
> +
> +		void UnregisterAgent(object path)
> +
> +			Unregisters an agent.
> +

You are missing Enable() and Disable() methods here, you can't just enable =
the
GPS device when registering the Agent.

> +Properties	string Type [readonly]
> +
> +			Holds the type of the device (e.g. "nmea")

Then you also need a Enabled property here.

> +
> +LocationReportingAgent Hierarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		unique name
> +Interface	org.ofono.LocationReportingAgent
> +Object path	freely definable
> +
> +Methods		void ReceiveGpsFileDescriptor(int32 fd)

I think you get rid of this method an make Enable() return the file descrip=
tor
you want. Input from Marcel and Denis here would be good.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============1538665107386308947==--

