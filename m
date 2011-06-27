Content-Type: multipart/mixed; boundary="===============4100579215237087932=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem detecting/using wwan0 modem
Date: Mon, 27 Jun 2011 11:46:43 -0500
Message-ID: <4E08B3F3.70003@gmail.com>
In-Reply-To: <20110627184332.GA10037@debut.europalab.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4100579215237087932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 06/27/2011 01:43 PM, ofonoconn(a)encambio.com wrote:
> =

> Hello Denis,
> =

> On Mon., June 27, 2011, Denis Kenzior wrote:
>> On 06/27/2011 12:25 PM, ofonoconn(a)encambio.com wrote:
>>> On Mon., June 27, 2011, Denis KENZIOR wrote:
>>>> On 06/27/2011 10:45 AM, ofonoconn(a)encambio.com wrote:
>>>> The 3607GW based modems are well supported by oFono, however we
>>>> have not tested all of the possible ones.  So assuming that you
>>>> have installed ofono.rules file correctly the only other problem
>>>> might be that your device manufacturer has named the port / network
>>>> devices slightly differently from other manufacturers.
>>>>
>> oFono has so far only released version 0.50 upstream, so I'm not sure
>> how Meego is making 0.58 ;)  Try putting plugins/ofono.rules from
>> ofono.git into /etc/udev/rules.d, re-plugging your dongle and starting
>> oFono with -n -d 'udev*'
>>
> Its not a dongle, rather a Mini PCI-E  that I semi-permanently
> installed on the motherboard.
> =


That's what I figured.  The rules seem to be OK, so the udev detection
code in plugins/udev.c:add_mbm is not finding your modem.

Try starting oFono with

ofonod -n -d 'plugins/udev*' (sorry, I messed this up earlier)

and report the output

Regards,
-Denis

--===============4100579215237087932==--

