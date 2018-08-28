Content-Type: multipart/mixed; boundary="===============7739045177326813837=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 1/2] atmodem: add Quectel M95 special case for PIN query
Date: Tue, 28 Aug 2018 14:10:47 -0500
Message-ID: <c0d2cbd6-050d-1f77-49d0-4bb97519b3a3@gmail.com>
In-Reply-To: <20180828074540.21858-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7739045177326813837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 08/28/2018 02:45 AM, Martin Hundeb=C3=B8ll wrote:
> The AT command reference for Quectel M95 specifies that remaining SIM
> pin retires can be queried using AT+QTRPIN, which responds with one
> count for each pin-type:
> =

> +QTRPIN: 3,3,10,10
> =

> After entering the PIN code, enable an extra AT+CPIN? for the M95
> vendor.
> =


Applied, thanks.

Regards,
-Denis


--===============7739045177326813837==--

