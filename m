Content-Type: multipart/mixed; boundary="===============6979614203047656068=="
MIME-Version: 1.0
From: Antti =?unknown-8bit?q?Kaijanm=C3=A4ki?= <antti.kaijanmaki@canonical.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Fri, 04 Apr 2014 03:00:56 +0300
Message-ID: <533DF638.5070503@canonical.com>
In-Reply-To: <533DD568.9080807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6979614203047656068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04.04.2014 00:40, Denis Kenzior wrote:
> Hi Antti,
>>
>> Indeed, and this combined with commit 5f765259 one can easily run a
>> series of tests (let's say dialer UI, messaging..) with different
>> phonesim configurations changing the number of modems and phonesim .xml
>> files for each modem.
> =

> I see what you needed that commit for now.  While I can kind of see your
> usecase, I really wonder whether simply creating a large phonesim.conf
> and grouping modems there would be a less intrusive way to get what you
> want.

That previous commit is something that is useful if ofonod with phonesim
is ran with unpriviledged uid on top of a private system bus, which is
totally doable, and works in situations where you have to test let's say
a low level binding library which expects ofono to be found on the
system bus.

Our original idea was to run all of our tests on top of private system
and session buses and in this situation the environment variable to
change the phonesim configuration file location would have been all we
need (and anyway, I personally don't like hardcoded configuration file
paths;)

But we ran into trouble trying to run the whole unity8 stack on top of
private session and system buses (mainly getting all the necessary
services on both the system and session bus to run on there as well was
exploding the test setup complexity) so we though about another
solutions and figured out that keeping the rest of the system running as
is and only replacing ofonod instance on real system-bus would be pretty
straight forward technically (such small patches:). Jussi sent the
patches to the mailing list so that we could get your opinion on them
and turns out (thanks Marcel!) that there might be better solutions
available.


 -- Antti


--===============6979614203047656068==--

