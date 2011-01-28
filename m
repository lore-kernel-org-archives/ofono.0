Content-Type: multipart/mixed; boundary="===============2743656079138535575=="
MIME-Version: 1.0
From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Fri, 28 Jan 2011 13:28:38 +0200
Message-ID: <4D42A866.5040604@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2743656079138535575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Sjur,

>  doc/ims-api.txt |  119
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 119 insertions(+), 0 deletions(-)
>   create mode 100644 doc/ims-api.txt
>
>
>  +Properties    boolean ImsVoiceRegistered [readwrite, optional]
>  +
>  +            Inform modem's radio stack that the IMS application
>  +            has registered for Voice over IMS. This impacts
>  +            "UE Mode of operation" and the ISR feature in the
>  +            radio stack. Related AT command: AT+EISR
>  +
>
>  +        boolean ImsSmsRegistered [readwrite, optional]
>  +
>  +            Inform modem's radio stack that the IMS application
>  +            has registered for SMS over IMS. This impacts
>  +            "UE Mode of operation" and the ISR feature in the
>  +            radio stack. Related AT command: AT+EISR
>  +
>  +        boolean ImsVoiceOverPs [readonly, optional]
>  +
>  +            IMS voice is enabled by network
>  +            Related AT command: AT+CIREP.
>  +

Which specification details this AT command, searched in 27.007 rel 10, but=
 it is
not available there.

Isn't ISR a property by default a UE should have when it is registered to L=
TE?. 23.401 says ISR support is mandatory for E-UTRAN UEs that support GERA=
N and/or UTRAN and optional for the network.
i don't think this setting should affect ISR behavior.

>
>  +        string  PrivateImsIdentity [readonly, optional]
>  +
>  +            Identity used for IMS registration.
>  +            Available if present on the ISIM.
>  +
>  +        string  PublicImsIdentity [readonly, optional]
>  +
>  +            Identity used for IMS registration.
>  +            Available if present on the ISIM.
>  +
>  +        string  HomeDomainName[readonly, optional]
>  +
>  +            Identity used for IMS registration.
>  +            Available if present on the ISIM.
>  +

Will these not be known to the user?
When does this interface becomes alive (org.ofono.ims)? post_sim or post_on=
line?


>  +        string  ImsToCsHandoverStatus [readonly, optional]
>  +
>  +            Indicate the handover progress status during a CS
>  +            fallback procedure. This property will only be present
>  +            when in LTE coverage. The possible values are:
>  +            "none", "started","complete", "failure".
>  +            Related AT URC: +CIREP
>  +

Again which specification details these AT commands?. Do we need a property=
 like this to show the CSFB?

why can't we...

while in LTE:
     oFono has network registration, connection manager, SIM and LTE
     specific interfaces

while in CSFB :
     oFono has all other interfaces too.


>  +        array{string}  PcscfAddresses[readonly]
>  +
>  +            Domain Name or IP Address of the P-CSCF servers.
>  +            (SIP Proxy).
>  +

This should be optional property based on the service table information.

>  +        array{dict,array{dict}} QosFilters [readonly, optional]
>  +
>  +            Information about the QoSes and associated Packet
>  +            Filters for the Default PDN and it's dedicated bearers.
>  +            It is organized as a list of QoS definitions with
>  +            a list of corresponding packet filters.
>  +
>  +                uint8 QoSClassIdentifier [readonly]
>  +                    The numeric parameter that specifying
>  +                    the class of QoS. (3GPP TS 23.203 [85])
>  +                    0    QCI is selected by network
>  +                    [1 =E2=80=93 4] guaranteed bit rate
>  +                    [5 =E2=80=93 9] non-guaranteed bit rate
>  +
>  +                uint16 UplinkRate [readonly, optional]
>  +                    Guaranteed Uplink Bit-rate in kb/sec.
>  +
>  +                uint16 DownlinkRate [readonly, optional]
>  +                    Guaranteed Downlink Bit-rate in kb/sec.
>  +
>  +            For each QoS defined there may be a list of Packet
>  +            Filters. Each Packet Filter is a dictionary defining
>  +            the filter. An empty Packet Filter represents the
>  +            "default" filter (Default PDN connection).
>  +
>  +                string Direction [readonly]
>  +                    "uplink", "downlink", "bidirectional"
>  +
>  +                uint8 ProtocolNumber [readonly]
>  +                    IP protocol number (0-256)
>  +
>  +                string PeerAddress [readonly]
>  +                    The remote peer's IP address.
>  +
>  +                uint16 PeerPortMin [readonly]
>  +                    Remote peer's port number min. value
>  +
>  +                uint16 PeerPortMax [readonly]
>  +                    Remote peer's port number max. value
>  +
>  +                uint16 LocalePortMin [readonly]
>  +                    The local port number min. value
>  +
>  +                uint16 LocalPortMax [readonly]
>  +                    The local port number max. value
>

Do we really need this?. What is the real usage of this information?.
In 27.007 there are few AT commands for TFT, and are not used, may be becau=
se no body (operator) supports this.

In LTE will this be going to be different?

regards
Arun




--===============2743656079138535575==--

