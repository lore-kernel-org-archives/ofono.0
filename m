Content-Type: multipart/mixed; boundary="===============8620598754071803781=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] src/modem.c/call_watches null pointer check
Date: Tue, 23 Oct 2018 16:44:55 +0200
Message-ID: <CAKSBH7HrutxocDEs1HArB5Ebn9JvuMRUZQ6Z5T3_u4vmHWyEOg@mail.gmail.com>
In-Reply-To: <afe90723-1a43-90fd-02cc-7a44cd610818@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8620598754071803781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Oct 23, 2018 at 4:30 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/23/2018 02:50 AM, Giacinto Cifelli wrote:
> > check the pointer modem->atom_watches, that can be null when the
> > function is called during the disable/remove of the device,
> > for example when it is unplugged or switched off.
>
> If this caused a crash, a full stack trace would be helpful and should
> be part of this commit description.

you mean something like the following or more?

[2018-10-23 16:42:57+0200] ofonod[18153]:
plugins/udevng.c:remove_device()
/sys/devices/pci0000:00/0000:00:14.0/usb3/3-6/3-6:1.0/tty/ttyACM0
[2018-10-23 16:42:57+0200] ofonod[18153]:
plugins/udevng.c:destroy_modem()
/sys/devices/pci0000:00/0000:00:14.0/usb3/3-6
[2018-10-23 16:42:57+0200] ofonod[18153]:
src/modem.c:ofono_modem_remove() 0x5642795b0f00
[2018-10-23 16:42:57+0200] ofonod[18153]:
src/modem.c:modem_unregister() 0x5642795b0f00
[2018-10-23 16:42:57+0200] ofonod[18153]:
src/modem.c:modem_change_state() old state: 2, new state: 0
[2018-10-23 16:42:57+0200] ofonod[18153]: src/modem.c:flush_atoms()
[2018-10-23 16:42:57+0200] ofonod[18153]: src/lte.c:lte_atom_remove()
atom: 0x5642795c5010
[2018-10-23 16:42:57+0200] ofonod[18153]:
src/phonebook.c:phonebook_remove() atom: 0x5642795cbac0
[2018-10-23 16:42:57+0200] ofonod[18153]: src/sim.c:sim_remove() atom:
0x5642795b0c40
[2018-10-23 16:42:57+0200] ofonod[18153]:
plugins/gemalto.c:gemalto_disable() 0x5642795b0f00
[2018-10-23 16:42:57+0200] ofonod[18153]: Aborting (signal 11) [src/ofonod]
[2018-10-23 16:42:57+0200] ofonod[18153]: ++++++++ backtrace ++++++++
[2018-10-23 16:42:57+0200] ofonod[18153]: #0  0x7ffad5b36f20 in
/lib/x86_64-linux-gnu/libc.so.6
[2018-10-23 16:42:57+0200] ofonod[18153]: #1  0x5642791cb6ec in src/ofonod
[2018-10-23 16:42:57+0200] ofonod[18153]: #2  0x5642791cc32e in src/ofonod
[2018-10-23 16:42:57+0200] ofonod[18153]: #3  0x5642791cd45c in src/ofonod
[2018-10-23 16:42:57+0200] ofonod[18153]: #4  0x5642791a3f27 in src/ofonod
[2018-10-23 16:42:57+0200] ofonod[18153]: #5  0x5642791cc71a in src/ofonod
[2018-10-23 16:42:57+0200] ofonod[18153]: #6  0x5642791ce6a4 in src/ofonod
[2018-10-23 16:42:57+0200] ofonod[18153]: #7  0x5642791505d3 in src/ofonod
[2018-10-23 16:42:57+0200] ofonod[18153]: #8  0x7ffad6374091 in
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
[2018-10-23 16:42:57+0200] ofonod[18153]: #9  0x56427915561a in src/ofonod
[2018-10-23 16:42:57+0200] ofonod[18153]: #10 0x7ffad63860f5 in
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
[2018-10-23 16:42:57+0200] ofonod[18153]: #11 0x7ffad63864c0 in
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
[2018-10-23 16:42:57+0200] ofonod[18153]: #12 0x7ffad63867d2 in
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
[2018-10-23 16:42:57+0200] ofonod[18153]: #13 0x564279150397 in src/ofonod
[2018-10-23 16:42:57+0200] ofonod[18153]: #14 0x7ffad5b19b97 in
/lib/x86_64-linux-gnu/libc.so.6
[2018-10-23 16:42:57+0200] ofonod[18153]: +++++++++++++++++++++++++++


>
> Regards,
> -Denis

Regards,
Giacinto

--===============8620598754071803781==--

