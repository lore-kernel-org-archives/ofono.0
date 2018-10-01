Content-Type: multipart/mixed; boundary="===============2368908338673440601=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/6] coex: adding coex interface doc for coex api
Date: Mon, 01 Oct 2018 18:26:13 +0200
Message-ID: <CAKSBH7Eit1ZeLfJ9kqqXwH1xbDaVtfBS5CoixtHM6c-cmFeHZg@mail.gmail.com>
In-Reply-To: <1538389988-6093-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2368908338673440601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On Mon, Oct 1, 2018 at 12:31 PM Antara Borwankar
<antara.borwankar@intel.com> wrote:
>
> From: Antara <antara.borwankar@intel.com>
>
> Added coex-api.txt which defines the generic coex dbus inteface
> and coex agent interface.
> ---
>  doc/coex-api.txt | 122 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 doc/coex-api.txt
>
> diff --git a/doc/coex-api.txt b/doc/coex-api.txt
> new file mode 100644
> index 0000000..0601500
> --- /dev/null
> +++ b/doc/coex-api.txt
> @@ -0,0 +1,122 @@
> +LTE Coexistence hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service                org.ofono
> +Interface      org.ofono.IntelLTECoex*
> +Object path    [variable prefix]/{modem0,modem1,...}
> +
> +Methods                dict GetProperties()
> +                       Returns all coexistence configuration properties.
> +
> +                       void SetProperty(string property, variant value)
> +                       Changes the value of the specified property. Only=
 properties that are
> +                       listed as Read-write are changeable.
> +                       On success a PropertyChanged signal will be emitt=
ed.
> +
> +                       Possible Errors: [service].Error.InProgress
> +                                               [service].Error.InvalidAr=
guments
> +                                               [service].Error.Failed
> +
> +
> +               void RegisterAgent(object path)
> +
> +                       Registers an agent which will be called whenever =
the
> +                       modem initiates LTE Coexistence information.
> +
> +                       Possible Errors: [service].Error.InProgress
> +                                        [service].Error.InvalidArguments
> +                                        [service].Error.InvalidFormat
> +                                        [service].Error.Failed
> +
> +               void UnregisterAgent(object path)
> +
> +                       Unregisters an agent.
> +
> +                       Possible Errors: [service].Error.InvalidArguments
> +                                        [service].Error.Failed
> +
> +               a(a{sv}) GetPlmnHistory()
> +                       Requests for LTE Plmn history list stored in NVM =
to
> +                       retrieve geo location history like MobileNetworkC=
ode,
> +                       MobileCountryCode, LteBandsFDD, LteBandsTDD, Chan=
nelBandwidth.
> +                       *most recently uused
> +                       *privacy
> +
> +                       Refer to the sections below for which property ty=
pes
> +                       are available, their valid value ranges and
> +                       applicability to different cell types.
> +
> +Signals                PropertyChanged(string property, variant value)
> +                       This signal indicates a changed value of the give=
n property.
> +
> +
> +LTECoexistenceAgent Hierarchy [experimental]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service                unique name
> +Interface      org.ofono.IntelLTECoexAgent
> +Object path    freely definable
> +
> +Methods                void ReceiveBluetoothNotification(array{byte} not=
ification, dict info)
> +
> +                       Requests the agent to process BT related LTE Coex=
istence information
> +                       The dictionary info contains vector table with mo=
dem recommended Safe
> +                       Tx/Rx band and range information.The properties i=
nvolved are
> +                       'SafeTxMin', 'SafeRxMin', 'SafeTxMax', 'SafeRxMax=
' and 'SafeVector'.
> +
> +                       Possible Errors: None
> +
> +               void ReceiveWiFiNotification(array{byte} notification, di=
ct info)
> +
> +                       Requests the agent to process WiFi related LTE Co=
existence information
> +                       The dictionary info contains vector table with mo=
dem recommended Safe
> +                       Tx/Rx band and range information. The properties =
involved are
> +                       'SafeTxMin', 'SafeRxMin', 'SafeTxMax', 'SafeRxMax=
' and 'SafeVector'.
> +
> +                       Possible Errors: None
> +
> +               void Release() [noreply]
> +
> +                       Agent is being released, possibly because of oFono
> +                       terminating, Coex interface is being torn down or=
 modem
> +                       off.  No UnregisterAgent call is needed.
> +
> +
> +Properties     string LTEBand [readwrite]
> +                       Frequency band in which the modem is operating wh=
en using "lte" mode.
> +
> +                       boolean CoexBTActive [readwrite]
> +                       Maintains whether BT Coex is activated or not.
> +
> +                       boolean CoexWLANActive [readwrite]
> +                       Maintains whether WLAN Coex is activated or not.
> +
> +                       string CoexWLANBandwidth [readwrite]
> +                       Maintains at what frequency WLAN Coex is activate=
d, when "CoexWLANActive"
> +                       is active.
> +                       The possible values are:
> +                       - "20MHz"
> +                       - "40MHz"
> +                       - "80MHz"
> +
> +*header for params
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +string
> +       uint16 MobileNetworkCode [readonly, optional]
> +               Contains the MNC of the cell.
> +
> +string
> +       uint16 MobileCountryCode [readonly, optional]
> +               Contains the MCC of the cell.
> +
> +       uint32 LteBandsFDD [readonly, optional]
> +               Contains the Lte FDD band. Valid range
> +               of values is 1 to 32 as per 3GPP 36.101 Section 5.5.
> +
> +       uint32 LteBandsTDD [readonly, optional]
> +               Contains the Lte TDD band. Valid range
> +               of values is 33 to 64 as per 3GPP 36.101 Section 5.5.
> +
> +       uint8 ChannelBandwidth [readonly, optional]
> +               Contains the Channel bandwidth. Valid range
> +               of values is 0 to 6 as per 3GPP 36.101 Section 5.6.
> --
> 1.9.1
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

it looks like a special function for Intel xmm modems.
Would't it be better to have a vendor-specific extension in the plugin?

I really wouldn't know how to use it for other modems.
And if there is a simple RF filter in the HW, the whole thing is unneeded.

Regards,
Giacinto

--===============2368908338673440601==--

