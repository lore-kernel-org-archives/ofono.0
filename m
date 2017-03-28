Content-Type: multipart/mixed; boundary="===============6107338544420557176=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH udev 14/15] udevng: get properties from interface
Date: Tue, 28 Mar 2017 10:20:42 -0500
Message-ID: <12077890-869d-a7bd-26ba-ea05341df5f3@gmail.com>
In-Reply-To: <63054479-a800-b0b9-0f11-4855b28f59d6@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6107338544420557176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>>>      label =3D udev_device_get_property_value(device, "OFONO_LABEL");
>>> +    if (!label) {
>>> +        label =3D udev_device_get_property_value(intf, "OFONO_LABEL");
>>> +    }
>>
>> Okay, but not really our style.  See doc/coding-style.txt item M1
>
> Hmmm.... I would say that this is essentially the 'variable allocation'
> clause of M1.  Set a value; if fail, then do something about it.  Agree?
>

Yes, but the subsystem assignment on the next line still needs to be =

separated by an empty line.  Also the {} around the if are not needed.


>>>
>>>      driver =3D udev_device_get_property_value(usb_device,
>>> "OFONO_DRIVER");
>>> +    if (!driver) {
>>> +        intf =3D udev_device_get_parent_with_subsystem_devtype(device,
>>> +                        "usb", "usb_interface");
>>> +        if (intf)
>>> +            driver =3D udev_device_get_property_value(
>>> +                            intf, "OFONO_DRIVER");
>>> +    }
>>
>> doc/coding-style.txt item M1
>
> My comment above applies... allocate and handle failure to allocate.

If you declare & assign a variable, we prefer an empty line.  e.g.

if () {
	foo *bar =3D baz;

	if (bar)
		// do something
}

Also, the original comment was about the two if statements not being =

separated out.  So you have:

if (!driver) {
	...
}
if (driver =3D=3D NULL)

Regards,
-Denis

--===============6107338544420557176==--

