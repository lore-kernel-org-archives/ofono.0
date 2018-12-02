Content-Type: multipart/mixed; boundary="===============1694192203062672724=="
MIME-Version: 1.0
From: Navik, Ankit P <ankit.p.navik@intel.com>
Subject: RE: [PATCH 1/3] coex: Adding documetation for coex interface
Date: Sun, 02 Dec 2018 07:22:15 +0000
Message-ID: <2F886D5F95ED3A47BC8C177EADCD1CC7282E633F@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <1543570884-20303-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1694192203062672724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 11/30/2018 03:11 PM, Antara Borwankar wrote:
> From: Antara <antara.borwankar@intel.com>
> =

> Added coex-api.txt which defines coex interface for intel modems
> ---
>  doc/coex-api.txt | 126
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 doc/coex-api.txt
> =

> diff --git a/doc/coex-api.txt b/doc/coex-api.txt new file mode 100644 ind=
ex
> 0000000..8f5da47
> --- /dev/null
> +++ b/doc/coex-api.txt
> @@ -0,0 +1,126 @@
> +LTE Coexistence hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.org.ofono.intel.LteCoexistence
May be typo here. Interface should be org.ofono.intel.LteCoexistence

Regards, Ankit

> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods		dict GetProperties()
> +			Returns all coexistence configuration properties.
> +
> +			void SetProperty(string property, variant value)
> +			Changes the value of the specified property. Only
> properties that
> +			are listed as Read-write are changeable.
> +			On success a PropertyChanged signal will be emitted.
> +
> +			Possible Errors: [service].Error.InProgress
> +
> 	[service].Error.InvalidArguments
> +						[service].Error.Failed
> +
> +
> +		void RegisterAgent(object path)
> +
> +			Registers an agent which will be called whenever the
> +			modem initiates LTE Coexistence information.
> +
> +			Possible Errors: [service].Error.InProgress
> +					 [service].Error.InvalidArguments
> +					 [service].Error.InvalidFormat
> +					 [service].Error.Failed
> +
> +		void UnregisterAgent(object path)
> +
> +			Unregisters an agent.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.Failed
> +
> +		a(a{sv}) GetPlmnHistory()
> +			Requests for LTE Plmn history list stored in NVM to
> +			retrieve geo location history like MobileNetworkCode,
> +			MobileCountryCode, LteBandsFDD, LteBandsTDD,
> ChannelBandwidth.
> +
> +			Refer to the sections below for which property types
> +			are available, their valid value ranges and
> +			applicability to different cell types.
> +
> +Signals		PropertyChanged(string property, variant value)
> +			This signal indicates a changed value of the given
> property.
> +
> +
> +LTECoexistenceAgent Hierarchy [experimental] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Service		unique name
> +Interface	org.ofono.intel.LteCoexistenceAgent
> +Object path	freely definable
> +
> +Methods		void ReceiveBluetoothNotification
> +							(array{byte}
> notification, dict info) [noreply]
> +
> +			Requests the agent to process BT related LTE
> Coexistence
> +			information. The dictionary info contains vector table
> with modem
> +			recommended Safe Tx/Rx band and range
> information.The properties
> +			involved are 'SafeTxMin', 'SafeRxMin', 'SafeTxMax',
> 'SafeRxMax' and
> +			'SafeVector'.
> +
> +			Possible Errors: None
> +
> +		void ReceiveWiFiNotification
> +							(array{byte}
> notification, dict info) [noreply]
> +
> +			Requests the agent to process WiFi related LTE
> Coexistence
> +			information. The dictionary info contains vector table
> with modem
> +			recommended SafeTx/Rx band and range information.
> The properties
> +			involved are'SafeTxMin', 'SafeRxMin', 'SafeTxMax',
> 'SafeRxMax' and
> +			'SafeVector'.
> +
> +			Possible Errors: None
> +
> +		void Release() [noreply]
> +
> +			Agent is being released, possibly because of oFono
> +			terminating, Coex interface is being torn down or
> modem
> +			off. No UnregisterAgent call is needed.
> +
> +
> +Properties	string Band [readwrite]
> +			Frequency band in which the modem is operating when
> using "lte"
> +			mode.
> +
> +			boolean BTActive [readwrite]
> +			Maintains whether BT Coex is activated or not.
> +
> +			boolean WLANActive [readwrite]
> +			Maintains whether WLAN Coex is activated or not.
> +
> +			string WLANBandwidth [readwrite]
> +			Maintains at what frequency WLAN Coex is activated,
> when
> +			"CoexWLANActive"
> +			is active.
> +			The possible values are:
> +			- "20MHz"
> +			- "40MHz"
> +			- "80MHz"
> +
> +LTE Plmn history params
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +string
> +	uint16 MobileNetworkCode [readonly, optional]
> +		Contains the MNC of the cell.
> +
> +string
> +	uint16 MobileCountryCode [readonly, optional]
> +		Contains the MCC of the cell.
> +
> +	uint32 LteBandsFDD [readonly, optional]
> +		Contains the Lte FDD band. Valid range
> +		of values is 1 to 32 as per 3GPP 36.101 Section 5.5.
> +
> +	uint32 LteBandsTDD [readonly, optional]
> +		Contains the Lte TDD band. Valid range
> +		of values is 33 to 64 as per 3GPP 36.101 Section 5.5.
> +
> +	uint8 ChannelBandwidth [readonly, optional]
> +		Contains the Channel bandwidth. Valid range
> +		of values is 0 to 6 as per 3GPP 36.101 Section 5.6.
> --
> 1.9.1
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============1694192203062672724==--

