Content-Type: multipart/mixed; boundary="===============1387577773863882737=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Basic blocks for control channel.
Date: Mon, 07 Apr 2014 16:40:39 -0500
Message-ID: <53431B57.4000809@gmail.com>
In-Reply-To: <53430BDD.4010506@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1387577773863882737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

<snip>

> There are clear real world use cases the proposed change.

Nope, these are not 'real world' use cases.  These are constraints for a
synthetic unit test framework you are trying to create.

> Both are usable with on their own and allow flexibility for testers to
> choose the testing strategy based on their needs (private system bus vs.
> actual system bus, multiple .conf files vs. dbus configuration on the
> fly). Unit testing API bindings or testing middleware can use the
> private system bus approach and system or user story testing of a
> complete software stack such as a mobile phone user interface would use
> the actual system bus.
> =

> Having the dbus interface also allows automated test suite to set up
> number of ofono modems based on the environment specification of
> individual tests.

I don't buy any of these arguments.  You have a specific case you want
to test due to the constraints of how your system is designed.  Create a
plugin specific to your system; do not try to over-complicate the
phonesim plugin which is fine the way it is.

> =

> Also not mentioned before, the dbus interface allows to test
> Manager::modemAdded() and Modem::modemRemoved() logic in the unit under
> test.

Then make up a plugin to test that specifically if you really care.

> =

> =

>> UI should be designed to ignore non-powered modems, and only look for
>> interfaces that it handles specifically.  So for a properly designed UI,
>> none of these changes are required.  If you want to handle DualSim
>> cleanly, then feel free to propose a mechanism / hint that makes
>> applications aware of the fact that two modems belong to a group.
> =

> A system with two modems where one modem being powered off is still a
> system with two modems. One modem simply being powered off does not make
> the system a single-modem one.

Again, that is a constraint of your particular system design.  Relying
on one modem =3D=3D single SIM and two modems =3D=3D DualSIM is a bad idea.=
  As
I mentioned before, introduce proper handling of Dual SIM devices and
none of these issues are relevant.  Introducing features that are broken
by design will not fly.

> =

> In my opinion the cleanest way to implement Multi-SIM is to have ofono
> reporting a correct number of modems.
> =


And I disagree.  If I want to plug in 100 Dual-SIM modems, I should have
the ability to do so.  I do not want to rely on some magic conventions.

> UI should ignore non-powered modem only if the UI design for the
> particular component mandates so. The UI design could also mandate that
> if a modem is powered off, or has some other problem which makes it
> unusable, the modem should be shown as disabled. Or something else.
> =


Again, that is your UI design constraint.  We have plenty of situations
where oFono creates multiple modems that are not physically there (e.g.
Bluetooth HFP for example).

> =

> My point being:
>    A) Having to implement testing-only code paths to components makes
>       testing much more complicated and potentially erroneous as the
>       code paths being tested differ between testing and production.

You already have a testing-only code-path since you are using phonesim.
 Phonesim is only barely usable as an approximation of real hardware.
Introducing a plugin specific to your system setup is not going to
change anything here.

>    B) oFono should not impose arbitrary limits to UI/UX design.

This has been discussed many times before.  oFono is (and does) dictate
UI design to some extent.

Regards,
-Denis


--===============1387577773863882737==--

