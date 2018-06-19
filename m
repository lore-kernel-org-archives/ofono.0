Content-Type: multipart/mixed; boundary="===============5993931474923596309=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [BUG] plugins: sim900 support broken for tty port users
Date: Tue, 19 Jun 2018 11:49:42 -0500
Message-ID: <3ec50e05-a761-792a-46b3-22d55efe2275@gmail.com>
In-Reply-To: <525021f65bf87fdac3e954d0cae5e71b@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5993931474923596309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 06/19/2018 03:19 AM, poeschel(a)lemonage.de wrote:
> Hi!
> =

> I think I found a bug.
> =

> Commit 1d63b1d35 essentially breaks the sim900 driver for serial port =

> users.

Right.  This looks like some wires being crossed.  sim900 driver is only =

meant for serial port usage.  So listing it for 'option' isn't correct. =

Also, setup_sim900 was renamed from setup_simcom (introduced in =

f2bfaed17).  Unfortunately I don't think we ever had a simcom driver =

(e.g. plugins/simcom.c) for non-serial SIM COM modems until support for =

SIM 7100 was added.

> It adds a new entry in plugins/udevng.c driver_list with name "sim900".
> There are two entries with the same name then: The new one which calls
> the new setup_sim900 function and the old one which wants to call
> the old setup_serial_modem function. Since driver_list is scanned
> by name of the driver from top to button, serial driver users don't
> have a chance to reach the entry with setup_serial_modem anymore.
> Calling setup_sim900 does not work on a modem that was added through
> add_serial_device, because the union serial/devices is written a
> struct serial_device_info * that can not be used as GSList *.
> Maybe I am missing something, but I think the new driver name in
> driver_list should be different from the old one.

Right.  I've gone ahead and pushed out =

06f3a85ee3d187888640be71d5dd5293e6970d05 that should fix this.  Please =

let me know if it does.

It may be that the vid/pid "05c6/9000" meant for the simcom driver =

should be handled by sim7100 or some unified simcom driver that handles =

all SIM COM USB devices.

Regards,
-Denis

--===============5993931474923596309==--

