Content-Type: multipart/mixed; boundary="===============6248851980401782200=="
MIME-Version: 1.0
From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
Subject: Re: [RFCv3] doc: Proposal for LTE/IMS API
Date: Thu, 03 Mar 2011 17:29:15 +0200
Message-ID: <4D6FB3CB.6040703@nokia.com>
In-Reply-To: <1297377234-5056-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6248851980401782200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

I have a doubt on this interface
> +		void Register(array{string} types)
> +
> +			Registers an IMS Application. It must register
> +			with at least one of the types: "voice" or "messaging".
> +			In future "video" (Conversational Video, Live
> +			Streaming) should be added. This registration will
> +			inform the modem's radio stack that the IMS application
> +			has registered for Voice and/or Messaging over IMS.
> +			This registration may impact "UE Mode of operation"
> +			and the ISR feature in the radio stack.
> +
> +			The registered application is tracked, if the
> +			application exits the registration will be
> +			automatically released.
> +
> +			Possible Errors: [service].Error.InvalidArguments
27.007 describes +CEMODE which sets the UE mode of operation and is =

referring to 24.301.

There are only 4 modes PS Mode 1, PS Mode 2, PS/CS Mode 1, PS/CS Mode =

2.  These modes only specify, what type of attach is required (a IMSI, =

EPS or a combined). Also if UE supports CSFB, it should be in CS/PS =

modes . There is also +VCMOD which can be used to decide whether to use =

CS or PS for voice calls.

What does the Register interface do w.r.t ofono? What AT commands could =

be used here to signal the UE mode of operation to modem?

How does "voice" or "messaging" relate to the 4 modes specified in =

27.007 and 24.301?

Regards
Arun


--===============6248851980401782200==--

