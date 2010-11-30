Content-Type: multipart/mixed; boundary="===============3158508468444964351=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Tue, 30 Nov 2010 12:39:16 +0100
Message-ID: <1291117156.4795.40.camel@aeonflux>
In-Reply-To: <AANLkTim0Z-oPp3MRgf5jx15pt3+kFRtU=UmJkcuNGD08@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3158508468444964351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > I am getting a bit sick of this secrecy. oFono is for all intense and
> > purposes open source. So if you want a proper discussion here then
> > please list the AT command in question.
> =

> So this patch seems to be to enable reporting call direction as part
> of reporting call status using AT+CLCC.  It is needed by HFP as well
> as a conformance suite for USB ACM that R=C3=A9mi is working on.

as I said before, someone has to do the due diligence and start listing
all required AT commands for conformance testing. I want to see the full
picture and not some random patches here and there.

I am still not convinced that these details should be exposed via D-Bus
APIs at all. Using the internal AT emulator would be a way better fit.

So can you guys come up with a detailed list of AT commands for this? I
want to have this documented. Then we can have a proper discussion since
this is not getting anywhere.

Regards

Marcel



--===============3158508468444964351==--

