Content-Type: multipart/mixed; boundary="===============8761347037979924718=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 10:12:47 -0500
Message-ID: <4C7D1BEF.50800@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA8029A8D64@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8761347037979924718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 08/31/2010 03:58 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> =

> Hi,
> =

>   Currently, oFono expects the USSD string in UTF-8. ofono(Atom driver -
> AT or ISI) converts the UTF-8 string to GSM 7-bit default alphabet and
> sends it to the network. In this way, we will always send the data
> coding scheme as GSM 7-bit default alphabet or whatever the character
> set modem is configured. Why are we not sending the USSD string with
> DCS(Data coding scheme) as is to the network? There are USIM conformance
> test cases which expects the DCS(Data coding scheme) and USSD string
> sent as it is to the network. Also, as per the 3GPP TS 24.090, DCS and
> USSD string are sent as part of UnstructuredSS-Request to the network
> and MT is not expected to interpret the string. But ,here oFono doesn't
> have the interface to accept DCS(Data coding scheme) and also it expects
> the USSD string to be in UTF-8.
> =


The original USSD API actually did look like this.  It used binary data
+ dcs field.  However, we quickly found that all modems are screwed up
in this area.  The specification added binary PDU mode to SMS and CBS,
but never bothered with USSD.  So all modems get this part wrong.

Currently about the best we can do is pass UTF8 around.  If you have a
modem that gets this part right, we'd like to hear about it.  If the
Send USSD proactive command is not handled by the modem, then oFono will
try to do its best.  However, we make no guarantees ;)

Regards,
-Denis

--===============8761347037979924718==--

