Content-Type: multipart/mixed; boundary="===============8372377422498259195=="
MIME-Version: 1.0
From: Norbert Huffschmid <norbert.huffschmid@long-exposure.net>
Subject: Re: ofonod crashes during enable-modem.py
Date: Sat, 31 Jan 2015 18:51:55 +0100
Message-ID: <AAF281A0-C021-456F-B509-A74580329A45@long-exposure.net>
In-Reply-To: <54CD0157.8060707@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8372377422498259195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

this is the full backtrace:

(gdb) bt full
#0  notify_status_watches (netreg=3D0x100c20) at src/network.c:1182
         item =3D <optimized out>
         l =3D <optimized out>
         notify =3D <optimized out>
         mcc =3D 0x0
         mnc =3D 0x0
#1  0x00086ac4 in ofono_netreg_status_notify (netreg=3D0x100c20,  =

status=3D<optimized out>, lac=3D<optimized out>, ci=3D<optimized out>,
     tech=3D-1) at src/network.c:1384
         __FUNCTION__ =3D "ofono_netreg_status_notify"
#2  0x00064640 in ciev_notify (result=3D0xbefff4d4, user_data=3D0x100c20)  =

at drivers/hfpmodem/network-registration.c:130
         netreg =3D 0x100c20
         nd =3D 0x100c88
         iter =3D {result =3D 0xbefff4d4, l =3D 0x108c00,
           buf =3D "+CIEV: 1,1\000\000\063\000\000),(\"call\000,(0,1)), =

(\"callsetup\000,(0-3)),(\"callheld\000,(0-2)),(\"signal\000, =

(0-5)                                           ),(\"roam\000,(0,1)), =

(\"battchg\000,(0-5))\000\377\377\377\267\321\r\000\v", '\000'  =

<repeats 11 times>"\234, \321\r =

\000\000\000\000\00                                            =

0\206\354\r\000\v", '\000' <repeats 11 times>, "t\354\r =

\000\000\000\000\000\345{\r\000\v", '\000' <repeats 11 times>"\334, {\r =

\000\000                                           \000\000\000^\236\r =

\000\240\362\377\276\v\000\000\000\000\000\000\000^\236\r\000\344\205=D4=B6 =

\346{\r\000\344\205=D4=B6"..., line_pos =3D 10,
           pre =3D {data =3D 0x0, next =3D 0x108c00}}
         index =3D 402740
         value =3D -1090524048
         status =3D <optimized out>
#3  0x00036830 in at_notify_call_callback (data=3D<optimized out>,  =

user_data=3D<optimized out>) at gatchat/gatchat.c:384
         node =3D <optimized out>
         result =3D <optimized out>
#4  0xb6eefe14 in g_slist_foreach () from /lib/arm-linux-gnueabihf/ =

libglib-2.0.so.0
No symbol table info available.
#5  0x00037748 in at_chat_match_notify (line=3D0x37748 "\t \240\341\n =

\020\240\341\b", chat=3D0xff080) at gatchat/gatchat.c:419
         iter =3D {dummy1 =3D 0xfdc08, dummy2 =3D 0xbefff4ec, dummy3 =3D  =

0x1072c0, dummy4 =3D 3, dummy5 =3D -1225281536, dummy6 =3D 0x1}
         key =3D 0x0
         value =3D 0xe
         ret =3D 1084336
         notify =3D 0x1085a0
         result =3D {lines =3D 0x108c00, final_or_pdu =3D 0x0}
#6  have_line (str=3D0x37748 "\t \240\341\n\020\240\341\b", p=3D0xff080)  =

at gatchat/gatchat.c:607
---Type <return> to continue, or q <return> to quit---
         cmd =3D <optimized out>
#7  new_bytes (rbuf=3D0xe024, user_data=3D0xff080) at gatchat/gatchat.c:762
         rbytes =3D 3204445864
         p =3D 0xff080
         len =3D 29
         wrap =3D 29
         buf =3D 0x10990f "\n\r\n+CIEV: 3,0\r\n"
         result =3D <optimized out>
#8  0x0003976c in received_data (channel=3D0x1072c0, cond=3DG_IO_IN,  =

data=3D0x104d58) at gatchat/gatio.c:122
         buf =3D <optimized out>
         io =3D 0x104d58
         status =3D G_IO_STATUS_AGAIN
         rbytes =3D 22
         toread =3D <optimized out>
         total_read =3D 60
         read_count =3D 2
#9  0xb6f18ed4 in ?? () from /lib/arm-linux-gnueabihf/libglib-2.0.so.0
No symbol table info available.
#10 0xb6f18ed4 in ?? () from /lib/arm-linux-gnueabihf/libglib-2.0.so.0
No symbol table info available.
Backtrace stopped: previous frame identical to this frame (corrupt  =

stack?)
(gdb) ^CQuit
(gdb)

Hope it helps,
Norbert

Am 31.01.2015 um 17:22 schrieb Denis Kenzior:

> Hi Norbert,
>
> On 01/31/2015 10:04 AM, Norbert Huffschmid wrote:
>> Hi there,
>>
>> I'm testing ofono in a bluetooth HFP setup. I have successfully  =

>> paired a
>> smartphone and can see it via the list-modems.py script. When I try  =

>> to
>> enable the modem, ofonod crashes with segfault:
>>
>> Jan 31 16:27:40 raspberrypi ofonod[5296]: plugins/ =

>> hfp_hf.c:hfp_enable()
>> 0x570e70
>> Jan 31 16:27:45 raspberrypi ofonod[5296]:
>> src/modem.c:modem_change_state() old state: 0, new state: 1
>> Jan 31 16:27:45 raspberrypi ofonod[5296]: plugins/ =

>> hfp_hf.c:hfp_pre_sim()
>> 0x570e70
>> Jan 31 16:27:45 raspberrypi ofonod[5296]:
>> drivers/hfpmodem/call-volume.c:hfp_call_volume_probe()
>> Jan 31 16:27:45 raspberrypi ofonod[5296]:
>> drivers/hfpmodem/handsfree.c:hfp_handsfree_probe()
>> Jan 31 16:27:45 raspberrypi ofonod[5296]:
>> src/modem.c:modem_change_state() old state: 1, new state: 2
>> Jan 31 16:27:45 raspberrypi ofonod[5296]:
>> plugins/hfp_hf.c:hfp_post_sim() 0x570e70
>> Jan 31 16:27:45 raspberrypi ofonod[5296]:
>> src/modem.c:modem_change_state() old state: 2, new state: 3
>> Jan 31 16:27:45 raspberrypi ofonod[5296]: Service level connection
>> established
>> Jan 31 16:27:45 raspberrypi ofonod[5296]:
>> src/network.c:ofono_netreg_status_notify()
>> /hfp/001BDC0365E3_EC59E7D393ED status 1 tech -1
>> Jan 31 16:27:45 raspberrypi ofonod[5296]: Aborting (signal 11)
>> [/usr/sbin/ofonod]
>>
>
> Not much really to go on.  Can you provide a backtrace?
>
>> This happens with ofono 1.6-2 (Debian Wheezy) on a Raspberry Pi.
>>
>> Any ideas how to fix or work around this issue?
>
> Regards,
> -Denis
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


--===============8372377422498259195==--

