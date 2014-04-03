Content-Type: multipart/mixed; boundary="===============6109260450216633148=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Thu, 03 Apr 2014 10:55:18 -0700
Message-ID: <1D42A55E-765D-45A5-843D-AA092474C7F2@holtmann.org>
In-Reply-To: <533D2CD5.8010809@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6109260450216633148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

>>>> In testing it is sometimes useful to be able to replace the system
>>>> ofono daemon instance with our own. This patch makes this possible
>>>> using dbus' name replacement feature. This patch has the plumbing
>>>> changes to make it possible to set the name replacement settings.
>>>> The next patch allows you to set these parameters from the command
>>>> line. The default behaviour does not change, i.e. the service name
>>>> is not replaceable and the daemon will not try to replace an
>>>> existing ofono instance.
>>> =

>>> what is this useful for. We have been running oFono for more than 4
>>> years and BlueZ with D-Bus for over 10 years and never had the need
>>> for doing this. So I do not understand why we would support this.
>> =

>> This helps in an issue that comes up in system-wide automated testing.
>> There are some tests that we want to run different ofono instances. All
>> these tests need to run in the same instance and without root
>> privileges. The normal approach would be to run the tests under a
>> private dbus session. However this becomes problematic when the thing we
>> are testing requires other services that are only provided by the real
>> system bus. Permitting name transfer allows us to replace only the ofono
>> instance and do so without root privileges (installing a custom dbus
>> conf file that permits name replacement during testing is straightforwar=
d).
> =

> =

> Indeed, and this combined with commit 5f765259 one can easily run a
> series of tests (let's say dialer UI, messaging..) with different
> phonesim configurations changing the number of modems and phonesim .xml
> files for each modem.

this argument does not really fly with me. You can just disable/enable the =
phonesim modem over D-Bus and it allows you to connect to a total different=
 phonesim instance with a new phonesim.xml.

Or go the route of plugins/stktest.c and tools/stktest.c that we used for u=
nit testing SIM Toolkit.

And here as well. If you are allowed to own the D-Bus well know name, you n=
ormally can kill the current process and start a new one of your choice.

Regards

Marcel


--===============6109260450216633148==--

