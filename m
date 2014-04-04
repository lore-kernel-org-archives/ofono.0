Content-Type: multipart/mixed; boundary="===============6799267935009777697=="
MIME-Version: 1.0
From: Antti =?unknown-8bit?q?Kaijanm=C3=A4ki?= <antti.kaijanmaki@canonical.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Fri, 04 Apr 2014 03:50:17 +0300
Message-ID: <533E01C9.9090101@canonical.com>
In-Reply-To: <533DF89F.8030003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6799267935009777697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04.04.2014 03:11, Denis Kenzior wrote:
> Hi Antti,
> =

>> Oh, didn't know that. That sounds great!
>> We were under the impression that the phonesim instances have to be
>> running before phonesim plugin loads and the modem .xml configurations
>> can't be changed on the fly.
> =

> What modem .xml configurations?  I'm lost now.

The XML files you pass to ofono-phonesim through command line parameter.


> You have phonesim plugin inside oFono that simply creates modem driver
> instances that essentially know two things:
>   - IP Address
>   - Port number.
> =

> When you enable the modem on path /phonesimN, a TCP connection is
> established.
> When you disable the modem, a TCP connection is killed.

Yes, got it now. If we want to change the modem configuration we simply
have to power down the modem, kill the old phonesim instance, start a
new one with another .xml and power the modem back on.


>> Now looking at stktest.c I see it opens a socket to communicate with an
>> external process.
>>
> =

> If by external process you mean oFono... then yes.  The setup is exactly
> the same as phonesim, just automated.  Think of stktest as a phonesim
> instance with a very limited AT command set, but tells oFono when to
> connect ;)

skttest is a oFono plugin which connects to an external process stktool,
yes, very much like phonesim plugin connects to a phonesim instance. But
what I was first proposing actually makes phonsim plugin (oFono) to
listen for connections from external processes.

But as you pointed out in your another reply that a plugin can do what
ever it wants then we don't need this custom listening socket, but we
can implement a proper dbus-interface instead.




--===============6799267935009777697==--

