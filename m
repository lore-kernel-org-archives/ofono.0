Content-Type: multipart/mixed; boundary="===============3598490421933243838=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: qmi on huawei
Date: Mon, 26 Nov 2012 17:42:40 +0100
Message-ID: <CABvLYuBKGB6foJqo0CXdkXpfKUjCtNPU=Jh=bAS67oS6UYr1FA@mail.gmail.com>
In-Reply-To: <1353943844.1837.2.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3598490421933243838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,


> The ofono.git HEAD already sets the driver, but the qmi and net
> detection is not always correct. So just overwrite the values for the
> device nodes and see if that works for you.
>
> Thanks for the suggestion, i started on this before this change was
commited.
I also had the issue to detect qmi, because udev doesn't export the usb
properties for cdc-wdm devices.
The patch i did for this, is check ID_VENDOR_ID and ID_MODEL_ID of
usb_device instead of device in check_usb_devices().

Using the gobi driver for the E398, it looks like there's a memory leak of
qmi_service when plugging/unplugging the device.

thanks,
Cedric

--===============3598490421933243838==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgTWFyY2VsLDxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj48ZGl2PqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+ClRoZSBvZm9uby5naXQgSEVBRCBhbHJlYWR5IHNldHMgdGhlIGRyaXZlciwg
YnV0IHRoZSBxbWkgYW5kIG5ldDxicj4KZGV0ZWN0aW9uIGlzIG5vdCBhbHdheXMgY29ycmVjdC4g
U28ganVzdCBvdmVyd3JpdGUgdGhlIHZhbHVlcyBmb3IgdGhlPGJyPgpkZXZpY2Ugbm9kZXMgYW5k
IHNlZSBpZiB0aGF0IHdvcmtzIGZvciB5b3UuPGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+VGhh
bmtzIGZvciB0aGUgc3VnZ2VzdGlvbiwgaSBzdGFydGVkIG9uIHRoaXMgYmVmb3JlIHRoaXMgY2hh
bmdlIHdhcyBjb21taXRlZC48L2Rpdj48ZGl2PkkgYWxzbyBoYWQgdGhlIGlzc3VlIHRvIGRldGVj
dCBxbWksIGJlY2F1c2UgdWRldiBkb2VzbiYjMzk7dCBleHBvcnQgdGhlIHVzYiBwcm9wZXJ0aWVz
IGZvciBjZGMtd2RtIGRldmljZXMuPC9kaXY+CjxkaXY+VGhlIHBhdGNoIGkgZGlkIGZvciB0aGlz
LCBpcyBjaGVjayBJRF9WRU5ET1JfSUQgYW5kIElEX01PREVMX0lEIG9mIHVzYl9kZXZpY2UgaW5z
dGVhZCBvZiBkZXZpY2UgaW4gY2hlY2tfdXNiX2RldmljZXMoKS48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PlVzaW5nIHRoZSBnb2JpIGRyaXZlciBmb3IgdGhlIEUzOTgsIGl0IGxvb2tzIGxpa2Ug
dGhlcmUmIzM5O3MgYSBtZW1vcnkgbGVhayBvZiBxbWlfc2VydmljZSB3aGVuIHBsdWdnaW5nL3Vu
cGx1Z2dpbmcgdGhlIGRldmljZS48L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj50aGFua3MsPC9k
aXY+PGRpdj5DZWRyaWM8L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============3598490421933243838==--

