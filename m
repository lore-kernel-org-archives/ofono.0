Content-Type: multipart/mixed; boundary="===============5439405976563130473=="
MIME-Version: 1.0
From: Jason Gauthier <jagauthier@gmail.com>
Subject: Re: read phonebook
Date: Sat, 11 Jun 2016 17:54:30 -0400
Message-ID: <CAHY_EhUdmjzj+1LPpA7yGwL7sNb9JmB5a7u=y3gGUO7Nvhqtyg@mail.gmail.com>
In-Reply-To: <0dd61091-47b6-f58a-09ca-914a964d1ae9@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5439405976563130473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I've done some work with this. Here are a few points I've learned
about dealing with PBAP.
Yes, it definitely requires obexd.   Obexd uses dbus, in session mode.
This implies that the user that runs obex must access the data in the
same session. If you want to run obexd in one shell, and access the
information from another shell, or application, you'll want to use the
system bus like so:

export DBUS_SESSION_BUS_ADDRESS=3D"unix:path=3D/var/run/dbus/system_bus_soc=
ket"
You can validate that with "qdbus --system" in another session. If you
see orf.bluez.obex that you've connected it to the system dbus.

You'll also need to add dbus permissions to access via dbus, or a
non-root user won't even be able to start it.

to /etc/dbus-1/system.d/bluetooth.conf
add:
 <policy user=3D"user">
       <allow own=3D"org.bluez.obex"/>
       <allow send_destination=3D"org.bluez.obex"/>
 </policy>


oh, also, the files downloaded are in vcard format. I would highly
recommend python's vobject module, or similar for ease of managing the
data.

The device needs to be paired and trusted, but it does not have to be
connected to pull PBAP information. I don't think this is important,
but I always found it interesting. All of my code written depends on
the device currently being connected though.

This isn't ofono specific stuff, so if you have any questions you can
email me off list. I also have a git repo out there with some pbap
handling.

I'd like to do more with MAP, and other obex based protocols, but time
is limited.

Jason

On Sat, Jun 11, 2016 at 2:08 PM, Georg Chini <georg@chini.tk> wrote:
> On 11.06.2016 18:41, Marco Trapanese wrote:
>>
>> Hello,
>> I have this setup:
>>
>> - RPi3
>> - Raspbian Jessie Lite
>> - bluez 5.40
>> - ofono 1.18
>>
>> in /etc/bluetooth/main.conf I set this class: 0x640408.
>> Using bluetoothctl I connected my phone to the SBC and I can make a call
>> using the ofono tests.
>>
>> I wonder how to read the contacts. I launched test-phonebook but I got
>> this error:
>>
>>> Method "Import" with signature "" on interface "org.ofono.Phonebook"
>>> doesn't exist
>>
>>
>> Do I need to enable something other before?
>> Thanks
>> Marco
>
>
> Hi Marco,
>
> see attached python script for how to get the phone book from a bluetooth
> device.
> I think you need obexd for this, although I am not quite sure because I
> programmed
> it long ago.
>
> Regards
>               Georg
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============5439405976563130473==--

