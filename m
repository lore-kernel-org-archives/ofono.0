Content-Type: multipart/mixed; boundary="===============2037163076042606200=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: nokia-modem (N900) not detected after migration to udevng
Date: Thu, 07 Sep 2017 18:17:41 -0700
Message-ID: <20170908011741.GC3@computer.craftyguy.net>
In-Reply-To: <7333b099-d68f-80d3-ddb5-a36693f420b0@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2037163076042606200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is on HSI bus. I am running ofono on the N900 (not tethering).

From what I understand, I am loading all of the necessary drivers for
this to work (nokia-modem, which pulls in its dependencies
automaticall). =

As I stated in my original note, before moving 'legacy
device' initialization to udevng, ofono would at least 'see' the
modem. The test script 'list-modems' would list it, now it does not
list anything.

-Clayton
On Fri, Sep 08, 2017 at 03:13:03AM +0200, Jonas Bonn wrote:
>On 09/08/2017 02:51 AM, Clayton Craft wrote:
>>Hi,
>>I've been debugging why the n900 modem is not recognized by ofono
>>for a few days now, and have determined that the cause is because the
>>calls in udevng to udev_device_get_devnode return NULL. It seems that
>>the nokia-modem driver does not create any device nodes under /dev.
>
>What bus does this modem sit on?  Are you running ofono _on_ the N900 =

>or are you trying to tether the N900 to some system with ofono?
>
>If you are tethering, what udev events do you get when you plug in the =

>modem?  Try running "udevadm monitor" and watch what happens when you =

>plug the modem in.
>
>Not getting a device node sounds mostly like there's a driver missing, =

>though...
>
>/Jonas
>
>>
>>This seems to be a regression in functionality since the move to
>>udevng as previous versions of ofono seem to detect the n900 modem
>>correctly (right before this commit =

>>3ac449e25fc8cb9880c48b8f309189c6a644f200)
>>This issue occurs from this commit onwards, including the latest commit
>>as of this mail.
>>
>>https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/udevn=
g.c#n1316
>>
>>
>>-Clayton
>>
>>_______________________________________________
>>ofono mailing list
>>ofono(a)ofono.org
>>https://lists.ofono.org/mailman/listinfo/ofono
>
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>https://lists.ofono.org/mailman/listinfo/ofono


--===============2037163076042606200==--

