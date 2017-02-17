Content-Type: multipart/mixed; boundary="===============3392161183427931687=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: huawei: modem channel gets closed after PPP disconnection
Date: Fri, 17 Feb 2017 17:37:02 +0100
Message-ID: <d8e1f630-a974-f369-ab7d-168295c10806@kerlink.fr>
In-Reply-To: <522eefa1-acf2-9477-758d-7f4cc73fe92a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3392161183427931687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 02/16/2017 06:51 PM, Denis Kenzior wrote:
>
> Doing it in the modem driver (e.g. plugins/huawei.c) is the right =

> place.  The fix you have come up with looks okayish.  However, you =

> might want to strace/ptrace ofonod to see what the kernel is actually =

> sending you to trigger this.  Also, a udev event monitor might help to =

> tell if the tty is being physically removed / reinserted.
>
I've done the connect/disconnect operation with strace and a udev event =

monitor. The PPP modem channel is /dev/ttyUSB1. Here is the result of =

the udev event monitor:
root(a)klk-lpbs-040070:~ # udevadm monitor
monitor will print the received events for:
UDEV - the event which udev sends out after rule processing
KERNEL - the kernel uevent

KERNEL[15443.637223] add      /devices/virtual/net/ppp0 (net)
KERNEL[15443.637377] add      /devices/virtual/net/ppp0/queues/rx-0 (queues)
KERNEL[15443.637464] add      /devices/virtual/net/ppp0/queues/tx-0 (queues)
UDEV  [15443.735949] add      /devices/virtual/net/ppp0 (net)
UDEV  [15443.742095] add      /devices/virtual/net/ppp0/queues/rx-0 (queues)
UDEV  [15443.754166] add      /devices/virtual/net/ppp0/queues/tx-0 (queues)
KERNEL[15449.168724] remove   /devices/virtual/net/ppp0/queues/rx-0 (queues)
KERNEL[15449.172883] remove   /devices/virtual/net/ppp0/queues/tx-0 (queues)
KERNEL[15449.176000] remove   /devices/virtual/net/ppp0 (net)
UDEV  [15449.183343] remove   /devices/virtual/net/ppp0/queues/tx-0 (queues)
UDEV  [15449.184839] remove   /devices/virtual/net/ppp0/queues/rx-0 (queues)
UDEV  [15449.275684] remove   /devices/virtual/net/ppp0 (net)

So only network interface appears (connection) and vanishes (disconnection).
The strace result is too big to be sent on the list, you can see it here:

https://framabin.org/?7e392864cc149771#8gyA/NLLDVVpnwxUV0FpR0wH5U6rwlogzy7S=
8yXmSMk=3D

What I learnt from it:

line 5839: open("/dev/ttyUSB1", O_RDWR|O_NOCTTY|O_NONBLOCK) =3D 10 =3D> open
line 9041: read(10, "\r\nNO CARRIER\r\n~\377}#\200!}%}\"} }$\210*~", =

8192) =3D 31 =3D> last data read
line 9049: poll([{fd=3D3, events=3DPOLLIN}, {fd=3D4, events=3DPOLLIN}, {fd=
=3D6, =

events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D8, events=3DPOLLIN}, {fd=
=3D9, =

events=3DPOLLIN}, {fd=3D10, events=3DPOLLIN}, {fd=3D11, events=3DPOLLIN}], =
8, -1) =

=3D 1 ([{fd=3D10, revents=3DPOLLIN|POLLERR|POLLHUP}]) =3D> poll error

So nothing more than a POLLERR|POLLHUP event on modem channel.

After that, /dev/ttyUSB1 is reopened (line 9068, before close, that's =

strange). This is because I 've done the trace with my patch. It does =

not give more information on why error happens, but we do know that =

/dev/ttyUSB1 does not disappear.

If you are OK, I'll send patch next week.

Best regards,

Christophe


--===============3392161183427931687==--

