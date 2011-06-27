Content-Type: multipart/mixed; boundary="===============3452929088626897722=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem detecting/using wwan0 modem
Date: Mon, 27 Jun 2011 10:53:32 -0500
Message-ID: <4E08A77C.2070406@gmail.com>
In-Reply-To: <20110627172502.GA2366@debut.europalab.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3452929088626897722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 06/27/2011 12:25 PM, ofonoconn(a)encambio.com wrote:
> =

> Hello Denis,
> =

> On Mon., June 27, 2011, Denis KENZIOR wrote:
>> On 06/27/2011 10:45 AM, ofonoconn(a)encambio.com wrote:
>>> Ofono (or connman, not sure which) presents connection options after
>>> detecting that wired and wireless ethernet interfaces exist. In my
>>> netbook, no option to use the F3607gw (labeled Hewlett-Packard below)
>>> WWAN modem device wwan0 is available.
>>>
>>> What could the problem be?
>>>
>> The 3607GW based modems are well supported by oFono, however we
>> have not tested all of the possible ones.  So assuming that you
>> have installed ofono.rules file correctly the only other problem
>> might be that your device manufacturer has named the port / network
>> devices slightly differently from other manufacturers.
>>
> The vanilla MeeGo distribution has:
> =

>   meego$ find /etc/udev/
>   /etc/udev/makedev.d/50-udev.nodes
>   /etc/udev/rules.d/70-persistent-cd.rules
>   /etc/udev/udev.conf
> =

> ...and nowhere is ofono.rules. Is that the problem? In which package
> are these things usually found? MeeGo includes 'ofono-0.58-1.4.i586'
> and 'ofono-test-0.58-1.4.i586' only.
> =


oFono has so far only released version 0.50 upstream, so I'm not sure
how Meego is making 0.58 ;)  Try putting plugins/ofono.rules from
ofono.git into /etc/udev/rules.d, re-plugging your dongle and starting
oFono with -n -d 'udev*'

> ...but:
> =

>   meego$ ls -1 /dev/.udev/db/*an*
>   /dev/.udev/db/net:wlan0
>   /dev/.udev/db/net:wwan0
> =

> ...so even without a ofono.rules, the modem is being detected?
> =

>> See plugins/udev.c add_mbm() for more details.  I see that we
>> definitely do not cover the "Broadband Network Device" case that
>> your modem is reporting.
>>
> If the missing 'ofono.rules' is not the problem, then I'll likely
> have to add a new entry to the list of devices in the add_mbm()
> function. Not sure how to determine the name of my device though.
> Huawei, sierra, nokia are there, but no 'ericsson'.
> =

>> Running ofono with -n -d 'udev*' command line options should help you
>> quickly diagnose the issue.
>>
> After booting I killed the 'ofonod' process and restarted it as root
> with the arguments -n -d 'udev*', but no output has appeared yet.
> How do you expect this to help, should I send USR1 signal or do
> something else?

Nope, sounds like the rules are not installed or the card is not
inserted (but I assume it is built-in, so the latter is probably not it)

Regards,
-Denis

--===============3452929088626897722==--

