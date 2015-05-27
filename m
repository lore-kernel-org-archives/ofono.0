Content-Type: multipart/mixed; boundary="===============6960015568053483302=="
MIME-Version: 1.0
From: Mike Williams <mike@mikebwilliams.com>
Subject: Re: bug reactivating primary context?
Date: Wed, 27 May 2015 14:52:30 -0400
Message-ID: <CANPyyuNZTyoABrKsa-_BAwThLxh90zbibcO69Y1uix-qdkZBgg@mail.gmail.com>
In-Reply-To: <5565FB60.7000502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6960015568053483302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

On Wed, May 27, 2015 at 1:14 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mike,
>
>>
>> It looks like AT&C0 is correctly being issued, from the logs here:
>>
>> ofonod[1398]: plugins/huawei.c:sysinfo_enable_cb() 255 -> 1
>> ofonod[1398]: Modem: > AT&C0\r
>> ofonod[1398]: PCUI: > AT&C0\r
>> ofonod[1398]: PCUI: < \r\nOK\r\n
>>
>> I'm using a Huawei e173:
>> ofonod[2008]: Modem: < ATE0 +CMEE=3D1\r\r\nOK\r\n
>> ofonod[2008]: PCUI: < \r\nManufacturer: huawei\r\nModel:
>> E173L\r\nRevision: 21.106.04.00.982\r\nIMEI: 868387000063372\r\n+GCAP:
>> +CGSM,+DS,+ES\r\n\r\nOK\r\n
>
>
> Yes, certain models of Huawei modems are the main culprits.  There have b=
een
> a few suggestions on how to solve this, but it is quite nasty & requires
> re-opening the AT modem port.  Nobody had the itch to fix it properly.
>
>>
>> Is there any way I can see if the modem is closing the command port?
>>
>
> strace, or use g_at_chat_set_disconnect_function() and see if that gets
> called.

It looks like polling the fd for ttyUSB3 returns POLLHUP. Opened here:

writev(2, [{"ofonod[2619]: plugins/huawei.c:o"..., 63}, {"\n", 1}],
2ofonod[2619]: plugins/huawei.c:open_device() Modem /dev/ttyUSB3
) =3D 64
send(5, "<31>May 27 12:42:50 ofonod[2619]"..., 83, MSG_NOSIGNAL) =3D 83
open("/dev/ttyUSB3", O_RDWR|O_NOCTTY|O_NONBLOCK|O_LARGEFILE) =3D 10


PPP disconnect and then poll() returning POLLHUP:

writev(2, [{"ofonod[2619]: drivers/atmodem/gp"..., 71}, {"\n", 1}],
2ofonod[2619]: drivers/atmodem/gprs-context.c:ppp_disconnect() Reason:
6
) =3D 72
send(5, "<31>May 27 12:43:56 ofonod[2619]"..., 91, MSG_NOSIGNAL) =3D 91
sendmsg(6, {msg_name(0)=3DNULL,
msg_iov(2)=3D[{"l\2\1\1\0\0\0\0<\0\0\0\30\0\0\0\6\1s\0\5\0\0\0:1.69\0\0\0".=
..,
40}, {"", 0}], msg_controllen=3D0, msg_flags=3D0}, MSG_NOSIGNAL) =3D 40
sendmsg(6, {msg_name(0)=3DNULL,
msg_iov(2)=3D[{"l\4\1\1\30\0\0\0=3D\0\0\0h\0\0\0\1\1o\0\22\0\0\0/huawei_"..=
.,
120}, {"\10\0\0\0Settings\0\5a{sv}\0\0\0\0\0", 24}], msg_controllen=3D0,
msg_flags=3D0}, MSG_NOSIGNAL) =3D 144
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) =3D 12
ioctl(12, SIOCGIFFLAGS, {ifr_name=3D"ppp0", ???}) =3D -1 ENODEV (No such de=
vice)
close(12)                               =3D 0
sendmsg(6, {msg_name(0)=3DNULL,
msg_iov(2)=3D[{"l\4\1\1\24\0\0\0>\0\0\0h\0\0\0\1\1o\0\22\0\0\0/huawei_"...,
120}, {"\6\0\0\0Active\0\1b\0\0\0\0\0\0\0", 20}], msg_controllen=3D0,
msg_flags=3D0}, MSG_NOSIGNAL) =3D 140
poll([{fd=3D3, events=3DPOLLIN}, {fd=3D4, events=3DPOLLIN}, {fd=3D11,
events=3DPOLLIN}, {fd=3D6, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=
=3D10,
events=3DPOLLIN}, {fd=3D8, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}], 8,=
 -1)
=3D 1 ([{fd=3D10, revents=3DPOLLIN|POLLERR|
POLLHUP}])
read(3, 0xbe9f5af0, 16)                 =3D -1 EAGAIN (Resource
temporarily unavailable)
write(3, "\1\0\0\0\0\0\0\0", 8)         =3D 8
read(10, "", 8192)                      =3D 0
write(3, "\1\0\0\0\0\0\0\0", 8)         =3D 8
write(3, "\1\0\0\0\0\0\0\0", 8)         =3D 8
close(10)


Any simple ways to fix this, and are all Huawei USB modems subject to
this? This was for prototyping on an embedded system, can anyone give
recommendations for good modems that are known to work well with
ofono?

Thanks,
Mike

--===============6960015568053483302==--

