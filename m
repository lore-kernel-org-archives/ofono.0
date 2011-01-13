Content-Type: multipart/mixed; boundary="===============3073330667448060530=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 9/9] gps: add documentation
Date: Thu, 13 Jan 2011 11:30:19 -0600
Message-ID: <4D2F36AB.8060903@gmail.com>
In-Reply-To: <1294716238-21218-10-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3073330667448060530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

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

So after discussing this some more with Marcel I'd like to change the
API slightly.  Instead of using a Powered property, let us use an Agent
with file descriptor passing instead.  The flow will roughly go like this:

LocationReporting interface becomes available and the string Type
property is known.  An external client registers an Agent with this
interface.  Internally this triggers the driver function to bring up the
GPS device and return the file descriptor to the core.  The core takes
care of calling the Agent with the file descriptor using DBus FD passing
mechanisms.

Once the remote client receives the file descriptor it can use it to
receive e.g. NMEA data.

Unregistering the agent or if the remote client exits unexpectedly
terminates should close the file descriptor and deactivate the NMEA stream.

> +
> +		dict Settings [readonly]
> +

This dictionary is no longer necessary.

> +			Holds the location information settings
> +
> +			string Device [readonly]
> +
> +				Holds the device from which the location
> +				information can be obtained (e.g. "/dev/ttyACM2")
> +

This makes this property unnecessary

> +			string Type [readonly]
> +
> +				Holds the type of the device (e.g. "nmea")
> +

And this property should be moved to a top level property instead of
being inside the Settings dict.

I hope my explanation was pretty clear, if not, find me on IRC.

Regards,
-Denis

--===============3073330667448060530==--

