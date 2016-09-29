Content-Type: multipart/mixed; boundary="===============4598636137695472992=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: IPV6 question
Date: Thu, 29 Sep 2016 11:07:28 -0500
Message-ID: <57ED3C40.5020705@gmail.com>
In-Reply-To: <6C3C91E4-F4C0-41B8-B6F0-B4A9484BBF90@gnumonks.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4598636137695472992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Harald,

On 09/29/2016 10:01 AM, Harald Welte wrote:
> This might be off topic, but AFAIR there are PPP type PDP contexts where =
not raw IP, but actual PPP frames are transmitted over GPRS inside SNDCP/LL=
C. Not sure if any operators use that, but its perfectly valid.
>

Yes, I think this was introduced in Release 7.  However, it would =

require the use of "PPP" pdp type in CGDCONT, not "IP".  Also, for EPS =

contexts I don't believe that "PPP" type is possible (nor wanted, as =

you'd fry your CPU keeping up with the high-bandwidth connection). =

Probably a legacy feature that might still be used in very narrow =

circumstances.  I've certainly never seen it used in practice.

> In this case PPP doesn't terminate in the modem, so "hardware" support sh=
ould be irrelevant.
>

True.  But I'm probably missing your point.  PPP packet compression is =

still an optional protocol feature, so it should not preclude =

interoperability.

Regards,
-Denis

--===============4598636137695472992==--

