Content-Type: multipart/mixed; boundary="===============4618386476763646634=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH udev 11/15] udevng: add legacy device handling functions
Date: Tue, 28 Mar 2017 14:58:37 +0200
Message-ID: <de8da67c-06a2-030f-abd0-8d88d05178c7@southpole.se>
In-Reply-To: <51961e21-7d40-2cec-970b-2d44e218a4a9@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4618386476763646634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/27/2017 05:24 AM, Denis Kenzior wrote:
> Hi Jonas,
>
> On 03/25/2017 11:58 AM, Jonas Bonn wrote:
>> This adds, but does not hook up, functionality to handle devices
>> that are currently handled by the 'legacy' udev.c module.
>>
>> - legacy device is added by calling the add_legacy_device() function.
>> - the function sets up a modem_info and device_info structure for
>>   the legacy device
>> - the device driver is set to "legacy" and the real driver type is
>>   saved in the device_info structure
>> - the extra udev information from the add_*() functions of the old
>>   udev.c module is added to unused fields of the device_info structure
>> - the "legacy" driver is set-up to use setup_legacy
>> - setup_legacy extracts the device_info information and applies it
>>   to the modem in the same way that the add_*() funtions did
>> - the modem driver is switched to the real driver
>>
>> ...and off we go!
>> ---
>> +
>> +    driver =3D udev_device_get_property_value(mdev, "OFONO_DRIVER");
>> +    /* Check that this really is a legacy driver */
>> +    if (!g_strcmp0(driver, "ifx")) goto start;
>> +    if (!g_strcmp0(driver, "u8500")) goto start;
>> +    if (!g_strcmp0(driver, "n900")) goto start;
>> +    if (!g_strcmp0(driver, "calypso")) goto start;
>> +    if (!g_strcmp0(driver, "cinterion")) goto start;
>> +    if (!g_strcmp0(driver, "nokiacdma")) goto start;
>> +    if (!g_strcmp0(driver, "sim900")) goto start;
>> +    if (!g_strcmp0(driver, "wavecom")) goto start;
>
> This might look better as a table

Agreed, but this will disappear when I rework things again.
>> +    /* Maybe this is a USB device... in that case we can grab the
>> +     * vendor and model information
>> +     */
>> +    usb_device =3D udev_device_get_parent_with_subsystem_devtype(mdev,
>> +                            "usb", "usb_device");
>> +    if (usb_device) {
>> +        vendor =3D udev_device_get_property_value(usb_device,
>> +                            "ID_VENDOR_ID");
>> +        model =3D udev_device_get_property_value(usb_device,
>> +                            "ID_MODEL_ID");
>
> Are you sure about this? I don't think there were any usb devices that =

> udev still handled.  Maybe with the exception of some weird CDMA =

> stuff, but that doesn't really work and should be handled via normal =

> udevng mechanisms.

This was a bit unclear to me.  Nothing in the code gives any clue about =

what bus these 'legacy' devices sit on.  If they are all devices with a =

"serial interface", that makes things a bit simpler. I intend to rework =

this patch based on that assumption.
>> +    /* Here we begin the abuse... we want to switch the modem driver
>> +     * from 'legacy' to it's real driver in the setup function, so
>> +     * we store the driver name here in the otherwise unused sysattr
>> +     * field
>> +     */
>> +    info->sysattr =3D g_strdup(driver);
>
> The hi-jacking of device_info attributes is not going to fly.  Why =

> don't we simply get rid of sysattr, and invent a brand new structure =

> to hold the info for 'legacy' (or really true serial port) devices.  =

> The ideal situation would be for us to continue using =

> ofono_modem_set_property for all the driver specific stuff.
>
> Is there a reason why we can't create the modem object here?  The =

> current logic enumerates all the devices and runs create_modem =

> afterwards, but I see no reason why we can't suppress that logic for =

> serial-only devices.
>

Your suggestion to add a new structure for 'legacy'/serial devices was a =

good one.  Reworking things this wasy makes things much simpler and =

serial devices can be handled pretty much exactly as USB devices... the =

symmetry is nice.

We can certainly run create_modem early for the serial devices.   I will =

look into that, but in order to keep things symmetric for a all device =

types it's easier to just use the same delay everywhere. I'll make a =

note to look into that as well.

Thanks for the review.  I'll post a follow-up shortly.

/Jonas


--===============4618386476763646634==--

