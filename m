Content-Type: multipart/mixed; boundary="===============2253899443415697458=="
MIME-Version: 1.0
From: Antti =?unknown-8bit?q?Kaijanm=C3=A4ki?= <antti.kaijanmaki@canonical.com>
Subject: Re: [PATCH 1/2] Basic blocks for control channel.
Date: Mon, 07 Apr 2014 23:34:37 +0300
Message-ID: <53430BDD.4010506@canonical.com>
In-Reply-To: <5342B001.309@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2253899443415697458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07.04.2014 17:02, Denis Kenzior wrote:
> As I've said before, this is overkill.  It makes the phonesim plugin way
> more complicated that it needs to be.  A .conf parser with over-ridable
> directories, a control channel with add/remove/reset? Seriously?

There are clear real world use cases the proposed change.
(As complete reference for the readers the mailing list, please, see the
thread "[PATCH 1/2] Allow users to specify dbus name replacement
behaviour.").

Let me summarize.

$OFONO_PHONESIM_CONFIG:
Allows tests to run unpriviledged ofono instances with the
phonesim-plugin on top of private system bus without needing write
access to /etc/ofono/phonesim.conf in order to change the number of modems.

D-Bus control channel:
Allows changing the number of modems on a single system level ofono
instance.


Both are usable with on their own and allow flexibility for testers to
choose the testing strategy based on their needs (private system bus vs.
actual system bus, multiple .conf files vs. dbus configuration on the
fly). Unit testing API bindings or testing middleware can use the
private system bus approach and system or user story testing of a
complete software stack such as a mobile phone user interface would use
the actual system bus.

Having the dbus interface also allows automated test suite to set up
number of ofono modems based on the environment specification of
individual tests.

Also not mentioned before, the dbus interface allows to test
Manager::modemAdded() and Modem::modemRemoved() logic in the unit under
test.


> UI should be designed to ignore non-powered modems, and only look for
> interfaces that it handles specifically.  So for a properly designed UI,
> none of these changes are required.  If you want to handle DualSim
> cleanly, then feel free to propose a mechanism / hint that makes
> applications aware of the fact that two modems belong to a group.

A system with two modems where one modem being powered off is still a
system with two modems. One modem simply being powered off does not make
the system a single-modem one.

In my opinion the cleanest way to implement Multi-SIM is to have ofono
reporting a correct number of modems.

UI should ignore non-powered modem only if the UI design for the
particular component mandates so. The UI design could also mandate that
if a modem is powered off, or has some other problem which makes it
unusable, the modem should be shown as disabled. Or something else.


My point being:
   A) Having to implement testing-only code paths to components makes
      testing much more complicated and potentially erroneous as the
      code paths being tested differ between testing and production.
   B) oFono should not impose arbitrary limits to UI/UX design.


> If the above cannot be done, then please write a plugin to address your
> specific use case.

I hope these use cases show how these patches are useful, allow more
flexible testing strategies and don't change the fundamental purpose of
the phonesim-plugin.

All in less than 150 lines of code.


I would kindly ask you to reconsider.

 -- Antti



--===============2253899443415697458==--

