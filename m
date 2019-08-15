Content-Type: multipart/mixed; boundary="===============5623655865491183069=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Unsalble cellular connection
Date: Thu, 15 Aug 2019 16:58:50 +0200
Message-ID: <62d7df6f-278b-cfbc-af5e-e4539d2f7e3b@monom.org>
In-Reply-To: <CAA=hcWRL0JoVMwAEyP3a191qQR-CY1FyEj1mUUWKnMrAiiKnMA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5623655865491183069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 8/15/19 2:45 PM, JH wrote:
>> Well, the log _seemed_ to indicate that connman does an NTP request to a
>> server that isn't available and thereby decides to take the link down...
>> off the top of my head I can't say whether that's something connman
>> actually does so hopefully somebody else will jump in here.  Did ofono
>> indicate the context as still established after that?
> =

> That seems critical, every time when the link down, connman called:
> =

> connmand[213]: Time request for server 10.114.52.97 failed
> (101/Network is unreachable)

The NTP code is just telling it can't reach the server. This has no =

direct connenction to the next entry.

> Then deleted the link IP address to cause the link down:
> connmand[213]: wwan0 {del} address 10.114.52.98/30 label wwan0

This message is from the kernel via RTNL interface. The kernel tells =

ConnMan the interface state has changed.

> connmand[213]: Skipping disconnect of /ubloxqmi_0/context1, network is
> connecting.
> connmand[213]: ipconfig state 2 ipconfig method 1

and the above is then the cause of the RTNL message.

>> Seeing the issue with complete logs would be useful.  I thought your
>> previous logs indicated connman trying to deactivate the context when it
>> took the link down, but the ofono logs didn't show any of that... what's
>> going on there?
> =

> The full connman log file attached, there was no information for ofono
> log files. I don't think that ofono was aware of that connman deleted
> the IP address from the LTE link, I cannot understand why the connman
> did it. Anyway, I'll try to debug and to generate ofono log again.

Your log does not contain the debug information (connmand -d).

--===============5623655865491183069==--

