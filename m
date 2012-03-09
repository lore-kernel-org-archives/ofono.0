Content-Type: multipart/mixed; boundary="===============3594781319004050424=="
MIME-Version: 1.0
From: Mike <puffy.taco@gmail.com>
Subject: obtain HFP disconnection event reason code
Date: Thu, 08 Mar 2012 18:09:38 -0600
Message-ID: <CAB7rCThRVZmGensz_bv6rFFS5Pf_BvOiVW4dFjmC6KkoVLgvXQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3594781319004050424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to act like a better headset in the HFP HF role, I am in need
of the reason code from the disconnection event.  This is so that I
can detect when a disconnect occurs as a result of the units moving
out of range of each other, rather than an intentional disconnect.  In
the event of a disconnection based on connection loss, I can then
periodically re-attempt the connection.  I have not seen any D-Bus
messages that would indicate such an event.

Any ideas on how to obtain this?  I can see that in the hciops version
of bluez, the reason code makes it into bluetoothd just because the
entire disconnect event is transferred.  This is not the case in the
mgmtops version.  It looks like the reason code also hops along the
L2CAP path, but I haven't yet tracked down where it ends up.  I think
ideally it would end up somewhere that Ofono would be able to obtain
it.

Thanks,
Mike

--===============3594781319004050424==--

