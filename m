Content-Type: multipart/mixed; boundary="===============0125644461935261456=="
MIME-Version: 1.0
From: Antti =?unknown-8bit?q?Kaijanm=C3=A4ki?= <antti.kaijanmaki@canonical.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Fri, 04 Apr 2014 04:16:43 +0300
Message-ID: <533E07FB.9020900@canonical.com>
In-Reply-To: <533DFBF9.9050906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0125644461935261456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04.04.2014 03:25, Denis Kenzior wrote:
>> The number of modems returned by org.ofono.Manager.GetModems() must
>> represent the total number of modems available to the system and thus we
>> need to have exactly two modems when testing dual-sim features etc.
>>
> =

> Sounds like your system is a bit inflexible, but okay.

The system is not inflexible, but we need to be able to set up the
environment for each test case according to the test plan.

As an example, not actual test plans:


=3D Test 1 =3D

Prerequisites:
 - number of modems: 1
   - modem 1
     - ID: Personal

Step 1:
Incoming call comes in on modem 1.
Verify:
 - notification of incoming call is shown
 - incoming call number is shown
 - the notification does not contain the ID of the modem
   receiving the call.

Step 2:
Accept the incoming call through the notification
Verify:
 - call interface shows up
 - call interface shows the incoming number
 - call interface does not show the modem ID

Step 3:
Hang up the call
Verify:
 - call is terminated
 - call interface turns to dialer interface
 - dialer interface does not show the Modem ID


=3D Test 1 =3D

Prerequisites:
 - number of modems: 2
   - modem 1
     - ID: Personal
   - modem 2
     - ID: Work

Step 1:
Incoming call comes in on modem 2.
Verify:
 - notification of incoming call is shown
 - incoming call number is shown
 - the notification contains the Modem ID "Work"

Step 2:
Accept the incoming call through the notification
Verify:
 - call interface shows up
 - call interface shows the incoming number
 - call interface shows the Modem ID "Work"

Step 3:
Hang up the call
Verify:
 - call is terminated
 - call interface turns to dialer interface
 - dialer interface allows to choose between two modems
   with IDs "Personal" and "Work"

Now, we have testing framework in place that we can do these tests in an
automated manner, testing the whole stack down from ofono up to the
final application that handles the phone calls, inspecting different
components that are visible on the screen no matter where they come from
(notifications from the notification system, applications, any shell
component..)

Now to run these tests in arbitrary order we need to be able to set up
the testing environment for each test individually.

For Test 1 we need oFono to expose a single modem for the duraction of
the test and through that modem we emulate the phone call and also
verify that the call gets terminated when the button in call interface
is pushed.

Test 2 is ran straight after Test 1 and for that we need to change the
number of modems to two and have them individually configured with
proper phonesim .xml files in between the two tests.


>> The need to change the number of modems during testing comes from the
>> fact that our test suite has the single and multimodem tests together
>> and runs them one after another and we need to be able to set up the
>> environment appropriately in between individual test cases.
>>
> =

> Why don't you simply write a plugin that handles all of this?  E.g.
> canonical_tester that creates two modem instances.  If you must insist
> on having exactly 1 or 2 modems, then just add a DBus interface to
> switch between modes.
> =

> Adding a control mechanism for controlling the number of phonesim
> instances seems like total overkill.

Yes, agreed. The DBus interface is the way to go.




--===============0125644461935261456==--

