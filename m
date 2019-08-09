Content-Type: multipart/mixed; boundary="===============2333724907086751857=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Fri, 09 Aug 2019 22:56:45 +1000
Message-ID: <CAA=hcWRNYQMPm2FJFmGNEvzFeUV2SC+rLvp+miB78qTY6LXwcQ@mail.gmail.com>
In-Reply-To: <CAKSBH7Fy-sPKYLMxXw0bK9He7E2u1tu=b9y8cbOrRVyokFEYjA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2333724907086751857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

I tried to run openwrt on my embedded system, it got netifd daemon to
manage the LTE modem, and started udhcpc -p /var/run/udhcpc-wwan0.pid
-s /lib/netifd, that problem has gone away.

Now I am really worried, if the problem of lost LTE network IP address
only happened in connman not in openwrt, it will unlikely be the carry
network and modem issues, could it be because that openwrt used udhcpc
to refresh the IP address? How does the connman manage the dhcp for
LTE IP address?

Thank you.

Kind regards,

- jh

On 8/9/19, Giacinto Cifelli <gciofono@gmail.com> wrote:
>> > Ask uBlox how to capture a protocol stack trace, and if it is feasible
>> > for your application, do it and have it analyzed by uBlox.
>> >
>> > Are you on GSM, on LTE catM or on LTE NB-IOT when this happens? On
>> > which network operator and country?
>>
>> It is LTE Cat-M1, the operator is Telstra in Australia. I will be very
>> interested in finding out what is going on.
>
> you need stack traces.
> Most likely the chipset you are using is the MDM9205, so the trace will be
> QXDM.
>
>>
>> Thank you.
>>
>> Kind regards,
>>
>> - jupiter
>
> BR,
> Giacinto
>

--===============2333724907086751857==--

