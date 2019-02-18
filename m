Content-Type: multipart/mixed; boundary="===============6616638992634983865=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8] atmodem/gprs.c: Add CEREG support
Date: Sun, 17 Feb 2019 22:04:31 -0600
Message-ID: <9d707b1b-cd8a-219a-e108-4e6b61c59f75@gmail.com>
In-Reply-To: <20190215121142.28163-6-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6616638992634983865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 02/15/2019 06:11 AM, philippedeswert(a)gmail.com wrote:
> From: Tommi Rekosuo <tommi.rekosuo@treon.fi>
> =

> For NB-IoT modems we need to use AT+CEREG instead of AT+CGREG
> when in LTE network and detecting network registration in initial boot.
> Enable +CEREG URC and use that also to detect registration state.

Read the thread I referred to in one of my other replies.  gprs should =

really be taught to understand that it is on LTE and not even bother =

asking for registration_status from gprs driver in those cases.  That =

would remove any need to add the code in this proposal.

Regards,
-Denis

--===============6616638992634983865==--

