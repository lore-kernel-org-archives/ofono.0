Content-Type: multipart/mixed; boundary="===============2090859141211223950=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: Re: [BUG] plugins: sim900 support broken for tty port users
Date: Fri, 22 Jun 2018 14:45:57 +0200
Message-ID: <f41b01a5b2d395fcfc0ba98341beaec1@lemonage.de>
In-Reply-To: <3ec50e05-a761-792a-46b3-22d55efe2275@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2090859141211223950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> On 06/19/2018 03:19 AM, poeschel(a)lemonage.de wrote:
>> Hi!
>> =

>> I think I found a bug.
>> =

>> Commit 1d63b1d35 essentially breaks the sim900 driver for serial port =

>> users.
> =

> Right.  This looks like some wires being crossed.  sim900 driver is
> only meant for serial port usage.  So listing it for 'option' isn't
> correct. Also, setup_sim900 was renamed from setup_simcom (introduced
> in f2bfaed17).  Unfortunately I don't think we ever had a simcom
> driver (e.g. plugins/simcom.c) for non-serial SIM COM modems until
> support for SIM 7100 was added.
> =

>> It adds a new entry in plugins/udevng.c driver_list with name =

>> "sim900".
>> There are two entries with the same name then: The new one which calls
>> the new setup_sim900 function and the old one which wants to call
>> the old setup_serial_modem function. Since driver_list is scanned
>> by name of the driver from top to button, serial driver users don't
>> have a chance to reach the entry with setup_serial_modem anymore.
>> Calling setup_sim900 does not work on a modem that was added through
>> add_serial_device, because the union serial/devices is written a
>> struct serial_device_info * that can not be used as GSList *.
>> Maybe I am missing something, but I think the new driver name in
>> driver_list should be different from the old one.
> =

> Right.  I've gone ahead and pushed out
> 06f3a85ee3d187888640be71d5dd5293e6970d05 that should fix this.  Please
> let me know if it does.

I don't see 06f3a85ee3d187888640be71d5dd5293e6970d05 in public git,
but I guess 08796aa39186568402dd657704151079f1105dae (at the moment
on top of master) will also do. ;-)

I tested it. It chooses the right sim900 driver now and does start
communicating as I would expect it. Unfortunately I can't test much
more, because I don't own a sim900. Sorry.

Thank you for the quick fix,
Lars


--===============2090859141211223950==--

