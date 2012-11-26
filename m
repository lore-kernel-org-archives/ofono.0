Content-Type: multipart/mixed; boundary="===============4764138719143176796=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: qmi on huawei
Date: Mon, 26 Nov 2012 17:42:41 +0100
Message-ID: <1353948161.1837.6.camel@aeonflux>
In-Reply-To: <CABvLYuBKGB6foJqo0CXdkXpfKUjCtNPU=Jh=bAS67oS6UYr1FA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4764138719143176796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

> > The ofono.git HEAD already sets the driver, but the qmi and net
> > detection is not always correct. So just overwrite the values for the
> > device nodes and see if that works for you.
> >
> > Thanks for the suggestion, i started on this before this change was
> commited.
> I also had the issue to detect qmi, because udev doesn't export the usb
> properties for cdc-wdm devices.
> The patch i did for this, is check ID_VENDOR_ID and ID_MODEL_ID of
> usb_device instead of device in check_usb_devices().
> =

> Using the gobi driver for the E398, it looks like there's a memory leak of
> qmi_service when plugging/unplugging the device.

that might be possible. Can you give me some valgrind traces or similar
so I can see where this might be coming from.

Regards

Marcel



--===============4764138719143176796==--

