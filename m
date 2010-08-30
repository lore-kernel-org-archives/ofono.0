Content-Type: multipart/mixed; boundary="===============4682481549070057727=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Add: n900modem driver
Date: Mon, 30 Aug 2010 16:03:28 -0500
Message-ID: <4C7C1CA0.9030007@gmail.com>
In-Reply-To: <AANLkTinVYbHMGn7Pi+0Juhng+sTBPDP+OWzqm55He-Uz@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4682481549070057727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 08/30/2010 09:23 AM, Aki Niemi wrote:
> Hi,
> =

> 2010/8/17 Denis Kenzior <denkenz@gmail.com>:
>> Why are we doing this inside n900modem?  Can't we simply:
>>
>> 1. Make isimodem/isimodem.c register these (just like atmodem, stemodem,
>> mbmmodem, etc does)
>> 2. Rip out the actual modem driver out of isimodem/isimodem.c
>> 3. Have plugins/n900.c contain the modem driver?
> =

> I think you mean rip out the modem driver in isimodem/isimodem.c, and
> put it in usbpnmodem.c? I think that makes sense.

Item #1 referred to isi_foo_init() and isi_foo_exit() being performed in
the n900modem plugin.  That should be done by drivers/isimodem/isimodem.c...

Ripping out modem driver (not atom driver) stuff out of
drivers/isimodem/isimodem.c and moving it into plugins/ somewhere is a
good idea though.

> =

>>> -     /* Expect phonet interface name usbpn<idx> */
>>> -     if (strncmp(ifname, "usbpn", 5) ||
>>> -             ifname[5 + strspn(ifname + 5, "0123456789")])
>>> +     if (match_ifname("usbpn", ifname)) {
>>> +             driver =3D "isimodem";
>>> +             address =3D PN_DEV_PC;
>>> +     } else if (strcmp("phonet0", ifname) =3D=3D 0) {
>>> +#if HAVE_N900MODEM
>>> +             driver =3D "n900modem";
>>> +#else
>>> +             driver =3D "isimodem";
>>> +#endif
>>
>> And this really needs to go...
> =

> Couldn't we rather either build support for native modem or USB
> modems, but not both at the same time? In other words, build only one
> or the other of these two plugins.
> =


I'm still a little fuzzy what is happening here actually.  Correct me if
I'm wrong, but you have a USB serial device that is either the 'real'
serial port (e.g. on the N900 running natively) or a serial port
exported over USB.  Depending on which one it is, you want to use either
the n900 driver or the isimodem driver.

My strong preference is not to have any #ifdefs or configure switches
for this.

Is there any way to detect whether this is running natively?

Regards,
-Denis

--===============4682481549070057727==--

