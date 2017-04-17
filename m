Content-Type: multipart/mixed; boundary="===============6584726299017135676=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH qmi lte v3 5/6] qmi: stop listening to packet service
 notifications
Date: Mon, 17 Apr 2017 15:19:29 -0500
Message-ID: <b7286088-80c0-f28d-a434-4d44c9598d6f@gmail.com>
In-Reply-To: <f4908787-b44f-7fdf-50ab-d6fb56807a2a@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6584726299017135676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> Okay, so now you're opening a whole new can of worms.  Dedicated
>> bearers are similar to secondary PDP contexts in 2G/3G.  Their
>> handling is even more special than primary PDP contexts / default
>> bearers.
>>
>> I wouldn't presume that your hardware supports this.  You need to
>> check.  How many physical network interfaces are exposed?  If its just
>> one like the gobi has, then you have your answer.
>
> Don't all LTE modems that support voice support dedicated bearers?

The answer is it depends.  Even if they do, you still need an IMS VoLTE =

stack to do anything useful with them.  Most modems have an IMS stack =

internal to the firmware, but not all will ship with one for your =

typical broadband connectivity stick.

>
> I think I was assuming you'd just get another IP address to set on the
> network interface... packets from that source would be handled with a
> different QoS setting.  Poking around the libqmi archive it seems that
> there is some activity around dedicated bearers, but all the modems in
> question only one have network interface.  But I really don't know
> enough about this... :(

The IP address will be the same.  All the dedicated bearer does is apply =

QoS to a particular service.

Maybe with QMI the packets will flow on the original network interface, =

even if a dedicated bearer was setup.  But then volte/ims usually uses a =

separate APN/bearer anyway.

>
> My hardware has only network interface in any case.
>

There you go.  I think QMI is mostly meant for data-only cards.

Regards,
-Denis

--===============6584726299017135676==--

