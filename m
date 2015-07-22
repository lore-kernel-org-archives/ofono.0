Content-Type: multipart/mixed; boundary="===============5963927507798735335=="
MIME-Version: 1.0
From: Mylene JOSSERAND <mylene.josserand@openwide.fr>
Subject: Re: [info] modem data disconnection
Date: Wed, 22 Jul 2015 08:19:53 +0200
Message-ID: <55AF3609.9070702@openwide.fr>
In-Reply-To: <55AE5F55.9080001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5963927507798735335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>>
>> I have some questions about ofono and the data disconnection.
>>
>> With debug information, after that my modem is online (connected to netw=
ork via ppp0 interface), when I go back to offline (by setting online prope=
rty to false), I can see that the modem network connection is down with :
>> ofonod[1039]: Modem: < ~\377}#\300!}%}#} }$\205r~
>>
>> and PPP interface is removed :
>> ofonod[1039]: udevng.c:remove_device() /sys/devices/virtual/net/ppp0
>>
>> I searched how ofono stops the modem connection, with escape sequence fo=
r example, but ofono does not seem to use it during offline sequence.
>>
>
> In this case the ofono_gprs_context atom is being created in post_online =
state.  Since you go offline, the modem goes back to post_sim state and any=
 atoms created in post_online() are destroyed.  E.g. the atom's remove() me=
thod is called.  This removes all PPP processing from the chat and forces i=
t back into AT command mode.

ok thank you for the explanation.
How atoms force to go back into AT commands mode ? Where is it done in the =
code ?

>
> There was a similar thread recently about SIM Removal on HE910 exhibiting=
 similar behavior.  In that case the modem went back to pre_sim state, so a=
ll post_sim and post_online atoms were destroyed.

I will look to it.

>
>> How does ofono handles it ?
>
> Solution is to put gprs_context creation into pre_sim on modems that repl=
y to CFUN=3D4 or equivalent before sending the final PPP frame.
>
>> How ofono (or gatppp, maybe ?) puts the modem network connection down (i=
f it does) ?
>>
>
> oFono detects PPP end-of-session frames as well as the NO CARRIER result =
code.  See gatchat/gathdlc.c new_bytes() and g_at_hdlc_set_no_carrier_detec=
t()

I noticed the gathdlc::new_bytes method when I was looking into the code bu=
t I did not understand what this file is it for. Thanks for the hints.

Best regards,

Mylene

--===============5963927507798735335==--

