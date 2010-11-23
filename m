Content-Type: multipart/mixed; boundary="===============7557267726568237672=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: RE: [RFCv2] doc: Assisted Satellite Navigation API and Agent API
Date: Tue, 23 Nov 2010 18:24:46 +0100
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048BCE1C1CB@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <AANLkTi=dxaXQ1h2BZQecs9YS_Xjswgs81Spf5Uz9M_uv@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7557267726568237672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: andrzej zaborowski [mailto:balrogg(a)gmail.com]
> Sent: 23 November 2010 17:15
>
> =

> So should the agent interface additionally have a method like void
> AbortPositioningRequest()?
> =

> I have posted this as just a possible idea.  However parallel agent
> calls and aborting calls are both used in the agent interfaces in
> bluez and ofono.  D-bus is asynchronous, so whether you call a method
> and return immediately and then call another method to pass the
> response, or make it a single method call is just a difference in the
> protocol.

The abort is represented as an XML structure in CPOSR so if the =

underlying mechanism is AT commands then this would require ofono to do
some xml parsing.

Regards,

Simon=20

--===============7557267726568237672==--

