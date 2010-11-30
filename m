Content-Type: multipart/mixed; boundary="===============0911462429753468945=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv2] doc: Assisted Satellite Navigation API and Agent API
Date: Tue, 30 Nov 2010 07:23:21 -0600
Message-ID: <4CF4FAC9.5080200@gmail.com>
In-Reply-To: <1290438707-10896-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0911462429753468945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur & Simon,

> diff --git a/doc/assisted-sattelite-navigation.txt b/doc/assisted-satteli=
te-navigation.txt
> new file mode 100755
> index 0000000..6c85a7f
> --- /dev/null
> +++ b/doc/assisted-sattelite-navigation.txt
> @@ -0,0 +1,56 @@
> +AssistedSatelliteNavigation hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

What do you think of naming this AssistedNavigation?  I think the
current name might be a bit too long.

> +
> +Service		org.ofono
> +Interface	org.ofono.AssistedSatelliteNavigation
> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods		void SendPositioningControl(string xml_element)

What do you think of SendPositioningElement?

> +
> +			Send an XML element conforming to the XML DTD for <pos>
> +			as defined in 3GPP 27.007 Table 8.55-2. This xml is
> +			used for transferring data associated with positioning
> +			requests received via control plane from the network.
> +			This includes assistance data requests and the results
> +			of positioning procedures. This method maps directly to
> +			the 3GPP 27.007 AT+CPOS command.
> +
> +		void RegisterPositioningRequestAgent(object path)
> +
> +			Registers an agent which will be called whenever a
> +			CPOSR AT response is received. The Agent must respond
> +			to requests using SendPositioningControl.
> +
> +		void UnregisterPositioningRequestAgent(object path)
> +
> +			Unregisters the agent.
> +
> +PositioningRequestAgent hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		unique name
> +Interface	org.ofono.PositioningRequestAgent
> +Object path	freely definable
> +
> +Methods	void PositioningRequest(string xml_element)

I think that 'Request' will be sufficient.  Positioning is already part
of the agent name.

> +
> +			Receive an XML element conforming to the XML DTD for
> +			<pos> in 3GPP 27.007. This xml is used for transferring
> +			data associated with positioning requests received, via
> +			control plane, from the network. This includes
> +			measurement requests and assistance data. This method
> +			maps directly to the 3GPP defined +CPOSR unsolicited
> +			result code.
> +
> +		void AssistanceDataReset()

I suggest ResetAssistanceData here.

> +
> +			A request has been received from the network that all
> +			assistance data should be reset.  This is used for 3gpp
> +			performance tests.
> +
> +		void Release()
> +
> +			Agent is being released, possibly because of oFono
> +			terminating, AssistedSatelliteNavigation interface
> +			is being torn down or modem off.
> +			No UnregisterAgent call is needed.

The only other change I'd make is to mark the entire interface
'experimental', but I can take care of that as well.

Otherwise the proposal looks good to me.

Regards,
-Denis

--===============0911462429753468945==--

