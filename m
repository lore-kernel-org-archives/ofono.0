Content-Type: multipart/mixed; boundary="===============2269220588213409762=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH 0/3] Long dial string support (2nd)
Date: Mon, 22 Nov 2010 12:58:15 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702CCB78F@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <cover.1290436058.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2269220588213409762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras, =


> Dial strings can now be as long as 120 digits (not counting =

> '+'). This feature is going to be needed by the FDN feature.
> =

> An FDN may consist of a phone number plus a DTMF string. In =

> order to have the call succeed when FDN is enabled, both =

> parts need to be provided when making a call, as a single dial string.
> =

> For AT modems the long dial string can be and has to be =

> passed as is to the modem, for ISI modems the dial string =

> needs to be split into phone number (dest.
> address sub block) and DTMF tone (post dest. address sub =

> block) before feeding it to the modem.

Sending the DTMF tone in post dest. address sub block in case of =

the ISI modem or sending as part of the dial string in case of =

AT modems, will the modem take care of DTMF postfix handling by =

itself or its only going to use that for FDN check ?

If its going to be earlier case, then not all modems support =

this feature and also sending the postfix DTMF tone automatically =

by the modem without notifying to the AP, then the user neither =

wont be aware of ongoing DTMF tone sending as there will be no =

local playback of the tone nor will have any control over the =

DTMF tones sending.

So we should parse the dial string and extract the DTMF postfix =

(after the FDN check, anyways we are not suppoting FDN in oFono). =

Once the call gets connected, then the postfix DTMF tones can be =

sent out and signaled to the application about the start and stop
events of each tone, so the application can generate the =

corresponding DTMF tones using the tonegenerator for local =

playback.

Also currently the "w"/"W" stop character handling is not there, =

so I am not sure if its intentionally left out or missing ?

BR,
Rajesh

--===============2269220588213409762==--

