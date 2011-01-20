Content-Type: multipart/mixed; boundary="===============2468653676382899669=="
MIME-Version: 1.0
From: Rolf Offermanns <roffermanns@sysgo.com>
Subject: Re: DUN client questions
Date: Thu, 20 Jan 2011 11:48:32 +0100
Message-ID: <4D381300.1030405@sysgo.com>
In-Reply-To: <87tyh3sx8x.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2468653676382899669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/20/2011 11:08 AM, Kalle Valo wrote:
> Hi Rolf,
> =

> Rolf Offermanns <roffermanns-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org> w=
rites:
> =

>> Here is what I did to get the DUN connection up:
>>
>> 1. Connect the mobile using the bluetooth applet in MeeGo
>>    -> The modem was recognized as DUN capable and shows up in the
>>       "list-modems" output from ofonos test script as "/dun/xxx_yyy"
>> 2. Then using the ofono test scripts: enable_modem,
>> create-internet-context, activate-context
> =

> connman should enable modem and all the magic needed to set it up, you
> should not need to run ofono test scripts.

It seems there is more involved with cellular connections. Detecting the
modem in ofono is not enough to get it detected in connman.

I have a USB 3G modem, too. It does not show up in Connman when I plug
it in. After some time the modem registers to a network and only then it
gets listed in the meego-network-panel.

I think something along "register to a network and send notification
about this" is missing in the dunmodem driver.

-Rolf

--===============2468653676382899669==--

