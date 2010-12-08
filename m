Content-Type: multipart/mixed; boundary="===============4930186622463629021=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/4] gisi: Changes to prepare for isimodem2.5
Date: Wed, 08 Dec 2010 10:31:35 +0100
Message-ID: <1291800695.4795.153.camel@aeonflux>
In-Reply-To: <1291797255-20472-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4930186622463629021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

> This set of patches introduces the isimodem2.5.
> =

> WG2.5 (isimodem2.5) Supported features list:
> =

> General:
> Online / Offline mode (RF on/off)
> =

> Voice call:
> MO/MT call
> Multiparty call (max 7 calls)
> Transfer call
> Swap calls
> Hold calls
> Hang up all
> Hang up specific call
> Disconnect reason (Network/local/remote)
> Send DTMF tones
> =

> PS data:
> Primary PDP context (IPv4 only)
> APN: User name and password supported
> Attach mode: Manual (Automatic works as well, but not activated)
> Data flow control not activated (Not supported by Kernel)
> =

> SMS:
> Send and receieve SMS
> Concatenated messages supported (up to 255 messages)
> Class 0
> Delivery reports
> Read / Write SMSC to SIM card
> Bearer settings supported (CS or PS)
> =

> Supplementary Services:
> Call Barring
>      VoiceOutgoing
>      VoiceIncoming
> Call Settings
>      CalledLineRestriction
>      HideCallerId
>      CallingLinePresentation
>      CalledLinePresentation
>      VoiceCallWaiting
>      CallingLineRestriction
> Call Forwarding
>      Voice Not Reachable
>      Voice Busy
>      Voice No Reply
>      Voice Unconditional
> USSD
>      MO USSD
>      MT USSD NOT SUPPORTED
> SSN
> =

> CS Network:
> Network registration
> Scanning available networks
> Selecting automatically and manually the target network
> Changing RAT between GSM/UMTS/ANY
> Registration status: Cell ID, LAC, MNC, Current Technology (GSM, UMTS, =

> EDGE, HSDPA, HSUPA, HSDPA&HSUPA)
> Deregister
> RSSI (%)
> =

> SIM:
> Read IMSI
> MSISDN (Subscriber numbers)
> SDN (Service Dialing Numbers)
> PIN/PIN2/PUK/PUK2 supported (reset/change/lock)
> Read file info from SIM
> Read FIle (Transparent, Linear & Cyclic) * Some functionalities flagged =

> out as ofono core is not using these
> Write File (Transparent, Linear & Cyclic) * Some functionalities flagged =

> out as ofono core is not using these
> MCC & MNC
> CardIdentifier
> PreferredLanguages
> =

> Export contacts(SIM phonebook):
> SIM and USIM cards supported
> Name
> Number (extension record supported)
> Additional number
> Email
> No limitiation in amount of records read from SIM
> =

> CBS:
> CBS reception in GSM
> Subscribe Topics in range or specific value
> =

> Phone Info:
> Revision of the modem SW
> IMEI
> =

> This specific patch contains updates in Makefile.am, configure.ac and gis=
i to prepare the addition of isimodem2.5
> Added 2 new files to gisi pipe_wg25.c and pipe_wg25.h, isimodem2.5 pipe i=
mplementation due to pipe handler not on modem side.

this needs to be split into separate patches and the commit message
needs to be a bit cleaner.

Also is this in sync with the GISI re-write Aki is doing?

Regards

Marcel



--===============4930186622463629021==--

