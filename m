Content-Type: multipart/mixed; boundary="===============0073432121812047327=="
MIME-Version: 1.0
From: Norbert Huffschmid <norbert.huffschmid@long-exposure.net>
Subject: ofonod crashes during enable-modem.py
Date: Sat, 31 Jan 2015 17:04:44 +0100
Message-ID: <5C9823BE-B7A7-4E4B-8229-25E10C7DDDA3@long-exposure.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0073432121812047327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi there,

I'm testing ofono in a bluetooth HFP setup. I have successfully paired  =

a smartphone and can see it via the list-modems.py script. When I try  =

to enable the modem, ofonod crashes with segfault:

Jan 31 16:27:40 raspberrypi ofonod[5296]: plugins/ =

hfp_hf.c:hfp_enable() 0x570e70
Jan 31 16:27:45 raspberrypi ofonod[5296]: src/ =

modem.c:modem_change_state() old state: 0, new state: 1
Jan 31 16:27:45 raspberrypi ofonod[5296]: plugins/ =

hfp_hf.c:hfp_pre_sim() 0x570e70
Jan 31 16:27:45 raspberrypi ofonod[5296]: drivers/hfpmodem/call- =

volume.c:hfp_call_volume_probe()
Jan 31 16:27:45 raspberrypi ofonod[5296]: drivers/hfpmodem/ =

handsfree.c:hfp_handsfree_probe()
Jan 31 16:27:45 raspberrypi ofonod[5296]: src/ =

modem.c:modem_change_state() old state: 1, new state: 2
Jan 31 16:27:45 raspberrypi ofonod[5296]: plugins/ =

hfp_hf.c:hfp_post_sim() 0x570e70
Jan 31 16:27:45 raspberrypi ofonod[5296]: src/ =

modem.c:modem_change_state() old state: 2, new state: 3
Jan 31 16:27:45 raspberrypi ofonod[5296]: Service level connection  =

established
Jan 31 16:27:45 raspberrypi ofonod[5296]: src/ =

network.c:ofono_netreg_status_notify() /hfp/001BDC0365E3_EC59E7D393ED  =

status 1 tech -1
Jan 31 16:27:45 raspberrypi ofonod[5296]: Aborting (signal 11) [/usr/ =

sbin/ofonod]

This happens with ofono 1.6-2 (Debian Wheezy) on a Raspberry Pi.

Any ideas how to fix or work around this issue?

Thanks,
Norbert


--===============0073432121812047327==--

