Content-Type: multipart/mixed; boundary="===============4463069715611106327=="
MIME-Version: 1.0
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: Re: read phonebook
Date: Sun, 12 Jun 2016 11:23:32 +0200
Message-ID: <27e92148-3e07-af40-5893-03d2bb07a0e2@gmail.com>
In-Reply-To: <CAHY_EhUdmjzj+1LPpA7yGwL7sNb9JmB5a7u=y3gGUO7Nvhqtyg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4463069715611106327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Georg, hello Jason!
Thank you both for your interesting answers.
As far as I understand obex is now integrated in bluez5:

> https://packages.debian.org/jessie/bluez-obexd

> http://www.bluez.org/page/7/

(see Release of BlueZ 5.0)

> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/obex-api.txt


Thus my confusion about the test script in ofono!
So, if I'm running off-topic, I will move to the bluez mailing-list.

Anyway, following the hints of Jason I exported the dbus session address =

(because I don't use X) and set the dbus policies in bluetooth.conf. I =

paired and trusted my phone.

Running the bluez/test/pbap-client script or the Georg's code leads to:

> dbus.exceptions.DBusException: org.freedesktop.DBus.Error.ServiceUnknown:=
 The name org.bluez.obex was not provided by any .service files

while the ofono/test/test-phonebook returns:

> dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: =
Method "Import" with signature "" on interface "org.ofono.Phonebook" doesn'=
t exist

Because obex is under org.bluez I don't think I need the obexd-client =

Debian package, do I?

Thanks!
Marco

--



Il 11/06/2016 23:54, Jason Gauthier ha scritto:
> I've done some work with this. Here are a few points I've learned
> about dealing with PBAP.
> Yes, it definitely requires obexd.   Obexd uses dbus, in session mode.
> This implies that the user that runs obex must access the data in the
> same session. If you want to run obexd in one shell, and access the
> information from another shell, or application, you'll want to use the
> system bus like so:
>
> export DBUS_SESSION_BUS_ADDRESS=3D"unix:path=3D/var/run/dbus/system_bus_s=
ocket"
> You can validate that with "qdbus --system" in another session. If you
> see orf.bluez.obex that you've connected it to the system dbus.
>
> You'll also need to add dbus permissions to access via dbus, or a
> non-root user won't even be able to start it.
>
> to /etc/dbus-1/system.d/bluetooth.conf
> add:
>  <policy user=3D"user">
>        <allow own=3D"org.bluez.obex"/>
>        <allow send_destination=3D"org.bluez.obex"/>
>  </policy>
>
>
> oh, also, the files downloaded are in vcard format. I would highly
> recommend python's vobject module, or similar for ease of managing the
> data.
>
> The device needs to be paired and trusted, but it does not have to be
> connected to pull PBAP information. I don't think this is important,
> but I always found it interesting. All of my code written depends on
> the device currently being connected though.
>
> This isn't ofono specific stuff, so if you have any questions you can
> email me off list. I also have a git repo out there with some pbap
> handling.
>
> I'd like to do more with MAP, and other obex based protocols, but time
> is limited.
>
> Jason
>
> On Sat, Jun 11, 2016 at 2:08 PM, Georg Chini <georg@chini.tk> wrote:
>> On 11.06.2016 18:41, Marco Trapanese wrote:
>>>
>>> Hello,
>>> I have this setup:
>>>
>>> - RPi3
>>> - Raspbian Jessie Lite
>>> - bluez 5.40
>>> - ofono 1.18
>>>
>>> in /etc/bluetooth/main.conf I set this class: 0x640408.
>>> Using bluetoothctl I connected my phone to the SBC and I can make a call
>>> using the ofono tests.
>>>
>>> I wonder how to read the contacts. I launched test-phonebook but I got
>>> this error:
>>>
>>>> Method "Import" with signature "" on interface "org.ofono.Phonebook"
>>>> doesn't exist
>>>
>>>
>>> Do I need to enable something other before?
>>> Thanks
>>> Marco
>>
>>
>> Hi Marco,
>>
>> see attached python script for how to get the phone book from a bluetooth
>> device.
>> I think you need obexd for this, although I am not quite sure because I
>> programmed
>> it long ago.
>>
>> Regards
>>               Georg
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>


--===============4463069715611106327==--

