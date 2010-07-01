Content-Type: multipart/mixed; boundary="===============4705246565611546487=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Crash in at_gprs_context_remove()
Date: Thu, 01 Jul 2010 21:41:28 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F681ACD@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B351F6818E8@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4705246565611546487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Zhang, Zhenhua wrote:
> Hi Kalle,
> =

> Kalle Valo wrote:
>> Hi,
>> =

>> (gdb) bt
>> #0  0x00007ffff790b642 in IA__g_atomic_int_exchange_and_add   =

>> (atomic=3D0x0, val=3D-1) at
>> /build/buildd/glib2.0-2.25.8/glib/gatomic-gcc.c:30 #1
>>    0x00000000004325a3 in g_at_ppp_unref (ppp=3D0x0) at
>> gatchat/gatppp.c:448 #2  0x0000000000448e12 in
>> at_gprs_context_remove (gc=3D0x6e2f50) at
>> drivers/atmodem/gprs-context.c:260 #3  0x00000000004923c9 in =

> =

> As Denis has pointed out, we can add a check for gcd->ppp in
> at_gprs_context_remove() to avoid this crash.
> =

> When I tried to activate & deactivate context on my Huawei
> EM770W modem, I see kernel module usb_serial warning.
> =

> ------------[ cut here ]------------
> WARNING: at
> /build/buildd/linux-2.6.31/drivers/usb/serial/usb-serial.c:460
> serial_ioctl+0x99/0xa0 [usbserial]()
> Hardware name: 7661BL4
> Modules linked in: tun option usbserial usb_storage hidp
> aes_i586 aes_generic ppdev binfmt_misc bridge stp bnep btusb
> joydev snd_hda_codec_analog pcmcia snd_hda_intel snd_hda_codec
> snd_hwdep snd_pcm_oss snd_mixer_oss arc4 snd_pcm ecb
> snd_seq_dummy uvcvideo videodev v4l1_compat snd_seq_oss
> yenta_socket rsrc_nonstatic ricoh_mmc pcmcia_core iwlagn
> iwlcore mac80211 sdhci_pci sdhci psmouse serio_raw
> snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer
> snd_seq_device cfg80211 thinkpad_acpi led_class nvram snd
> soundcore snd_page_alloc heci(C) lp parport usbhid dm_raid45
> xor fbcon tileblit font bitblit softcursor ohci1394 e1000e
> ieee1394 i915 drm i2c_algo_bit video output intel_agp agpgart
> Pid: 5180, comm: ofonod Tainted: G         C 2.6.31-16-generic
> #53-Ubuntu Call Trace:
> [<c014518d>] warn_slowpath_common+0x6d/0xa0
> [<fa3ab689>] ? serial_ioctl+0x99/0xa0 [usbserial]
> [<fa3ab689>] ? serial_ioctl+0x99/0xa0 [usbserial]
> [<c01451d5>] warn_slowpath_null+0x15/0x20
> [<fa3ab689>] serial_ioctl+0x99/0xa0 [usbserial]
> [<c0386414>] ? tty_buffer_flush+0x54/0xe0
> [<fa3ab5f0>] ? serial_ioctl+0x0/0xa0 [usbserial]
> [<c03801b7>] tty_ioctl+0x77/0x620
> [<c0380140>] ? tty_ioctl+0x0/0x620
> [<c01f518c>] vfs_ioctl+0x1c/0x90
> [<c01f0726>] ? putname+0x26/0x40
> [<c01f54b1>] do_vfs_ioctl+0x71/0x310
> [<c01f57af>] sys_ioctl+0x5f/0x80
> [<c01e5939>] ? sys_open+0x29/0x40
> [<c010336c>] syscall_call+0x7/0xb
> ---[ end trace ac231b55ebb1fdca ]---
> =

> When I shutdown the oFono, kernel reports:
> 	tty_port_close_start: tty->count =3D 1 port count =3D 0.
> =

> Any ideas?

I observed the warning shows up when /dev/ttyUSB2 send us any intermediate =
result. If I remove gprs atom and recreate it in huawei_disconnect, the ker=
nel warning is gone. Does anyone see the same problem in other Huawei modem=
? If not, I assume it's a problem only for EM770 modem. (I don't have other=
 Huawei modem at hand)

Thanks,
Zhenhua

>> =

>> --
>> Kalle Valo
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono
> =

> =

> =

> Regards,
> Zhenhua



Regards,
Zhenhua


--===============4705246565611546487==--

