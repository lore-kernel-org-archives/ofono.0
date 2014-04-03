Content-Type: multipart/mixed; boundary="===============4361296036592605387=="
MIME-Version: 1.0
From: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Thu, 03 Apr 2014 10:38:19 +0300
Message-ID: <533D0FEB.1080101@canonical.com>
In-Reply-To: <7247E8A2-DA61-4DB6-9995-7B127B7780EA@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4361296036592605387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02.04.2014 21:39, Marcel Holtmann wrote:

>> In testing it is sometimes useful to be able to replace the system
>> ofono daemon instance with our own. This patch makes this possible
>> using dbus' name replacement feature. This patch has the plumbing
>> changes to make it possible to set the name replacement settings.
>> The next patch allows you to set these parameters from the command
>> line. The default behaviour does not change, i.e. the service name
>> is not replaceable and the daemon will not try to replace an
>> existing ofono instance.
>
> what is this useful for. We have been running oFono for more than 4
> years and BlueZ with D-Bus for over 10 years and never had the need
> for doing this. So I do not understand why we would support this.

This helps in an issue that comes up in system-wide automated testing.
There are some tests that we want to run different ofono instances. All =

these tests need to run in the same instance and without root =

privileges. The normal approach would be to run the tests under a =

private dbus session. However this becomes problematic when the thing we =

are testing requires other services that are only provided by the real =

system bus. Permitting name transfer allows us to replace only the ofono =

instance and do so without root privileges (installing a custom dbus =

conf file that permits name replacement during testing is straightforward).

> And gdbus/ changes must always be in a separate patch. This code is
> used by ConnMan, oFono, BlueZ etc.

If the patch is otherwise acceptable, I'll reformat and resubmit.


--===============4361296036592605387==--

