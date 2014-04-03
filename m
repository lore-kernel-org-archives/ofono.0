Content-Type: multipart/mixed; boundary="===============0535653737585016552=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Thu, 03 Apr 2014 10:50:02 -0700
Message-ID: <876A5952-5CE5-4B4D-8E9D-8DF3611BA36C@holtmann.org>
In-Reply-To: <533D0FEB.1080101@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0535653737585016552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

>>> In testing it is sometimes useful to be able to replace the system
>>> ofono daemon instance with our own. This patch makes this possible
>>> using dbus' name replacement feature. This patch has the plumbing
>>> changes to make it possible to set the name replacement settings.
>>> The next patch allows you to set these parameters from the command
>>> line. The default behaviour does not change, i.e. the service name
>>> is not replaceable and the daemon will not try to replace an
>>> existing ofono instance.
>> =

>> what is this useful for. We have been running oFono for more than 4
>> years and BlueZ with D-Bus for over 10 years and never had the need
>> for doing this. So I do not understand why we would support this.
> =

> This helps in an issue that comes up in system-wide automated testing.
> There are some tests that we want to run different ofono instances. All t=
hese tests need to run in the same instance and without root privileges. Th=
e normal approach would be to run the tests under a private dbus session. H=
owever this becomes problematic when the thing we are testing requires othe=
r services that are only provided by the real system bus. Permitting name t=
ransfer allows us to replace only the ofono instance and do so without root=
 privileges (installing a custom dbus conf file that permits name replaceme=
nt during testing is straightforward).

the custom D-Bus configuration needs to be installed as root. So you need t=
he root access right there. And if oFono is not running as root, then the s=
ame oFono user can start and stop it. I do not see what problem you are try=
ing to solve.

So just kill the current ofonod process using kill(1) and start the new one=
. If you have access to the process that is allowed to own the name, you ca=
n also terminate the current process.

Regards

Marcel


--===============0535653737585016552==--

