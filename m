Content-Type: multipart/mixed; boundary="===============6141010309561566179=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [BUG] plugins: sim900 support broken for tty port users
Date: Tue, 19 Jun 2018 10:19:10 +0200
Message-ID: <525021f65bf87fdac3e954d0cae5e71b@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6141010309561566179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I think I found a bug.

Commit 1d63b1d35 essentially breaks the sim900 driver for serial port =

users.
It adds a new entry in plugins/udevng.c driver_list with name "sim900".
There are two entries with the same name then: The new one which calls
the new setup_sim900 function and the old one which wants to call
the old setup_serial_modem function. Since driver_list is scanned
by name of the driver from top to button, serial driver users don't
have a chance to reach the entry with setup_serial_modem anymore.
Calling setup_sim900 does not work on a modem that was added through
add_serial_device, because the union serial/devices is written a
struct serial_device_info * that can not be used as GSList *.
Maybe I am missing something, but I think the new driver name in
driver_list should be different from the old one.

Regards,
Lars

--===============6141010309561566179==--

