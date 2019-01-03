Content-Type: multipart/mixed; boundary="===============4853207136800271375=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: sd-bus
Date: Thu, 03 Jan 2019 17:10:51 -0600
Message-ID: <ff562d48-46a4-dab0-6619-3a511180cef2@gmail.com>
In-Reply-To: <20190103203422.GA21861@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4853207136800271375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 01/03/2019 02:34 PM, Pavel Machek wrote:
> Hi!
> =

>> would it be interesting to port ofono from GDBus, which comes with the
>> huge GLib dependency, to sd-bus?
>> It is a lot of work, but the main question is whether we can assume
>> that systemd is deployed enough to allow the switch.
> =

> As someone said, ell already has dbus support.
> =

> But dependency on systemd would be bad -- I (and maemo leste project)
> am running ofonod on Devuan -- which is Debian w/o systemd.

We are not introducing any hard-dependencies on systemd, so no worries =

there.  ell will eventually be used for all D-Bus communication and =

libdbus-1 dependency will be dropped.

If anyone wants to help convert stuff to ell, be my guest.  I've already =

done some bits here and there.

After the next release or two I will start requiring any new core code =

to start using ell.  Drivers might take a bit longer due to use of =

GAtChat/GRil/GIsi/etc.

Regards,
-Denis

--===============4853207136800271375==--

