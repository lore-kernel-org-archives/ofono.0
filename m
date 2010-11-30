Content-Type: multipart/mixed; boundary="===============4812454875219116024=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Tue, 30 Nov 2010 13:24:39 +0200
Message-ID: <AANLkTim0Z-oPp3MRgf5jx15pt3+kFRtU=UmJkcuNGD08@mail.gmail.com>
In-Reply-To: <1291114683.4795.33.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4812454875219116024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/11/30 Marcel Holtmann <marcel@holtmann.org>:
> I am getting a bit sick of this secrecy. oFono is for all intense and
> purposes open source. So if you want a proper discussion here then
> please list the AT command in question.

So this patch seems to be to enable reporting call direction as part
of reporting call status using AT+CLCC.  It is needed by HFP as well
as a conformance suite for USB ACM that R=C3=A9mi is working on.

In addition, I think it is good API design to provide call direction
as a property via a GetProperties() call, as it is already available
by witnessing call progress in the State property.  A user restarting
in the middle of an ongoing call will otherwise miss this state
information.

So technically, this patch should go in, especially given it is a
property without which these two users of oFono won't work properly.

Cheers,
Aki

--===============4812454875219116024==--

