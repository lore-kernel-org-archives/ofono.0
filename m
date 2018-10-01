Content-Type: multipart/mixed; boundary="===============0018024558799248793=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] coex: adding coex interface doc for coex api
Date: Mon, 01 Oct 2018 15:18:09 -0500
Message-ID: <ac9a6545-2d9c-1851-fe06-e657fc85b5af@gmail.com>
In-Reply-To: <1538389988-6093-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0018024558799248793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 10/01/2018 05:33 AM, Antara Borwankar wrote:
> From: Antara <antara.borwankar@intel.com>
> =

> Added coex-api.txt which defines the generic coex dbus inteface
> and coex agent interface.

So I don't mind this living inside doc, but lets make sure to make it =

clear that this is an intel only feature.

So perhaps doc/intel-lte-coex-api.txt

> ---
>   doc/coex-api.txt | 122 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 122 insertions(+)
>   create mode 100644 doc/coex-api.txt
> =

> diff --git a/doc/coex-api.txt b/doc/coex-api.txt
> new file mode 100644
> index 0000000..0601500
> --- /dev/null
> +++ b/doc/coex-api.txt
> @@ -0,0 +1,122 @@
> +LTE Coexistence hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.IntelLTECoex*

org.ofono.intel.LTECoexistence?

> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods		dict GetProperties()
> +			Returns all coexistence configuration properties.
> +
> +			void SetProperty(string property, variant value)
> +			Changes the value of the specified property. Only properties that are
> +			listed as Read-write are changeable.
> +			On success a PropertyChanged signal will be emitted.
> +
> +			Possible Errors: [service].Error.InProgress
> +						[service].Error.InvalidArguments
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
> +			MobileCountryCode, LteBandsFDD, LteBandsTDD, ChannelBandwidth.
> +			*most recently uused
> +			*privacy

??  Some of these look like private notes.

> +
> +			Refer to the sections below for which property types
> +			are available, their valid value ranges and
> +			applicability to different cell types.
> +
> +Signals		PropertyChanged(string property, variant value)
> +			This signal indicates a changed value of the given property.
> +
> +
> +LTECoexistenceAgent Hierarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		unique name
> +Interface	org.ofono.IntelLTECoexAgent

org.ofono.intel.LTECoexistenceAgent

> +Object path	freely definable
> +
> +Methods		void ReceiveBluetoothNotification(array{byte} notification, dic=
t info)
> +
> +			Requests the agent to process BT related LTE Coexistence information
> +			The dictionary info contains vector table with modem recommended Safe
> +			Tx/Rx band and range information.The properties involved are
> +			'SafeTxMin', 'SafeRxMin', 'SafeTxMax', 'SafeRxMax' and 'SafeVector'.
> +
> +			Possible Errors: None
> +
> +		void ReceiveWiFiNotification(array{byte} notification, dict info)
> +
> +			Requests the agent to process WiFi related LTE Coexistence information
> +			The dictionary info contains vector table with modem recommended Safe
> +			Tx/Rx band and range information. The properties involved are
> +			'SafeTxMin', 'SafeRxMin', 'SafeTxMax', 'SafeRxMax' and 'SafeVector'.
> +
> +			Possible Errors: None
> +
> +		void Release() [noreply]
> +
> +			Agent is being released, possibly because of oFono
> +			terminating, Coex interface is being torn down or modem
> +			off.  No UnregisterAgent call is needed.
> +
> +
> +Properties	string LTEBand [readwrite]
> +			Frequency band in which the modem is operating when using "lte" mode.
> +
> +			boolean CoexBTActive [readwrite]
> +			Maintains whether BT Coex is activated or not.

Hmm, why is this property on the Agent interface?  Are these meant to be =

on the LTECoexistence interface?

Also, given that Coex is already in the interface name, I'd just call =

this BluetoothActive.

> +
> +			boolean CoexWLANActive [readwrite]
> +			Maintains whether WLAN Coex is activated or not.
> +

Similarly here, WiFiActive

> +			string CoexWLANBandwidth [readwrite]
> +			Maintains at what frequency WLAN Coex is activated, when "CoexWLANAct=
ive"
> +			is active.
> +			The possible values are:
> +			- "20MHz"
> +			- "40MHz"
> +			- "80MHz"

Isn't this the channel 'width'?  So WiFiChannelWidth?

> +
> +*header for params

PLMN History Parameters?

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +string
> +	uint16 MobileNetworkCode [readonly, optional]

string or uint?

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
> =


Regards,
-Denis

--===============0018024558799248793==--

