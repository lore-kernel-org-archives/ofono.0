Content-Type: multipart/mixed; boundary="===============8857416408313334059=="
MIME-Version: 1.0
From: Chris Pitchford <ofono@intrepid.cx>
Subject: Re: ppp
Date: Fri, 13 Nov 2009 12:13:38 +0000
Message-ID: <20091113121338.168862sljn41kiw4@boatman.intrepid.co.uk>
In-Reply-To: <1258113759.3299.16.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8857416408313334059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Quoting Marcel Holtmann <marcel@holtmann.org>:

> Hi Chris,
>
>> > Unfortunately it is not that simple.  pppd requires a proper kernel fi=
le
>> > descriptor to hand off to the kernel ppp line discipline.  In our  =

>> userspace
>> > implementation that is not the case.  1 kernel file descriptor is  =

>> shared by
>> > potentially many GAtChat channels using a multiplexing protocol.   =

>> Hence why we
>> > can't reuse the kernel implementation.
>> >
>>
>> Not sure how relevant this is, but many many years ago (1997) I used a
>> "telnet modem" to circumvent a firewall. It was a user land process that
>> presented a fake /dev/modem which I used using pppd and chat..
>>
>> My machine was behind a firewall with a telnet proxy.. Using the software
>> + pppd + chat, it was set up along the lines:
>>
>> start telnet modem which presented a /dev/modem.. start pppd using
>> /dev/modem:
>>
>> ATDT 1.2.3.4
>> CONNECT 1.2.3.4
>> the-telnet-proxy>
>> telnet my.host 23
>> connected to my.host:23
>> login:
>> mypppuser
>> password:
>> mypassword
>> end of chat script... start pppd
>>
>> In this situation, pppd and the kernel device would have been
>> communicating with a local userland process. The TCP connection to 1.2.3=
.4
>> created by the telnet modem could not have been used by the ppp interface
>> as the telnet modem was passing the streams in either direction
>> essentially joining the fd of the telnet connection and fd used by pppd..
>>
>> I'm not sure if the requirements of ppp in the kernel have chagned, but
>> couldn't something like this be repeated in this situation.. allowing pp=
pd
>> to speak to a local socket/fifo/pair of pipes that is terminated in user
>> space?
>
> yes we could do that, but why bother with a PTY to push the data packets
> into the kernel. At that point we can also run PPP in userspace and use
> a TUN/TAP device to create our network interface. The question is when
> do we wanna move the data from userspace into the kernel.
>
> Also pppd does the whole setup of PPP session. The ppp_generic in the
> kernel only das the data packets transport. Meaning the PPP session
> setup needs to be done in userspace anyway.
>
> Regards
>

I understand your point about the setup being done in user space, but  =

would it not be faster to present a vanilla pppd with a pty and allow  =

it to setup the connection and pass data to the kernel interface  =

rather than providing a new implementation? I mean from the point of  =

view of reusing software that is already available and very well tested?

On the down side I see the "eeeew" factor of creating a pty pair just  =

to pass data about, but if it means that far less code needs to be  =

written (and much less code that is to interpret line traffic) I  =

thought it might be safer solution. For example, if pppd is used, it  =

already supports a wealth of authentication and feature negotiation.

I guess there are downsides to both approaches..


--===============8857416408313334059==--

