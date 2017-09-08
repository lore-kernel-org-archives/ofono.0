Content-Type: multipart/mixed; boundary="===============8751991844480231093=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: nokia-modem (N900) not detected after migration to udevng
Date: Fri, 08 Sep 2017 03:29:27 +0200
Message-ID: <0b611248-8735-aaf4-4f6a-6d4209014840@southpole.se>
In-Reply-To: <20170908011741.GC3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8751991844480231093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/08/2017 03:17 AM, Clayton Craft wrote:
> This is on HSI bus. I am running ofono on the N900 (not tethering).

OK, from what I understand, you should be able to find this device under =

/sys/class/net/....

See if you can find the device there and run:

udevadm info --query all --path /sys/class/net/....
and
udevadm info --attribute-walk --path /sys/class/net.....

Post that output here if it's sane so that we can see what info udev is =

giving you for the device.

/Jonas

>
> From what I understand, I am loading all of the necessary drivers for
> this to work (nokia-modem, which pulls in its dependencies
> automaticall). As I stated in my original note, before moving 'legacy
> device' initialization to udevng, ofono would at least 'see' the
> modem. The test script 'list-modems' would list it, now it does not
> list anything.
>
> -Clayton
> On Fri, Sep 08, 2017 at 03:13:03AM +0200, Jonas Bonn wrote:
>> On 09/08/2017 02:51 AM, Clayton Craft wrote:
>>> Hi,
>>> I've been debugging why the n900 modem is not recognized by ofono
>>> for a few days now, and have determined that the cause is because the
>>> calls in udevng to udev_device_get_devnode return NULL. It seems that
>>> the nokia-modem driver does not create any device nodes under /dev.
>>
>> What bus does this modem sit on?  Are you running ofono _on_ the N900 =

>> or are you trying to tether the N900 to some system with ofono?
>>
>> If you are tethering, what udev events do you get when you plug in =

>> the modem?  Try running "udevadm monitor" and watch what happens when =

>> you plug the modem in.
>>
>> Not getting a device node sounds mostly like there's a driver =

>> missing, though...
>>
>> /Jonas
>>
>>>
>>> This seems to be a regression in functionality since the move to
>>> udevng as previous versions of ofono seem to detect the n900 modem
>>> correctly (right before this commit =

>>> 3ac449e25fc8cb9880c48b8f309189c6a644f200)
>>> This issue occurs from this commit onwards, including the latest commit
>>> as of this mail.
>>>
>>> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/ude=
vng.c#n1316 =

>>>
>>>
>>>
>>> -Clayton
>>>
>>> _______________________________________________
>>> ofono mailing list
>>> ofono(a)ofono.org
>>> https://lists.ofono.org/mailman/listinfo/ofono
>>
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono



--===============8751991844480231093==--

