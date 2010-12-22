Content-Type: multipart/mixed; boundary="===============0145319889804420435=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 8/8] gps: add documentation
Date: Wed, 22 Dec 2010 16:02:16 -0600
Message-ID: <4D127568.1090101@gmail.com>
In-Reply-To: <1292531423-22316-9-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0145319889804420435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On 12/16/2010 02:30 PM, Rafael Ignacio Zurita wrote:
> ---
>  Makefile.am     |    3 ++-
>  doc/gps-api.txt |   41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletions(-)
>  create mode 100644 doc/gps-api.txt
> =

> diff --git a/Makefile.am b/Makefile.am
> index 4b8cb51..a8ad097 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -359,7 +359,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt do=
c/release-faq.txt \
>  			doc/message-api.txt doc/message-waiting-api.txt \
>  			doc/phonebook-api.txt doc/radio-settings-api.txt \
>  			doc/sim-api.txt doc/stk-api.txt \
> -			doc/audio-settings-api.txt doc/text-telephony-api.txt
> +			doc/audio-settings-api.txt doc/text-telephony-api.txt \
> +			doc/gps-api.txt
>  =

>  =

>  test_scripts =3D test/backtrace \
> diff --git a/doc/gps-api.txt b/doc/gps-api.txt
> new file mode 100644
> index 0000000..e9238a8
> --- /dev/null
> +++ b/doc/gps-api.txt
> @@ -0,0 +1,41 @@
> +GPS hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.Gps

As mentioned previously, lets make the Interface
org.ofono.LocationReporting.

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
> +		void SetProperty(string name, variant value)
> +
> +			Changes the value of the specified property. Only
> +			properties that are listed as read-write are
> +			changeable. On success a PropertyChanged signal
> +			will be emitted.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.InProgress
> +					 [service].Error.Failed
> +
> +Signals		PropertyChanged(string property, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> +Properties	boolean	Powered [readwrite]
> +
> +			This property will power or disable the GPS feature in
> +			the modem.
> +
> +			Many modem manufacturers provide a GPS unit with their
> +			modem hardware. This unit can be turned on or off and
> +			frequently takes over one of the tty ports that the
> +			modem provides.
> +

I think we need two additional properties here:

string Device [readonly]
	The device which can be used to obtain the location information

string Type [readonly]
	The type of the device (e.g. nmea)

One thing we can do here is stuff them inside a Settings dictionary
property that is emitted once Powered=3DTrue.  This is similar to how
org.ofono.ConnectionContext is implemented.

Regards,
-Denis

--===============0145319889804420435==--

